# K120 第 1–9 章快速模式重跑（另一台家用電腦）

> 目的：在另一台家用電腦（Windows 11、cmd）用**快速 demo 模式**把第 1–9 章重跑一遍，
> 看懂書上的流程，並和原機器的結果比對。
> 不做旁白稿、字幕影片（不用 VLC、edge-tts），說明一律在聊天視窗用文字。

- 提示詞原文：`code/00-F6757_support/chNN.md`（下面只寫「指向哪一節」，不整段抄書）
- 原機器的結果：`demo/DEMO-LOG.md`、`teaching/HANDOFF.md` 第 2 節
- 快速模式的原理、實測數據與代價：`teaching/steps/fast-demo.md`
- 進度：每章結束更新 `teaching/HANDOFF.md` 的「快速模式進度表」

## 總覽

| 章 | 練習資料夾（`%USERPROFILE%\workspace\` 底下） | 預估時間 | 可以平行嗎 |
| --- | --- | --- | --- |
| 1 | `k120-ch01-practice` | 15 分 | 否（要先確認安裝狀態，建議第一個做） |
| 2 | `k120-ch02-practice`＋worktree `k120-ch02-practice-web` | 40 分 | 可，和第 4 章一起 |
| 3 | 沿用 `k120-ch02-practice-web` | 15 分 | 否（要等第 2 章做完，且不可和第 2 章同時開） |
| 4 | `k120-ch04-practice` | 30 分 | 可，和第 2 章一起 |
| 5 | `k120-ch05-practice`（clone 範例） | 30 分 | 可，和第 6 章一起 |
| 6 | `k120-ch06-practice`（clone 範例） | 40 分 | 可，和第 5 章一起 |
| 7 | `k120-ch07-practice`（只做 7-1） | 10 分 | 可，和任何一章一起 |
| 8 | `k120-ch08-practice-chat`／`-prd`／`-sub`／`-grill` | 30 分（四個同時跑） | 可，四個資料夾同時跑 |
| 9 | `k120-ch09-practice`（只做書上 4 步） | 60 分 | 建議單獨跑（下載影片、ffmpeg 較吃資源） |

預估時間是依原機器記錄推估（見 fast-demo.md「預估效果」），實際以跑過為準。
資料夾名稱和原機器一致，方便對照原機器的對話記錄。

## 快速模式三件事（細節見 `teaching/steps/fast-demo.md`）

1. **關掉 writer-QA hook**：`set DISABLE_WRITER_QA_HOOK=1`。
   用 `teaching\tools\fast-start.bat <練習資料夾>` 啟動就會自動設好，只對它啟動的那個 claude 有效。
2. **練習資料夾的 CLAUDE.md 加上「本專案例外」**：豁免三 agent 鐵律、不問複雜度、不問要不要用快速模式。
   `fast-start.bat` 會自動追加，已經有就不重複加。
3. **提示詞前面加「速度優先」**那一段（fast-demo.md ②）。
   例外：grill-me（第 8 章第 4 步）和 Plan 模式訪談（第 9 章第 1 步）**不要**加「選擇題直接採用建議」那一行。

`fast-start.bat` 用法（cmd）：

```bat
cd /d %USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
teaching\tools\fast-start.bat k120-ch02-practice
```

- 資料夾不存在：建立並 `git init`；已存在：沿用，不清空。
- 加 `--no-launch`：只準備資料夾、不啟動 claude（第 6、7 章會用到）。
- 不帶參數：印出用法和第 1–9 章的資料夾名稱。

## 平行執行建議

| 組合 | 做法 | 注意 |
| --- | --- | --- |
| 第 2 章＋第 4 章 | 開兩個 cmd 視窗，各跑一次 `fast-start.bat` | 2-3 節 port 5050，第 4 章不佔 port |
| 第 5 章＋第 6 章 | 同上 | 第 5 章的 Flask 佔 port 5000，第 6 章不佔 port |
| 第 7 章＋任何一章 | Desktop 和 cmd 各做各的 | 7-1 只做前端，不開後端 |
| 第 8 章四個 demo | 開四個 cmd 視窗，四個資料夾同時跑 | 第 3 步（subagent）建完 agent 要重開 session |
| 第 1、3、9 章 | 單獨跑 | 第 1 章要先確認環境；第 3 章用第 2 章的資料夾；第 9 章較吃資源 |

- **同一個資料夾不可以同時開兩個 session**（2-5 實測過，會互相改檔、搶 commit）。
- 同時跑會讓訂閱額度集中在同一時段消耗。
- 每一章結束只 commit 一次（教材 repo 的 HANDOFF 進度表），不是每一步都 commit。

---

## 第 1 章　Claude Code 簡介與入門

- **練習資料夾**：`k120-ch01-practice`
- **步驟清單**
  1. 1-2 節：在 claude 裡執行 `/doctor`，確認安裝方式、版本、自動更新。**一定要實際跑**，不要讓模型憑印象回答。
  2. 1-3 節：貼 `ch01.md`「安裝軟體套件管理程式」那句（原文很短）：
     `我要使用軟體套件管理程式，Windows 用 scoop，macOS 用 Homebrew，幫我安裝成僅限當前使用者使用`
     完成後用 `! scoop --version` 確認。
  3. 1-3 節：`/exit` 後用 `claude -c` 接續、`claude --resume` 選對話，再用 `/memory` 看 auto memory。
  4. 1-4 節：`! echo $0`，看預設用哪個 shell。
- **保留**：全部照做（不寫程式）。**省略**：無。
- **對照檢查點**
  - 原機器第一次回報時**沒有真的跑 `/doctor`**，是憑記憶回答；新電腦（2.1.289）的 `/doctor` 是模型跑指令做健康檢查，不是固定畫面。
  - 原機器：native 安裝、2.1.289、`autoUpdates: false`（和書不同）；scoop 裝好是 v0.6.0。
  - `echo $0` → `/usr/bin/bash`（Git Bash，和書一致）。
- **預估時間**：15 分
- **可以平行嗎**：否，建議第一個做，順便確認 claude、git、uv 都正常。

## 第 2 章　快速上手：PDF 浮水印工具

- **練習資料夾**：`k120-ch02-practice`（2-3 節由 Claude 建 worktree `k120-ch02-practice-web`，分支 `web`）
- **步驟清單**
  1. 2-1 節：`/memory` 寫 CLAUDE.md，內容是 `ch02.md`「CLAUDE.md 初始內容」的 uv 三條規則；編輯器設定看「設定使用 Visual Studio Code 為預設編輯器」（`env.EDITOR`）。
     注意：`fast-start.bat` 已先在 CLAUDE.md 寫了「本專案例外」，uv 規則加在它前面或後面都可以。
  2. 2-2 節：「速度優先」＋`ch02.md`「初始提示內容」。
  3. 2-2 節：Shift+Tab 切到 `acceptEdits` 改一個小地方；`/rewind` 回到前一個狀態；`/init` 更新 CLAUDE.md；git commit。
  4. 2-3 節：請 Claude 建 worktree，Shift+Tab 切到 plan 模式，依 `ch02.md`「web_prd.md」做網頁版（port 5050）。**PRD 要完整 6 條**（原機器漏了第 6 條 cache 資料夾）。
  5. 2-4 節：用 `claude -p` 問「前端有沒有照規則」，比較 `ch02.md`「front_end/CLAUDE.md」和「.claude/rules/web.md」（`paths`）兩種寫法。**自己打指令，不要把說明整段貼給 session**。
- **保留**：CLAUDE.md 何時載入、權限模式、rewind、PRD 精準度、rules 的 `paths`。
  **省略**：多輪 QA／reviewer、完整測試套件。
- **對照檢查點**
  - 原機器 2-2 走完整流程約 33 分、`add_watermark.py` 410 行（書附 121 行）；快速模式應明顯更短更小。
  - `/rewind` 會還原 `.py`，但 Bash 產生的 PDF 不會被還原（rewind 不追蹤 Bash 的檔案變更）。
  - DEMO-LOG：範例前端沒有照 2-4 節規則拆成三個檔；三種頁面尺寸都要有浮水印。
- **預估時間**：40 分
- **可以平行嗎**：可，和第 4 章一起；2-3 之後 `k120-ch02-practice` 和 `-web` 不要各開兩個 session 同時改。

## 第 3 章　常用斜線命令

- **練習資料夾**：沿用 `k120-ch02-practice-web`（原機器也是在這裡做）
- **步驟清單**（`ch03.md` 是補充說明，沒有提示詞）
  1. `/context`、`/cost`、`/usage`、`/stats`、`/diff`；三個用量百分比為什麼不同，看 `ch03.md`「用量的計算」。
  2. `/model`、`/config`、`/permissions`、`/statusline`（自訂狀態列）。
  3. `/loop`（本機排程）和 `/schedule`（雲端排程）比較，看完記得停掉 loop。
- **保留**：全部照做（不寫程式）。**省略**：無。
- **對照檢查點**
  - 原機器 `/context`：分母 1m；Autocompact buffer 33k＝書上 20k 摘要＋13k 緩衝。
  - `/statusline` 只寫進專案 `.claude/settings.local.json`，全域沒動。
  - `/loop` 用 CronCreate，只在這個 session 有效、7 天後自動失效。
- **預估時間**：15 分
- **可以平行嗎**：否，要等第 2 章做完，也不可和第 2 章的 session 同時開這個資料夾。

## 第 4 章　Subagent

- **練習資料夾**：`k120-ch04-practice`。先把範例檔複製進去：
  `copy %USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e\code\ch04-F6757_ch04\en.txt %USERPROFILE%\workspace\k120-ch04-practice\`
- **步驟清單**
  1. 4-1 節：依 `ch04.md`「4-1 Subagent 簡介」請 Claude 建 Technical Translator，**建在專案的 `.claude/agents/`**；`/exit` 後重新 `fast-start.bat`，再分別貼兩句測試提示詞（中間 `/clear`）。
     注意：原機器把它建在全域 `~/.claude/agents/technical-translator.md`，`git pull ~/.claude` 後新電腦也會有，結果可能因此和書上不同。
  2. 4-2 節：`ch04.md`「4-2」的排序題，縮成 3 種語言 × 2 種排序；先不用 subagent 寫一次，再建 3 個語言 subagent 並行寫一次。建完 agent 要重開 session。
  3. 4-3 節：`ch04.md`「4-3」用 `personal-code-reviewer` 比較兩輪程式碼。
  4. 4-4 節：`ch04.md`「4-4」建 4 個新聞團隊 subagent，再貼「使用 Subagent」那句。
- **保留**：**派 subagent 是本章重點，全部保留**。**省略**：只是不再派 code-qa／code-reviewer。
- **對照檢查點**
  - DEMO-LOG 4-1：沒指名時主 agent 自己翻（11.5 秒），指名 subagent 25 秒。新電腦第一次卻直接交給 subagent，因為 agent 說明裡寫了觸發詞。
  - DEMO-LOG 4-2：小任務並行只快一點，成本多 85%。
  - 新電腦 4-3 兩份程式評分幾乎打平（7／7.5 對 8／7.5）；4-4 約 9 分鐘，aggregator 和 style 同時派出。
- **預估時間**：30 分
- **可以平行嗎**：可，和第 2 章一起；本章四步在同一個資料夾，要依序做。

## 第 5 章　MCP 與 Skills（臺灣房價地圖）

- **練習資料夾**：`k120-ch05-practice`。先 clone 範例再跑 `fast-start.bat`（資料夾已存在會沿用）：

  ```bat
  cd /d %USERPROFILE%\workspace
  git clone -b update_data https://github.com/FlagTech/test_buyhouse.git k120-ch05-practice
  ```

  另開一個 cmd 在該資料夾執行 `uv run wsgi.py`（port 5000）。
- **步驟清單**
  1. 5-2 節：`claude --chrome` 啟動（或進去後 `/chrome`），貼 `ch05.md`「實戰範例一：本地網頁除錯」。範例二（Google 表單）略過。
  2. 5-3 節：`ch05.md`「標準安裝」裝 Playwright MCP，再依序貼「用 Playwright MCP 測試網頁應用程式」的三句。
  3. 5-4 節：照「設定 Playwright CLI 環境」安裝，`/playwright-cli` 測一次，再照「建立自訂 playwright-test Skill」建 Skill、`/playwright-test`、新增點遍縣市的測試項目，最後 `/usage`。
- **保留**：Chrome／MCP／Skill 三種做法的比較、`disable-model-invocation`。**省略**：QA／reviewer、範例二。
- **對照檢查點**
  - DEMO-LOG：兩個刻意埋的 bug＝`graph`／`graphTrend` 變數名稱不一致、`updateChart` 傳了空物件；`sb-admin-2.min.js` 404 不影響功能。
  - 新電腦 5-3：用一次程式點完 21 縣市只回傳摘要，沒遇到輸出截斷；commit 後 push 到 FlagTech 原 repo 會被 403 拒絕（不用 push）。
  - `/context`：MCP tools 61.8k 是延遲載入、不計入，Skills 約 9.9k 計入。
- **預估時間**：30 分
- **可以平行嗎**：可，和第 6 章一起（第 6 章不佔 port）。

## 第 6 章　Hook（todo-system）

- **練習資料夾**：`k120-ch06-practice`。先 clone，再準備資料夾、改用排除全域 hook 的方式啟動：

  ```bat
  cd /d %USERPROFILE%\workspace
  git clone https://github.com/FlagTech/F6757_ch06_todo-system.git k120-ch06-practice
  cd /d %USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
  teaching\tools\fast-start.bat k120-ch06-practice --no-launch
  cd /d %USERPROFILE%\workspace\k120-ch06-practice
  claude --setting-sources project,local
  ```

  本章要觀察 hook 本身，全域 hook 會干擾結果，所以用 `--setting-sources project,local`（全域 writer-QA hook 也一起排除）。
- **步驟清單**
  1. 6-2 節：`ch06.md`「6-2」建 PreToolUse `exit 2` → 測試第 1 句；換 PostToolUse → 第 2 句；改 `exit 1`（**記得改回 PreToolUse**）→ 第 3 句。
  2. 6-2 節後半：「透過標準錯誤輸出阻擋原因」→ 測試第 4 句。
  3. 6-3 節 Telegram 通知：**略過**（需要 bot token）。
  4. 6-4 節：`ch06.md`「6-4」deny → ask → updatedInput 三組提示詞與測試。updatedInput 要在**不知情的新 session** 測。
  5. 6-5 節：`if` 條件（Write/Edit、Bash rm／sudo／chmod）→ 外部 Python 程式 → prompt 型 hook（prompt 欄位要真的寫進設定）。
- **保留**：每個情境都要實際觸發一次。**省略**：6-3、外部程式的完整測試套件。
- **對照檢查點**
  - DEMO-LOG t1–t8：PreToolUse exit 2 擋得住且顯示 `No stderr output`；PostToolUse 擋不住；exit 1 不阻擋。
  - DEMO-LOG t6：updatedInput 讓模型以為讀的是 `pyproject.toml`，卻得到 tasks.json 的內容而不自知。新電腦因為 hook 是模型自己寫的，它知道要繞開，沒被騙。
  - prompt 型 hook 擋下後，模型最後的回覆是空的（兩台都一樣）。
- **預估時間**：40 分
- **可以平行嗎**：可，和第 5 章一起。

## 第 7 章　Claude Code Desktop（只做 7-1）

- **練習資料夾**：`k120-ch07-practice`。用 `fast-start.bat k120-ch07-practice --no-launch` 建好資料夾和 CLAUDE.md，再開 Claude Code Desktop 選這個資料夾。
- **步驟清單**
  1. 7-1 節：貼 `ch07.md`「在 Claude Code Desktop 把訂餐網頁前端蓋好」的提示詞，用右側 Preview 確認畫面。
  2. 7-2 Remote Control、7-3 Claude Code on the Web、7-4 Telegram Channel：**略過，原因：需要手機、雲端或 Telegram。**
- **保留**：Desktop 介面與 Preview。**省略**：7-2～7-4、後端。
- **對照檢查點**
  - 原機器：Preview 是內建瀏覽器分頁（用 file:// 開 index.html，可直接操作）。
  - 沒有後端，「分析菜單」因 CORS 改成 1.5 秒後回範例菜單（6 個品項），合計即時計算正確。
  - 原機器約 1 分 37 秒、3.5k tokens。
- **預估時間**：10 分
- **可以平行嗎**：可，和任何一章一起（Desktop 不受 `DISABLE_WRITER_QA_HOOK` 影響，但 HTML 本來就不在鐵律清單）。

## 第 8 章　數獨（四種開發方式）

四個資料夾彼此獨立，開四個 cmd 視窗各跑一次 `fast-start.bat`，同時進行。

- **練習資料夾**：`k120-ch08-practice-chat`、`k120-ch08-practice-prd`、`k120-ch08-practice-sub`、`k120-ch08-practice-grill`
- **步驟清單**
  1. 第 1 步（8-2 節，`-chat`）：「速度優先」＋`ch08.md`「8-2」的一句話，再貼「彙整測試結果改良遊戲」的八項。
  2. 第 2 步（8-3 節，`-prd`）：把 `teaching/steps/ch08-step2/` 的 `CLAUDE.md` 內容合併進資料夾的 CLAUDE.md（保留「本專案例外」）、複製 `PRD.md`，貼「速度優先」＋`完成 @PRD.md`。雙星號修正（`PRD-v2.md`）可略過。
  3. 第 3 步（8-4 節，`-sub`）：複製同一份 `PRD.md`；依 `ch08.md`「為 Subagent 設定角色」建 4 個 agent（專案 `.claude/agents/`），**`/exit` 後重新 `fast-start.bat`**，再貼「讓 Subagent 分工設計遊戲」那句。
  4. 第 4 步（8-5 節，`-grill`）：`/grill-me-dev 開發一個數獨python app`。問到第 5 題左右，回答「其餘全部照建議，開始做」。
- **保留**：第 3 步的 **4 個角色 subagent**；第 4 步的 **grill-me 提問**（不加「選擇題直接採用建議」）。
  **省略**：QA／reviewer、截圖驗收、建 GitHub repo。
- **注意**：`grill-me-dev` 已是**使用者層級 skill**，新電腦 `git pull ~/.claude` 之後就能用；不用再照書安裝 mattpocock 版（全域的 `grill-me` 是知識測驗，不是這個）。
- **對照檢查點**
  - 原機器四個 demo：14／40／30／57 分鐘；只有沒走 writer-QA 的 HTML 版 14 分鐘。快速模式預估每個 10～20 分鐘。
  - DEMO-LOG：subagent 版 hard／expert 180 秒內出不了題；新電腦 subagent 版最慢 0.66 秒。
  - 同一份 PRD，GUI 函式庫每次都不同（原機器 PySide6／CustomTkinter／tkinter，書附 tkinter／pygame／pygame-ce）。
- **預估時間**：四個同時跑約 30 分
- **可以平行嗎**：可，四個資料夾同時跑。

## 第 9 章　YouTube 轉投影片（只做書上 4 步）

- **練習資料夾**：`k120-ch09-practice`
- **步驟清單**
  1. 9-1 節：把 `teaching/steps/ch09-step1/CLAUDE.md`（Karpathy 四原則＋uv）合併進 CLAUDE.md（保留「本專案例外」）；Shift+Tab 切到 Plan 模式，貼 `teaching/steps/ch09-step1/prompt.txt`（即 `ch09.md`「用 AskUserQuestion 工具先規劃，後實作」）。**不要加「選擇題直接採用建議」**；訪談完再 `/init`。
  2. 9-2 節：`請開始主功能的實作`，再 `/goal 後端所有 API 端點可正常回應，且 Python 的 type checking 通過`。ffmpeg 要先能用（`ffmpeg -version`）。
  3. 9-3 節：依序貼 `ch09.md`「9-3」的提示詞：Playwright 開啟測試 → 用 `I40S5yBmaiw` 測字幕和截圖 → 找出字幕錯誤 → 自動字幕差異 → 截圖時間點改用字幕區間中點。
  4. 9-4 節：歷史紀錄側邊欄；AI 翻譯**不用 API key**，改成「翻譯用本機 `claude -p` 走 Max 訂閱」；最後問沒有字幕的影片怎麼辦。
- **保留**：9-1 的 **Plan 模式訪談**。**省略**：QA／reviewer；**不要做到 M7**（佇列、SSE、匯出、播放清單等都不做）。完整版參考 <https://github.com/chenghyang2001/k120-ch09-practice>。
- **注意**
  - 家用 IP 下載 YouTube 沒問題。Python 請用 3.12 以上（3.9 的 yt-dlp 太舊，DEMO-LOG 踩過）。
  - app 裡呼叫 `claude -p` 時，要加 `--setting-sources= --strict-mcp-config` 隔離全域設定，否則會被全域 Stop hook 劫持而不翻譯（原機器踩過）。
- **對照檢查點**
  - 原機器 9-1 訪談 3 輪 × 4 題＝12 題，挑到的難點：雲端 IP 被擋、截圖爆量、自動字幕重複、**截圖取字幕區間中點**（書上 9-3 才修的做法，訪談就先問出）。
  - DEMO-LOG：書附範例用 Python 3.12 環境處理 19 分鐘影片，66 秒產出 421 張投影片。
  - 書附畫質只有 360／480／720，提示詞寫的 1080p 沒有做。
- **預估時間**：60 分
- **可以平行嗎**：建議單獨跑。
