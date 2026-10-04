# K120 分步教學計畫（第 1–9 章）

每一步都照這個循環：**旁白稿 → 字幕影片 → 使用者操作 → 回報 → 判讀**。

- 提示詞原文：`code/00-F6757_support/chNN.md`
- 原機器跑範例的結果：`demo/DEMO-LOG.md`（判讀時可以拿來對照）

## 第 1 章　Claude Code 簡介與入門

| 步 | 節 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- | --- |
| 1 | 1-2 | 用 `/doctor` 確認安裝方式、版本、自動更新 | 一定要**實際跑工具**，不能憑印象回答 |
| 2 | 1-3 | 貼書上的提示詞，請 Claude Code 安裝 scoop（macOS 是 Homebrew） | 它列了哪些步驟、要求允許哪些指令、最後怎麼驗證；最後用 `! scoop --version` 確認 |
| 3 | 1-3 | 用 `claude -c` 接續上次對話、`claude --resume` 選擇對話、用 `/memory` 查看 auto memory | 對話記錄存在哪裡；不同範圍的設定檔有什麼差別 |
| 4 | 1-4 | 在 `!` 模式下執行 `echo $0`，看預設用的是哪個 shell | Windows 預設是 Git Bash；了解怎麼改用 Bash 工具 |

## 第 2 章　快速上手：PDF 浮水印工具（練習資料夾從空的開始）

| 步 | 節 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- | --- |
| 1 | 2-1 | 用 `/memory` 寫 CLAUDE.md，內容是 uv 的三條規則；把 VS Code 設成編輯器（設定 `env.EDITOR`） | CLAUDE.md 什麼時候會被讀進去 |
| 2 | 2-2 | 貼初始提示詞，開發浮水印工具 | 它有沒有自己產生測試 PDF；有沒有照 CLAUDE.md 用 uv |
| 3 | 2-2 | 切到 `acceptEdits` 模式；用 `/checkpoint` 回到前一個狀態；用 `/init` 更新 CLAUDE.md；git commit | 各種權限模式的差別 |
| 4 | 2-3 | 建 worktree，在 plan 模式依 `web_prd.md` 做出網頁版（port 5050） | PRD 寫得多精確，結果就有多接近 |
| 5 | 2-4 | 用 `claude -p` 非互動模式；`front_end/CLAUDE.md` 和 `.claude/rules/web.md`（設定 `paths`）兩種寫法比較 | 原機器發現範例的前端沒有照規則拆成三個檔 |

## 第 3 章　常用斜線命令

| 步 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- |
| 1 | `/context`、`/cost`、`/usage`、`/stats`、`/diff` | 三個地方的用量百分比為什麼不一樣（見服務專區 ch03 的計算說明） |
| 2 | `/model`、`/config`、`/permissions`、`/statusline` | 自訂狀態列 |
| 3 | `/loop`、`/schedule`／`/routines` | 本機排程和雲端排程的差別 |

## 第 4 章　Subagent

| 步 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- |
| 1 | 用 `/agents` 建立 Technical Translator，再分別用兩種提示詞翻譯 `en.txt` | 沒有用 `@` 指定時，主對話會自己翻（原機器實測 11.5 秒，對比用 subagent 25 秒） |
| 2 | 先不用 subagent 寫排序程式，再用 7 個語言 subagent 並行寫 | 比較兩者的時間和成本 |
| 3 | 用 `personal-code-reviewer` 比較兩份程式碼 | 獨立 context 的好處 |
| 4 | 新聞團隊：4 個 subagent 協作 | 需要上網搜尋 |

## 第 5 章　MCP 與 Skills（範例：`code/ch05-test_buyhouse`）

| 步 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- |
| 1 | 用 `claude --chrome` 開 <http://127.0.0.1:5000，請> Claude 讀 Console 錯誤 | 原機器找到的兩個根因：`graphTrend` 變數名稱不一致、`updateChart` 傳了空物件 |
| 2 | 用 `claude mcp add playwright ...` 安裝 Playwright MCP 並測試網站 | `MAX_MCP_OUTPUT_TOKENS` 的作用 |
| 3 | 安裝 Playwright CLI 加官方 Skill，再自建 `playwright-test` Skill | `disable-model-invocation` 的作用；用 `/usage` 比較 MCP 和 Skill 的用量 |

## 第 6 章　Hook（範例：`code/ch06-F6757_ch06_todo-system`）

依序做 6-2 到 6-5 的 10 個情境。原機器的結果和設定檔都在 `demo/work/ch06/settings/`，結果記錄在 `demo/logs/ch06-hooks.log`，可以拿來對照。

| 步 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- |
| 1 | PreToolUse 和 PostToolUse 分別用 `exit 2` | Post 擋不住，因為工具已經執行完了 |
| 2 | 先輸出 stderr 再 `exit 2` | Claude 看得到阻擋的原因 |
| 3 | Telegram 通知 hook | 只有互動模式才會觸發 |
| 4 | JSON 回傳 deny／ask／updatedInput | updatedInput 會讓模型被誤導而不自知 |
| 5 | 用 `if` 條件、外部程式、prompt 型 hook | prompt 型被擋下後，模型最後的回覆會是空的 |

## 第 7 章　遠端遙控與雲端協作（範例：`code/ch07-order-sheet`）

| 步 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- |
| 1 | 在 Claude Code Desktop 做訂餐系統前端 | Preview 功能 |
| 2 | 用 Remote Control 從手機遙控，寫後端 | 互動式 session 和伺服器模式的差別 |
| 3 | Claude Code on the Web：連 GitHub，在雲端整合 | 再把結果拉回本機 |
| 4 | Telegram Channel 的 7 個設定步驟，加上菜單分析功能 | 原機器指出的安全疑慮：`shell=True`、SSRF |

## 第 8 章　數獨（四種開發方式）

| 步 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- |
| 1 | 直接對話開發，再一次丟出 8 項改良 | 先對齊 X-wing 和 swordfish 這些術語 |
| 2 | 先寫 PRD 再開發，用雙星號標記要修的地方 | PRD 版是最快、最穩定的（原機器的評測結果） |
| 3 | 4 個 subagent 分工 | 原機器的 subagent 版難度 hard 在 180 秒內產生不出題目 |
| 4 | 用 `/grill-me` 讓 Claude 反過來問你 | 每次只問一題，並附上建議答案 |

## 第 9 章　YouTube 轉投影片

| 步 | 使用者要做的事 | 要觀察的重點 |
| --- | --- | --- |
| 1 | 寫 Karpathy 四原則的 CLAUDE.md，用 Plan 模式加 AskUserQuestion 做訪談 | 訪談出來的規格品質 |
| 2 | 用 `/goal` 設定完成條件，然後實作 | |
| 3 | 用 Playwright 測試，修正字幕和截圖時間對不上的問題 | 截圖時間點改用字幕時間區間的中點 |
| 4 | 加歷史紀錄、AI 翻譯、語音辨識字幕 | 需要 API key |
