# K120《Claude Code Vibe Coding 開發手冊 第 2 版》章節整理

> **資料來源**：沒有書的內文。本整理依據三種公開資料：
>
> - 〔簡介〕博客來的內容簡介、本書特色、目錄
> - 〔服務專區〕出版社的書附服務專區 [FlagTech/F6757_support](https://github.com/FlagTech/F6757_support)，內容包含各章的提示詞、命令與補充說明
> - 〔範例〕各章範例 repo 的實際檔案
>
> 標〔推論〕的段落是依標題推測，書中寫法可能不同。
> 書中提醒：生成式 AI 有不確定性，實際操作結果可能和書上不同。

## 書籍資料

| 項目 | 內容 |
| --- | --- |
| 書名 | Claude Code Vibe Coding 開發手冊 第 2 版 |
| 書號 | **F6757**（第 1 版是 F5757） |
| 作者 | 施威銘研究室 |
| 出版 | 旗標科技，2026 年 6 月二版一刷 |
| 規格 | 平裝／464 頁 |
| ISBN | 978-986-312-886-1 |
| 標語 | 隨時隨地聊出好程式 — Code the vibe, anywhere |
| 書附下載 | <https://www.flag.com.tw/DL.asp?F6757>（會轉到 GitHub `FlagTech/F6757_support`） |
| 本機範例 | `code/`，結構見文末 |

### 和第 1 版的差異

第 1 版有 10 章，第 2 版調整成 9 章：

- **新增**：遠端遙控（Remote Control、Claude Code on the Web、Telegram Channel）、記憶架構分層、Skills＋CLI、`/loop`／`/routines`、數獨實戰、grill-me skill、Hook 的 JSON 介面與 `if` 條件、`/goal`
- **改寫**：PDF 翻譯實戰改成 PDF 浮水印工具
- **合併**：git 與 GitHub 協作併入第 2 章（worktree）和第 7 章（雲端協作）

---

## 全書結構

| 章 | 主題 | 範例專案（`code/` 底下） | 技術 |
| --- | --- | --- | --- |
| 1 | 簡介與入門 | —（只有安裝命令） | PowerShell、scoop／Homebrew |
| 2 | 快速上手 | `ch02-F6757_ch02` PDF 浮水印 | Python＋uv、命令列工具加網頁版（port 5050） |
| 3 | 常用斜線命令 | —（服務專區補充 `/context` 計算細節） | — |
| 4 | Subagent | `ch04-F6757_ch04`（只有一份 `en.txt`） | 翻譯、7 種語言排序、新聞網頁 |
| 5 | MCP 與 Skills | `ch05-test_buyhouse`（`update_data` 分支） 臺灣房價地圖 | Flask（port 5000）、Playwright MCP／CLI |
| 6 | Hook | `ch06-F6757_ch06_todo-system` | Python＋uv、`tasks.json` |
| 7 | 遠端與雲端 | `ch07-order-sheet` 旗標訂餐系統 | HTML/JS＋Flask＋openpyxl |
| 8 | 數獨實戰 | 4 個 repo（四種開發方式各一個） | 網頁版／Python 桌面版 |
| 9 | YouTube 轉投影片 | `ch09-YouTube2Slides` | 前後端分離、ffmpeg |

學習路徑：**第 1–3 章打基礎 → 第 4–6 章擴充能力 → 第 7 章換個地方開發 → 第 8–9 章綜合實戰**。

---

## 第 1 章　Claude Code 簡介與入門

**重點**：裝好 Claude Code，第一個任務就讓它幫你安裝軟體，示範它不只會寫程式。

- **安裝**〔服務專區〕
  - Windows：先用 `winget install --id Microsoft.PowerShell` 裝 PowerShell，再執行 `irm https://claude.ai/install.ps1 | iex`
  - macOS／Linux：`curl -fsSL https://claude.ai/install.sh | bash`
- **第一個任務**〔服務專區〕的提示詞：
  「我要使用軟體套件管理程式，Windows 用 scoop，macOS 用 Homebrew，幫我安裝成僅限當前使用者使用」
  （第 9 章會再用 scoop 安裝 ffmpeg）
- **同章其他觀念**〔簡介〕：內建工具、對話記錄與接續、auto memory、不同範圍的設定檔、`!` shell 模式
- **Windows 注意**〔簡介〕：`!` shell 模式預設走 Git Bash，以及預設改用 Bash 工具的方法

## 第 2 章　快速上手 — PDF 浮水印工具

**重點**：用一個專案走完「寫規範 → 開發 → 復原 → worktree＋PRD → 分層規則」的完整流程。

- **初始 CLAUDE.md**〔服務專區〕：規定用 `uv init`、`uv add`（不要用 pip）、`uv run` 管理 Python 環境
- **設定 VS Code 為編輯器**〔服務專區〕：在 settings 的 `env` 加上 `"EDITOR": "code"`（`/memory` 會用它開檔），同一份設定也示範 `autoUpdatesChannel: "latest"`
- **初始提示詞**〔服務專區〕：浮水印文字是 `Confidential`、要支援同一份 PDF 有不同頁面尺寸、輸出檔名加 `_wm`、做完自己生成測試 PDF 並開給使用者檢查
- **2-2**〔簡介〕：`-c` 接續對話、`acceptEdits`、`/checkpoint` 復原、`/init` 更新 CLAUDE.md、git 提交
- **2-3 worktree＋PRD**〔服務專區〕〔範例〕：`web_prd.md` 把命令列工具擴充成網頁版
  - 不帶參數時啟動網頁伺服器（port 5050），帶參數時照常當命令列工具
  - 前端放 `front_end/`，背景圖由 AI 自己生成
  - 文件裡用 ASCII 畫出表單版面，並逐條寫運作流程
  - 上傳檔放 `cache/`，不進 git
- **2-4 分層規範**〔服務專區〕：同一份「網頁要拆成 html／css／js 三個檔」的規則，示範兩種寫法：
  1. 放在子目錄 `front_end/CLAUDE.md`：只在那個目錄生效
  2. 放在 `.claude/rules/web.md`，用 frontmatter `paths: ["**/*.html"]` 限定只套用在 HTML 檔
  - 這就是〔簡介〕說的「記憶架構」：CLAUDE.md、rules、Skill、auto memory 各管一塊

## 第 3 章　常用斜線命令

**重點**：分四組介紹命令〔簡介〕。服務專區用很長的篇幅補充 **`/context` 與自動壓縮的計算方式**，是本章最有料的部分。

| 分組 | 命令 |
| --- | --- |
| 交談階段 | `/compact` `/cost` `/usage` `/context` `/clear` `/stats` `/diff` |
| 設定 | `/add-dir` `/config` `/doctor` `/model` `/plan` `/rename` `/permissions` `/statusline` `/ide` |
| 任務排程 | `/background` `/loop` `/schedule` `/routines` |
| 帳號與其他 | `/login` `/logout` `/color` `/radio` `/fast` |

**context 計算重點**〔服務專區〕

- **1M context**：Sonnet 4.6 要開 usage credits 才能選 1M 版本，選了以後 `/model` 顯示 `claude-sonnet-4-6[1m]`。其他選項仍是 200k。
- **兩個重要界線**（以 200k 為例）：
  - **有效上下文視窗**＝200k − 20k（保留給壓縮摘要的輸出空間）＝ **180k**
  - **自動壓縮觸發點**＝180k − 13k（緩衝）＝ **167k**
- **警告訊息**：用量超過 167k − 20k ＝ **147k** 時，右下角開始顯示「xx% until auto-compact」
- **兩種壓縮方式**
  - Proactive Compact：送出前檢查，到觸發點就壓縮
  - Reactive Compact：等 API 回報超過上限才壓縮，所以畫面上會看到 386% 這種用量
  - 書中觀察到 2.1.161～2.1.167 版有這個狀況
- **三個百分比算法不同**：

  | 位置 | 計算方式 | 書中例子 |
  | --- | --- | --- |
  | `/context` | 上一輪送出內容 ÷ 上下文視窗 | 87% |
  | 輸入區（Reactive） | 目前用量 ÷ 有效上下文視窗 | 99% |
  | 輸入區（Proactive） | 1 − 用量 ÷ 自動壓縮觸發點 | — |

  輸入區的數字會比 `/context` 大，因為它多算了上一輪的回覆。

## 第 4 章　用 Subagent 分工合作

**重點**：用四個漸進的例子示範 Subagent 的價值：建立 → 並行加速 → 客觀審查 → 團隊協作。〔服務專區〕

| 節 | 例子 | 示範重點 |
| --- | --- | --- |
| 4-1 | `Technical Translator`：把 `en.txt` 翻成繁中（專有名詞保留原文） | 自動委派，或用 `@` 指定 agent |
| 4-2 | 7 種語言 × 5 種排序法；先不用 subagent 跑一次，再派 7 個語言工程師 subagent 並行跑，比較耗時 | 並行加速、主對話 context 較省 |
| 4-3 | `personal-code-reviewer`：比較兩種方式產出的 Rust 程式碼品質，分「需要修正／建議改善」兩級 | 獨立 context 讓審查較客觀 |
| 4-4 | 四人團隊做「台灣十大新聞」網頁，仿 time.com 風格 | 編排：前兩個並行 → 摘要 → 組裝網頁 |

4-4 的團隊分工：

- `taiwan-news-aggregator`：蒐集新聞
- `time-style-researcher`：研究版面風格
- `news-summarizer`：每則寫 50 字內摘要
- `news-page-builder`：組成響應式網頁

每個 subagent 都把成果存成 MD 檔，**再把檔名回報給主 agent**。這是 subagent 之間交接資料的模式。

## 第 5 章　用 MCP 與 Skills 生出超能力

**重點**：MCP 負責接外部工具、Skill 負責打包流程。本章用同一個測試任務，分別用 MCP 和 Skill＋CLI 各做一次來比較。

- **5-2 Claude in Chrome**〔服務專區〕
  - 用 `claude --chrome` 啟動，或在對話中下 `/chrome` 設成每次自動連接
  - 範例專案：`git clone -b update_data` 下載臺灣房價地圖，用 `uv run wsgi.py` 啟動（port 5000）
  - 例一：讀瀏覽器 Console 錯誤，找出圖表不顯示的原因
  - 例二：把桌面上的 `sales_data.csv` 填進 Google 表單（示範操作已登入的服務）
- **5-3 Playwright MCP**〔服務專區〕
  - 安裝：`claude mcp add playwright npx @playwright/mcp@latest`，全域加 `--scope user`
  - 管理：`claude mcp get／list／remove`
  - 測試：讓它跑網站功能 → 修錯 → 逐一點地圖上的縣市檢查資料
  - MCP 輸出太長被截斷時，在 settings `env` 設 `MAX_MCP_OUTPUT_TOKENS: "90000"`
- **5-4 Skills＋Playwright CLI**〔服務專區〕
  - 安裝：`npm install -g @playwright/cli@latest`，再跑 `playwright-cli install-browser` 和 `playwright-cli install --skills`（安裝官方 Skill）
  - 用 `/playwright-cli` 即時測試
  - 讓 Claude 把整個測試流程寫成 `.claude/skills/playwright-test/SKILL.md`
    - frontmatter 設 `disable-model-invocation: true`，只能手動用 `/playwright-test` 觸發
    - 用 `allowed-tools` 預先授權需要的命令
  - 往 Skill 追加測試項目（逐一點縣市）
  - 最後用 `/usage` 比較 MCP 和 Skill 的 token 用量

## 第 6 章　最後的防線：Hook

**重點**：以 todo-system 的 `tasks.json` 當保護目標，Hook 從「全部擋下」一路演進到「讓模型判斷」。〔服務專區〕

| 節 | 作法 | 學到什麼 |
| --- | --- | --- |
| 6-2 | PreToolUse 遇到 Write／Edit／Bash／PowerShell 直接 exit 2 | 擋得住 |
| 6-2 | 改成 PostToolUse | 檔案已經改了，擋不住 |
| 6-2 | 改用其他退出代碼 | 只有 exit 2 才會阻擋 |
| 6-2 | 阻擋前寫 stderr 說明原因 | Claude 讀得到原因 |
| 6-3 | Notification hook 用 `uv run` 執行 `telegram_notification.py`，token 和 chat_id 放 `.env` | 不用一直盯著等 |
| 6-4 | JSON `permissionDecision: "deny"` 附上原因 | 取代退出代碼 |
| 6-4 | JSON `"ask"` | 每次編輯都要使用者同意 |
| 6-4 | JSON `"updatedInput"`：把所有 Read 都改成讀 `tasks.json` | Hook 能改寫工具的輸入 |
| 6-5 | 官方 `if` 語法，只有目標是 `tasks.json` 才 ask | 不用寫程式就能篩選 |
| 6-5 | Python 腳本讀 stdin JSON 的 `tool_input.file_path` 判斷 ask／allow | 條件判斷寫成程式 |
| 6-5 | `Bash(rm*)`、`sudo`、`chmod` 比對後 deny | 擋危險命令 |
| 6-5 | 外部程式分級：rm／sudo 直接 deny，curl／mv 改 ask | 依風險程度分級 |
| 6-5 | `type: "prompt"` 交給 **Opus 4.7** 判斷（timeout 15 秒），讀 `.env` 一律拒絕 | 讓模型當守門員 |

範例專案裡有 `delete.txt`、`move.txt`，是給 6-5 測試刪除和搬移命令用的。

## 第 7 章　遠端遙控與 GitHub 雲端協作

**重點**：同一個「旗標訂餐系統」，前端、後端、整合、新功能**分別在四個不同地方完成**。〔服務專區〕

| 節 | 在哪裡開發 | 做什麼 |
| --- | --- | --- |
| 7-1 | Claude Code Desktop | 做前端 `index.html`：貼菜單網址 → 分析 → 品項卡片（下拉選項、數量、備註）→ 姓名 → 送出；用 Preview 預覽 |
| 7-2 | 手機遙控家裡電腦（Remote Control） | 做 Flask 後端 `app.py`：`/api/analyze`（先回假資料）、`/api/order`（寫入 `orders.xlsx`）、CORS |
| 7-3 | Claude Code on the Web | 用 `@index.html @app.py` 整合前後端，再拉回本機測試 |
| 7-4 | Telegram Channel | 加上真正的菜單分析：`curl` 抓店家菜單網頁（例：kebuke.com）→ 用 `claude -p` 分析 → 輸出 JSON 更新訂餐頁面 |

**Telegram Channel 設定七步驟**〔服務專區〕

1. 建立 Bot
2. `/plugin install telegram@claude-plugins-official`，再 `/reload-plugins`
3. `/telegram:configure <token>`
4. 安裝 Bun
5. `claude --channels plugin:telegram@claude-plugins-official` 啟動
6. `/telegram:access pair <配對碼>`
7. `/telegram:access policy allowlist` 鎖定存取權

## 第 8 章　實戰範例：數獨遊戲

**重點**：同一個題目用四種方式開發，四份成果都放在 GitHub 上可以直接比較。〔服務專區〕〔範例〕

| 節 | 方式 | repo | 成果形態 |
| --- | --- | --- | --- |
| 8-2 | 直接對話：「請幫我製作一個數獨遊戲app」，再一次丟 8 項改良（四級難度、加速出題、首頁、復原與暫停、自動存檔、背景、紀錄、每日挑戰） | `AI-session-sudoku-game` | **網頁版**（HTML/CSS/JS） |
| 8-3 | 先寫 PRD.md（16 項功能），再「完成 @PRD.md」 | `PRD-sudoku` | Python 桌面版 |
| 8-3 | 修正方式：在 PRD 裡用 **`**雙星號**`** 標出沒做好的項目，再請它修正 | 同上 | — |
| 8-4 | 4 個 subagent 照 PRD 分工 | `subagent-sudoku` | 多了 `API_CONTRACT.md` 和多支測試 |
| 8-5 | `/grill-me 開發一個數獨python app` | `grill-me-sudoku` | Python 桌面版（`src/`） |

- **8-2 的關鍵提問**：先問「你認為 X-wing 與 swordfish 是什麼」，對齊雙方對術語的理解後再開發。
- **8-3 PRD 的寫法**：每一項功能就是一行「名稱＋規格」，例如「題目生成：最小剩餘值啟發法＋回溯搜尋」、「每日挑戰：以日期當亂數種子」。
- **8-4 四個角色**：
  - 遊戲邏輯工程師：出題、解題、難度
  - 介面工程師：排版、按鍵、高亮
  - 資料工程師：存檔、紀錄、每日挑戰
  - 視覺設計師：主題、深色模式
- **8-5 grill-me**：源自 mattpocock/skills。中文改版的規則是：
  - 每次只問一個問題
  - 每題附上建議答案
  - 能從程式碼查到的就自己查，不問使用者

## 第 9 章　實戰範例：YouTube 影片轉投影片

**重點**：完整的中型專案流程：行為準則 → 訪談式規劃 → 設完成條件 → 自動化測試 → 逐步加功能。〔服務專區〕

- **9-1 Karpathy 四原則 CLAUDE.md**（中文版）
  1. 寫程式前先思考：不確定就停下來問，有多種做法就列出來
  2. 簡單優先：不加沒要求的功能，200 行能寫成 50 行就重寫
  3. 精確修改：不要順手重構、不改無關的程式
  4. 目標導向：把任務轉成可驗證的目標，例如「修 bug」→「先寫能重現問題的測試」
- **規劃方式**：用 Shift+Tab 進 Plan 模式，在需求後面加上：
  「請先使用 AskUserQuestion 工具詳細詢問我……不要問顯而易見的問題，要挖掘我可能沒想到的難點」
  訪談完成後產出規格，再用 `/init` 寫回 CLAUDE.md。
- **9-2 實作**
  - `/goal 後端所有 API 端點可正常回應，且 Python 的 type checking 通過`
  - 用 `scoop install ffmpeg` 安裝 ffmpeg
- **9-3 除錯**
  - 用 Playwright 測基本功能，拿實際影片測字幕和截圖
  - 比較 YouTube 自動字幕和手動上傳字幕在處理邏輯上的差異
  - 修正截圖和字幕的時間差：截圖點改成**字幕時間區間的中間點**
- **9-4 加功能**
  - 側邊欄歷史紀錄
  - AI 翻譯：可接 GPT／Claude／Gemini／本地 Ollama，先讓它上網查各家最新模型和串接方式；**先做後端並測試，再做前端**
  - 語音辨識字幕：處理沒有字幕的影片

---

## 跨章主題索引

| 想學的功能 | 主要章節 | 也出現在 |
| --- | --- | --- |
| CLAUDE.md／`.claude/rules`（`paths`） | 2-1、2-4 | 8-3、9-1 |
| PRD／規格先行 | 2-3、8-3 | 9-1（AskUserQuestion）、8-5（grill-me） |
| Subagent | 4 | 8-4 |
| MCP | 5-2、5-3 | 9-3 |
| Skill（`disable-model-invocation`、`allowed-tools`） | 5-4 | 8-5 |
| Hook（exit 2／JSON／`if`／prompt 型） | 6 | — |
| Telegram | 6-3（通知） | 7-4（Channel） |
| `claude -p` 非互動模式 | 2-4 | 7-4（分析菜單） |
| 遠端與雲端開發 | 7 | 3（`/routines`） |
| context 與壓縮的計算 | 3（服務專區補充） | 4-2 |
| `/goal` | 9-2 | — |

## `code/` 目錄結構

```
code/
├── 00-F6757_support/            # 書附服務專區：ch01–09.md 提示詞＋第 3 章補充圖
├── ch02-F6757_ch02/             # PDF 浮水印（命令列＋網頁版）
├── ch04-F6757_ch04/             # en.txt（翻譯範例）
├── ch05-test_buyhouse/          # 臺灣房價地圖（update_data 分支，1.4 GB，大多是資料）
├── ch06-F6757_ch06_todo-system/ # Hook 練習用的 todo 系統
├── ch07-order-sheet/            # 旗標訂餐系統
├── ch08-AI-session-sudoku-game/ # 8-2 對話生成（網頁版）
├── ch08-PRD-sudoku/             # 8-3 PRD 生成
├── ch08-subagent-sudoku/        # 8-4 Subagent 分工
├── ch08-grill-me-sudoku/        # 8-5 grill-me
└── ch09-YouTube2Slides/         # YouTube 轉投影片
```

外部參考（沒有下載）：

- [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp)
- [mattpocock grill-me SKILL.md](https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md)
