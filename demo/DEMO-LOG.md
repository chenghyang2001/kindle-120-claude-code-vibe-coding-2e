# K120 範例演練紀錄

- 日期：2026-10-05
- 機器：家用機（Windows 10、Git Bash）
- 環境：Claude Code 2.1.289、uv 0.10.4、Node 24、ffmpeg 8.0
- 原則：`code/` 底下的子模組**完全不修改**
  - 執行產物都放在 `demo/`
  - 需要改的東西（例如虛擬環境、hook 設定）另外建在 `demo/work/`
  - 演練結束時 11 個子模組的 `git status` 全部是 0

## 總覽

| 章 | 演練內容 | 結果 | 主要發現 |
| --- | --- | --- | --- |
| 1 | — | 略過 | 只有安裝命令，本機已安裝 |
| 2 | PDF 浮水印：命令列＋網頁 API＋網頁畫面 | ✅ | 三種頁面尺寸都有正確加上浮水印；前端沒有照 2-4 節的規則拆成三個檔 |
| 3 | — | 略過 | 純說明，重點已整理進 `book-summary.md` |
| 4 | 4-1 翻譯、4-2 並行、4-3 審查（`claude -p` 實跑） | ✅ | 沒有明確指定時，主 agent 會自己做；並行版寫檔快約 1.8 倍，但成本高 85% |
| 5 | 臺灣房價地圖：重現 bug、找出根因、驗證修正 | ✅ | 兩個刻意埋的 bug：變數名稱不一致、傳錯物件 |
| 6 | Hook 10 個情境（`claude -p` 實跑） | ✅ 10/10 | 結果全部和書上一致；`updatedInput` 會讓模型被誤導而不自知 |
| 7 | 訂餐系統：用 `claude -p` 分析真實菜單＋下單寫入 Excel | ✅ | 分析出 46 個品項，花 2 分 15 秒；有安全疑慮（見下方） |
| 8 | 四個版本的出題器效能評測＋網頁版畫面 | ⚠️ | subagent 版的 hard／expert 難度 180 秒內出不了一題 |
| 9 | YouTube 轉投影片：後端處理＋React 前端 | ✅（要繞過問題） | 鎖定 Python 3.9 導致 yt-dlp 太舊，下載失敗 |

---

## 第 2 章　PDF 浮水印工具（`ch02-F6757_ch02`）

**命令列版**：先 `uv run create_test_pdf.py` 產生測試檔，再 `uv run watermark.py test.pdf`。

| 頁 | 尺寸 (pt) | 浮水印 |
| --- | --- | --- |
| 1 | 595×842（A4） | ✅ |
| 2 | 612×792（Letter） | ✅ |
| 3 | 842×1191（A3） | ✅ |

- 截圖：`screenshots/ch02-wm-1..3.png`
- 產物：`outputs/ch02-test_wm-confidential.pdf`

**網頁版**：不帶參數執行 `uv run watermark.py`，會在 port 5050 啟動 FastAPI。

- API 端對端測試：上傳 → `/api/watermark`（`watermark_text: "WEB TEST"`）→ 下載。3 頁都含 `WEB TEST`。
- 畫面：`screenshots/ch02-web-ui.jpg`。版面和 PRD 一致，在還沒上傳檔案前，「輸出檔名」欄位是停用的。

**發現**

1. **API 欄位名稱和直覺不同**：欄位叫 `watermark_text`，不是 `text`。傳錯欄位不會報錯，Pydantic 會直接忽略，然後套用預設的 Confidential。
2. **前端沒有照 2-4 節的規則**：`front_end/index.html` 是一個檔案包辦全部 CSS 和 JS，沒有拆成 html／css／js 三個檔。推測 repo 是在加入規則之前的版本。
3. **背景色跟著系統主題走**：頁面用 `prefers-color-scheme` 切換。淺色模式是粉色系，深色模式才是 PRD 要求的「高科技感」青藍色。

## 第 4 章　Subagent（`ch04-F6757_ch04` 的 `en.txt`）

**做法**：用 `claude -p --agents <JSON>` 定義書中的 subagent，並加上 `--restricted --strict-mcp-config --tools`，限制只能用指定的工具。

### 4-1 翻譯員

| 提示詞 | 誰執行 | 耗時 | 成本 |
| --- | --- | --- | --- |
| 「將專案內 en.txt 內容翻譯成繁體中文」 | **主 agent 自己翻** | 11.5 秒 | $0.051 |
| 「幫我用 @"technical-translator (agent)" 將……翻譯」 | subagent（Read 和 Write 的 `parent_tool_use_id` 都指向那次 Agent 呼叫） | 25.0 秒 | $0.095 |

這正是書中安排兩句提示詞要示範的重點：**不明確指名時，主 agent 會判斷自己做就好。**
兩份譯文：`outputs/ch04-zh-main.txt`、`outputs/ch04-zh-subagent.txt`。

### 4-2 並行（題目縮小成 3 種語言 × 2 種排序法）

| 模式 | 工具呼叫 | 寫檔期間 | 成本 |
| --- | --- | --- | --- |
| 單一 agent | 主 agent 依序 Write 6 次 | 16 秒 | $0.139 |
| 3 個 subagent 並行 | 3 次 Agent 呼叫，每個 subagent 各 Write 2 次 | 9 秒 | $0.258 |

任務這麼小時，啟動 subagent 的固定開銷會吃掉並行省下的時間，總時間只差約 4 秒，成本卻多了 85%。書中用的是 7 種語言 × 5 種排序法，規模大才看得出並行的好處。

### 4-3 審查員

用 `personal-code-reviewer` 比較兩種模式產出的 Rust 程式碼，結論是**品質幾乎打平**（6.4 對 6.5 分）。

- 單一 agent 版用了泛型，介面比較通用。
- subagent 版的快速排序取中間元素當基準值，比較不會遇到最壞情況。
- 兩版都有同樣的大問題：Lomuto 分割遇到大量重複值會退化成 O(n²)。

全文：`outputs/ch04-review.md`。

4-4 新聞團隊需要上網搜尋，這次沒有跑。

## 第 5 章　臺灣房價地圖（`ch05-test_buyhouse`，`update_data` 分支）

**重現書中 5-2 例一**：執行 `uv run wsgi.py` 後，「趨勢圖」和「長條圖」都是空的（`screenshots/ch05-before-fix.jpg`）。Console 有兩個錯誤：

| # | 錯誤 | 根因 |
| --- | --- | --- |
| 1 | `ReferenceError: graphTrend is not defined`（`app/templates/index.html:571`） | 第 570 行宣告的變數叫 `graph`，第 571 行卻用 `graphTrend` |
| 2 | `TypeError: Cannot read properties of undefined (reading 'map')`（`map.js:87`） | `updateChart(currentCityData)` 傳進去的是空物件，應該傳 AJAX 回傳的 `data`。`map.js:35-36` 也有同樣的問題，而且「先使用、後指定」的順序是反的 |

**驗證修正**：沒有改程式碼，而是在瀏覽器裡用修正後的寫法重新畫圖。趨勢圖畫出 2 條線、長條圖畫出 3 組，畫面正常（`screenshots/ch05-after-fix.jpg`）。

**其他觀察**

- 首頁載入 `/static/js/sb-admin-2.min.js` 會得到 404，但不影響功能。
- 5-3、5-4 需要另外安裝 Playwright 的 MCP 和 CLI，這次沒有跑。不過上面用 Claude in Chrome 讀 Console 找 bug，等於已經完整做了一次 5-2 的流程。

## 第 6 章　Hook（`ch06-F6757_ch06_todo-system`）

**做法**

- 每個情境都從子模組 `git archive` 出一份乾淨副本，放在 `demo/work/ch06/runs/<情境>/`，互不干擾。
- hook 設定用 `--settings` 傳入（檔案在 `demo/work/ch06/settings/`）。
- 加上 `--setting-sources project`，排除使用者層的全域 hook，避免干擾結果。
- 逐筆紀錄：`logs/ch06-hooks.log`

| 情境 | 設定 | 提示詞 | `tasks.json` | 和書一致 |
| --- | --- | --- | --- | --- |
| t1 | PreToolUse `exit 2` | 把第 1 個任務改成完成 | 未變；Claude 看到 `No stderr output` | ✅ |
| t2 | PostToolUse `exit 2` | 把第 2 個任務改成未完成 | **已改**（事後才執行，擋不住） | ✅ |
| t3 | PreToolUse `exit 1` | 移除第 3 個任務 | **已改**（只有 exit 2 會阻擋） | ✅ |
| t4 | 先寫 stderr 再 `exit 2` | 新增第 4 個任務 | 未變；Claude 引用了原因 | ✅ |
| t5 | JSON `deny` 加上原因 | 新增任務 | 未變 | ✅ |
| t6 | JSON `updatedInput`：Read 一律改讀 `data/tasks.json` | 讀 pyproject.toml | — | ✅（見下方） |
| t7a | `if: "Bash(rm *)"` 時 deny | 用 `rm` 刪除 delete.txt | 檔案還在 | ✅ |
| t7b | 同上 | 用 `touch` 建立 add.txt | 成功建立 | ✅ |
| t8a | `type: "prompt"` 交給模型判斷 | `cat .env` | 被擋，模型說明了理由 | ✅ |
| t8b | 同上 | `head src/todo.py` | 放行 | ✅ |

**發現**

1. **t6 最值得注意**：Claude 以為自己讀的是 `pyproject.toml`，拿到的其實是 `tasks.json` 的內容，於是得出「這個檔案其實是 JSON 待辦清單」這個錯誤結論。`updatedInput` 改寫工具輸入時模型完全不知情，**只適合拿來加安全限制，不適合拿來偷換內容**。
2. **t1、t5 被擋之後 Claude 很守規矩**：它說明自己「沒有改用 Write 或 shell 指令硬寫進去」，沒有嘗試繞過 hook。
3. **t8a 被擋之後最後回覆是空字串**（`result: ''`）：prompt 型 hook 擋下後，模型沒有給任何收尾說明。
4. **prompt 型 hook 的回應格式**：模型要回 `{"ok": true}` 或 `{"ok": false, "reason": "..."}`，`reason` 會原文傳給 Claude。
5. 6-3 的 Telegram 通知需要互動式 session 才會觸發 Notification 事件，`-p` 模式測不到，這次沒有跑。

## 第 7 章　旗標訂餐系統（`ch07-order-sheet`）

- **書中 7-4 的完成版**：後端用 `curl` 抓菜單網頁，抓到的文字少於 500 字時改用 Playwright，再交給 `claude -p` 萃取成 JSON。
- **菜單分析**：`POST /api/analyze {"url":"https://kebuke.com/menu/"}`，花 **2 分 15 秒**得到 **46 個品項**。每個品項都有杯型、甜度、冰塊、加料四組選項（`outputs/ch07-kebuke-menu.json`）。
- **前端實測**：在瀏覽器貼上網址、按「分析菜單」，約 2 分鐘後顯示品項卡片和分享連結（`screenshots/ch07-menu-cards.jpg`）。
- **下單**：`POST /api/order` 回 201，`orders.xlsx` 正確寫入表頭和一筆資料（`outputs/ch07-orders.xlsx`）。

**發現：安全疑慮**（教學範例可以接受，但不能直接上線）

1. **`subprocess.run('claude -p', shell=True)`**（`app.py:76`）
   - 繼承使用者的全域權限、hook 和 MCP
   - 經過 `cmd.exe` 解析
   - 逾時時只會殺掉 shell，殺不到底下的 claude 子行程
   - 安全寫法請參考 K99 `study04-claude-p`
2. **SSRF 風險**：使用者提供的網址直接交給 `curl -sL`，沒有限制協定和網域。`curl` 也支援 `file://`，可能被拿來讀取本機檔案。
3. **服務開在 `0.0.0.0:5000`**：分享連結用的是區網 IP（設計如此），但 API 沒有任何驗證，同網段的人都能呼叫。
4. **實測踩到的坑**
   - 後端的 `claude -p` 以專案資料夾為 cwd，我的全域 session-state hook 因此在子模組裡寫了 `.claude/session-state.md`。已刪除，子模組恢復乾淨。
   - Git Bash 的 curl 送中文 JSON 會變成 400，改用 Python urllib 就正常。

## 第 8 章　數獨四種開發方式

| repo | 開發方式 | 技術 |
| --- | --- | --- |
| `ch08-AI-session-sudoku-game` | 8-2 直接對話 | 純網頁（HTML/CSS/JS） |
| `ch08-PRD-sudoku` | 8-3 先寫 PRD | tkinter |
| `ch08-subagent-sudoku` | 8-4 subagent 分工 | pygame |
| `ch08-grill-me-sudoku` | 8-5 grill-me | pygame-ce |

同一份 PRD，三個 Python 版本用了三種不同的 GUI 函式庫。

**出題器評測**（`logs/ch08-generator-bench.log`）

- 每個難度用 seed 1–5 各出一題
- 解的唯一性用獨立撰寫的 MRV 解題器驗證（找到 2 組解就停）

| 版本 | easy | medium | hard | expert | 唯一解／解答正確／題目和解答一致 |
| --- | --- | --- | --- | --- | --- |
| PRD | 0.009 秒 | 0.026 秒 | 0.045 秒 | 0.441 秒 | 全部 5/5 |
| grill-me | 0.006 秒 | 0.027 秒 | 0.619 秒（最慢 1.6） | **4.8 秒（最慢 9.1）** | 全部 5/5 |
| subagent | 0.003 秒 | 0.004 秒 | **單題超過 180 秒** | **單題超過 180 秒** | easy／medium 5/5 |

**發現**

1. **subagent 版的 hard／expert 實際上用不了**：seed=1 單獨計時，180 秒內都出不了一題（`logs/ch08-subagent-hard.log`）。
   - 原因：出題器最多嘗試 10 次（`MAX_ATTEMPTS = 10`），每次都要做完整的技巧分級。
   - 這正好對應書中 8-4 最後那句修改提示：「高難度題目生成過慢」。repo 保留的是修正**之前**的版本。
2. **grill-me 版難度最精準**：每種難度的提示數量完全固定，例如 hard 一律 27 個、easy 一律 45 個。PRD 版是範圍值，例如 hard 是 26–30 個。
3. **PRD 版整體最快也最穩**：「最小剩餘值啟發法＋回溯」寫在 PRD 裡，確實被照做了。
4. **網頁版**：點「困難」幾乎瞬間就出題（`screenshots/ch08-web-home.jpg`、`ch08-web-hard.jpg`）。
5. **subagent 版的測試**：`test_quick.py` 通過，但它寫死了作者電腦的路徑 `C:\Users\Admin\subagent sudoku`。剛好在 repo 目錄下執行才沒出錯。
6. 三個 Python 桌面版的 GUI 這次沒有截圖。

## 第 9 章　YouTube 轉投影片（`ch09-YouTube2Slides`）

**第一次執行失敗**：`POST /api/video/info` 成功，但 `/api/video/process` 失敗，錯誤是 `[youtube] ... The page needs to be reloaded`。

**根因鏈**

1. `backend/.python-version` 鎖定 **3.9**
2. yt-dlp 新版已不支援 3.9，就算 `uv pip install -U yt-dlp` 也只能升到 **2025.10.14**
3. 這個版本的 YouTube 解析已經失效

**驗證**：用 Python 3.12 執行 yt-dlp 2026.08.19，同一支影片，不論 `player_client=android` 或預設都能正常解析。

**繞過方式（沒有改 repo）**：在 `demo/work/ch09-venv312` 建一個 Python 3.12 虛擬環境，安裝 `pyproject.toml` 的相依套件，再升級 yt-dlp，然後用這個環境啟動 `backend/app.py`。

**成功結果**

- 書中的測試影片 `I40S5yBmaiw`（19 分鐘，有手動 zh-TW 字幕），用 360p 處理
- **66 秒產出 421 張投影片**（`outputs/ch09-job.json`）
- React 前端（`npm start`，port 3000）的首頁和投影片檢視都正常，側邊欄有歷史紀錄（`screenshots/ch09-home.jpg`、`ch09-slides.jpg`）

**其他發現**

- 畫質選項只有 `360`／`480`／`720`，沒有 9-1 提示詞裡提到的 1080p；傳 `"360p"` 會得到 422 錯誤。
- 前端編譯時只有 unused-vars 警告。
- AI 翻譯、AI 大綱、語音辨識字幕都需要 API key，這次沒有測。

## 跨章節踩坑（Windows）

1. **debug reloader 的子行程會留下來佔著 port**
   - Flask `debug=True` 和 uvicorn `reload=True` 都會另外開一個子行程
   - 只殺父行程的話，子行程會繼續佔著 port。ch05 的 5000、ch09 的 8000 都遇到，舊版服務還在回應，造成誤判
   - 解法：用 `Get-NetTCPConnection` 找出實際佔用 port 的 PID，再往下追子行程一起殺掉
2. **用指令內容比對來殺行程，會把自己也殺掉**：用 `-match 'YouTube2Slides'` 比對時，發出指令的那個 bash 本身也符合條件，結果被一起終止。
3. **MSYS 路徑要轉換**：`claude --settings /c/Users/...` 會被解讀成 `C:\c\Users\...`，要先用 `cygpath -w` 轉換。
