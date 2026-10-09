# K120 互動教學交接文件（換電腦接續用）

> 交接日期：2026-10-05
> 原機器：家用機（Windows 10，Claude Code 2.1.289 npm 版）
> 目標：在一台**全新的電腦**上，接續《Claude Code Vibe Coding 開發手冊 第 2 版》的互動式教學演練。

---

## 0. 明天從這裡開始（2026-10-05 收工時寫）

> 機器：家用機 USER（Windows 11，Claude Code 2.1.289 原生安裝，Opus 5.5）。
> 這台已完成第 1–7 章（6-3、7-4 前半的 Telegram 因無 Bot Token 跳過）。
> **另一台家用電腦用快速模式重跑第 1–9 章**：照 `teaching/FAST-RUN.md`，進度記在「2-1 快速模式進度表」。

### 下一步：見第 2 節進度表「⏳」那一列（2026-10-06 已進行到第 8 章）

- **使用者還沒開始做**（`k120-ch08-practice-chat` 資料夾尚未建立）。
- 旁白／影片／說明都已做好：`teaching/narration/ch08-step1.txt`、`teaching/videos/ch08-step1.mp4`、`teaching/steps/ch08-step1.md`。
- 接續時：先**重播影片並用記事本開說明檔**，等使用者回報，再判讀並往 8-3（PRD 版）走。
- 第 8 章後續：8-3 PRD（`ch08.md` 有 CLAUDE.md＋PRD.md 範本）→ 8-4 4 個 subagent → 8-5 `/grill-me`；然後第 9 章。

### 這台機器上確立的教學做法（新 session 請照做）

1. **使用者通常不貼結果，只說 proceed next**。判讀一律直接讀練習資料夾的對話記錄：
   `~/.claude/projects/C--Users-USER-workspace-<練習資料夾名>/*.jsonl`（略過開頭是「你是一個嚴格的記憶萃取器」的 sdk-cli session），再加上實際檢查檔案、git log、port。
2. **使用者用 cmd（不是 PowerShell）**：指令用 `%USERPROFILE%`、`set VAR=1`，不要給 `$env:`。
3. **播放影片**：`make_caption_video.py` 產生後，用 PowerShell `Start-Process` 開 VLC（Git Bash 的 `&` 背景啟動會失敗，VLC 不會出現）：
   `powershell -NoProfile -Command "Start-Process -FilePath 'C:\Program Files\VideoLAN\VLC\vlc.exe' -ArgumentList '--play-and-exit','--no-video-title-show','\"<mp4 Windows 路徑>\"'"`
4. **說明另存成檔案**：終端機顯示會截斷，從第 7 章起每步另寫 `teaching/steps/chNN-stepX.md`，並用 `notepad.exe` 開啟。
5. **Git Bash 的 PATH 沒有 ffmpeg**：產生影片前先
   `export PATH="$LOCALAPPDATA/Microsoft/WinGet/Packages/Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe/ffmpeg-9.0.2-full_build/bin:$PATH"`
6. **請使用者自己打指令，不要整段貼教學說明給練習 session**（2-5 的對照組因此被破壞）。
7. 練習 session 受全域規則影響很大（writer→QA→reviewer、commit 後 push、Stop hook 提醒），判讀時要分清「書上行為」和「使用者全域設定造成的行為」。第 6 章用 `claude --setting-sources project,local` 排除全域 hook。
8. **想加快 demo** 時，照 `teaching/steps/fast-demo.md`（關掉三 agent 鐵律＋速度優先提示詞＋多視窗並行）。
9. 使用者要求時可用 Gmail MCP（`mcp__claude_ai_Gmail__send_message`）把提示詞寄給自己（手機貼用）。

### 收工時的環境狀態（明天先處理）

- **port 5000 仍被 ch07 的 Flask 測試伺服器佔用**（PID 18884）。第 8 章用不到，但第 9 章前請關掉：`netstat -ano | findstr :5000` → `taskkill /PID <PID> /F`。
- GitHub 上 `chenghyang2001/k120-ch07-practice` 有 `before-integration` 分支（雲端整合結果 `954cf73`），可留著對照或刪除。
- 全域多了兩樣東西（練習時建的，會隨 `~/.claude` 同步）：`~/.claude/agents/technical-translator.md`、`~/.claude/skills/playwright-cli/`。要不要保留由使用者決定。
- 待補做（有 Telegram Bot Token 時）：6-3 Notification hook（`ch06-step3.*` 已做好）、7-4 前半 Telegram Channel。

---

## 1. 這個教學是什麼

一步一步帶你操作書中每一章的內容。每一步都照同一個循環進行：

```
Claude 寫旁白稿 → 產生「語音＋同步字幕」影片 → 用 VLC 播放（畫面同時顯示文字）
        → 你在另一個終端機視窗實際操作 → 回報結果 → Claude 判讀 → 下一步
```

**教學規則**（新電腦上的 Claude 要遵守）：

1. **一律繁體中文。**
2. **每一步都要有語音和字幕**，不能只給文字：
   - 先寫旁白稿 `teaching/narration/chNN-stepX.txt`。用口語寫，不放表格和符號，因為 TTS 念出來會很怪。
   - 再用 `teaching/tools/make_caption_video.py --play` 產生影片，並直接播放。
   - 聊天視窗裡也要附同樣內容的文字版，方便對照。
3. **每次只講一步。**講完就停下來，等使用者回報結果，不要一次把整章講完。
4. 使用者在**另一個終端機**操作，練習資料夾是 `%USERPROFILE%\workspace\k120-chNN-practice`，不要動到其他專案。
5. 判讀結果時，要講出**和書上不同的地方，以及為什麼不同**。書上也提醒過：生成式 AI 有不確定性，結果可能和書上不一樣。
6. 書上的提示詞原文在 `code/00-F6757_support/chNN.md`，各章重點在 `book-summary.md`。我在原機器跑過範例的結果寫在 `demo/DEMO-LOG.md`，可以拿來對照。

---

## 2. 目前進度

| 章 | 步 | 狀態 | 備註 |
| --- | --- | --- | --- |
| 1 | 第 1 步：確認安裝方式、版本、自動更新（1-2 節） | ✅ 在原機器完成 | 原機器是 npm 安裝，和書不同 |
| 1 | 第 1 步（新電腦重做）：用 `/doctor` 實際量測 | ✅ 2026-10-05 完成 | native、2.1.289、頻道 latest、**自動更新關閉**（`~/.claude.json` 的 `autoUpdates: false`，和書及原機器不同）。回報的依據是設定檔＋`--version`，不是 doctor 畫面原文 |
| 1 | 第 2 步：請 Claude Code 安裝 scoop（1-3 節） | ✅ 2026-10-05 完成 | scoop v0.6.0（`~/scoop`）、autoUpdates 已改 true、pwsh 7.6.6。和書不同：沒貼書上提示詞；全域 CLAUDE.md 讓模型先說「優先用 winget」；auto 模式沒逐條詢問；**2.1.289 的 `/doctor` 是模型跑指令的健康檢查＋提出清理**，不是固定畫面（已改了全域 settings／CLAUDE.md／85 個 skill 描述） |
| 1 | 第 3 步：`-c`／`--resume` 接續對話、auto memory、`!` 模式（1-3 節） | ✅ 2026-10-05 完成（由對話記錄判讀） | `! scoop --version` 成功 v0.6.0。PATH 生效有兩層：外層終端機＋Claude Code 的 shell 快照（`~/.claude/shell-snapshots/`）；練習 session 在 `~/.bashrc` 補了 scoop 路徑。`-c`／`--resume` 都接回同一個 doctor session；資料夾 12 個記錄中 11 個是 Stop hook 用 `claude -p` 產生（entrypoint `sdk-cli`）。`/memory` 開了沒選檔就取消 |
| 1 | 第 4 步：Windows 上 `!` 模式用的是哪個 shell（1-4 節） | ✅ 2026-10-05 完成（由對話記錄判讀） | `echo $0` → `/usr/bin/bash`（Git Bash，和書一致）；PATH 第一個是 `.bashrc` 補的 scoop，Windows 那份還沒進來（WT 未整個重開）。模型說只拿到 Bash 工具；環境資訊的「PowerShell (primary)」是 OS 預設 shell，不等於有 PowerShell 工具。resume 清單筆數使用者未回報 |
| 2 | 第 1 步：`/memory` 寫 CLAUDE.md（uv 三條規則）＋設定編輯器（2-1 節） | ✅ 2026-10-05 完成（由記錄＋檔案判讀） | 選 Cursor（`.claude/settings.local.json` 的 `EDITOR=cursor`），`/memory` 成功開啟 `./CLAUDE.md`。回答照 uv 規則，但它先 `cat CLAUDE.md`（檔案在 session 中途才建立），自動載入未獨立驗證。多出 `.claude/session-state.md`（全域 hook 產生）。CLAUDE.md 每行前多 2 個空白（從聊天複製帶入） |
| 2 | 第 2 步：貼初始提示詞開發浮水印工具（2-2 節） | ✅ 2026-10-05 完成（由記錄＋實測判讀） | 旁白／影片：`ch02-step2.txt`／`ch02-step2.mp4`。全域 `enforce_writer_qa.py` hook 會擋直接寫 .py，模型會改走 writer→QA agent 並先問複雜度。實際：uv＋pypdf＋reportlab；5 輪 QA＋4 輪 reviewer，約 33 分鐘；`add_watermark.py` 410 行（書附 121 行）。sample_wm 5 頁＋sample_rotated_wm 7 頁，實測 12 頁都有 Confidential。reviewer 抓到書籤遺失、共用內容雙重浮水印、AES 錯誤訊息、輸出膨脹 7 倍等 |
| 2 | 第 3 步：acceptEdits、`/rewind`（書上稱 checkpoint）、`/init`、git commit（2-2 節） | ✅ 2026-10-05 完成（由記錄＋實測判讀） | acceptEdits 下改紅色未詢問（1 行，hook 豁免）。**rewind 還原了 `add_watermark.py`，但 Bash 產生的 `sample_wm.pdf` 仍是紅色**（rewind 不追蹤 Bash 的檔案變更）。`/init` 把 CLAUDE.md 從 9 行改寫成 59 行，uv 規則保留，加了 8 條不變量。git：6 個檔案，`.gitignore` 排除 *.pdf／.venv／settings.local.json；已推到公開 repo `chenghyang2001/k120-ch02-practice` |
| 2 | 第 4 步：worktree＋plan 模式依 `web_prd.md` 做網頁版（2-3 節，port 5050） | ✅ 2026-10-05 完成（由記錄＋實測判讀） | worktree `k120-ch02-practice-web`／分支 `web`，commit `f401b39` 已 push。模型自己呼叫 EnterPlanMode（不是使用者 Shift+Tab）；中等、不派 reviewer，約 8 分鐘。標準函式庫 http.server（書附用 FastAPI）；前端拆 index.html／style.css／app.js＋bg.svg；固定深色背景。用 claude-in-chrome 實測上傳下載。**教學疏失：給使用者的 PRD 漏了第 6 條（cache 資料夾、不提交）**，實作放系統暫存資料夾，未提交 |
| 2 | 第 5 步：`claude -p`＋`front_end/CLAUDE.md` 與 `.claude/rules/web.md`（paths）比較（2-4 節） | ✅ 2026-10-05 完成（由記錄判讀） | **對照組被破壞**：使用者把教學說明整段貼給互動 session，它建規則檔時就順手改名成 index.css／index.js（`c2103fd`），之後兩次 `-p` 都答「符合」。兩次 `-p` 都自己 `cat` 規則檔，無法證明自動載入。第二次 `-p` 把 paths 擅自擴大成 html／css／js（`b67d78a`，和書上不同）。互動 session 與 `-p` 同時在同一 worktree 改檔、commit；5050 伺服器中途停過一次（原因未查證）。**教訓：之後請使用者自己打指令，不要整段貼教學說明** |
| 3 | 第 1 步：`/context`、右下角 token、`/cost`、`/usage`、`/stats`、`/diff` | ✅ 2026-10-05 部分完成（只有 `/context` 有紀錄） | Opus 5.5，分母 **1m**，183.4k（18%）；Messages 92k、Memory files 35.1k、Custom agents 18.7k、System tools 18.4k；**Autocompact buffer 33k＝書上 20k 摘要＋13k 緩衝**；deferred MCP＋系統工具約 71.7k 不計入。`/usage` 開了 3 次都關掉；跑過 `/usage-credits`（登入成功後中斷）；`/cost`／`/stats`／`/diff` 無紀錄 |
| 3 | 第 2 步：`/model`、`/config`、`/permissions`、`/statusline` | ✅ 2026-10-05 完成（由記錄＋檔案判讀） | `/model` 保持 Opus 5.5（預設）；`/config`、`/permissions` 開了就關，無內容紀錄。`/statusline` 派 statusline-setup agent，**只寫入專案 `.claude/settings.local.json`**（全域未動、已被 gitignore），是一行 jq 指令而非獨立腳本；模擬輸出 `k120-ch02-practice-web \| web \| ctx 18%` |
| 3 | 第 3 步：`/loop`（本機）與 `/schedule`（雲端）比較 | ✅ 2026-10-05 完成（由記錄判讀） | `/loop` → CronCreate `*/1 * * * *`（session-only、7 天自動失效），立即回報 1 次＋12:11:02、12:12:02 準時觸發（提示詞以新訊息注入）；輸入 stop → CronDelete。`/schedule` 是 skill 流程（AskUserQuestion → RemoteTrigger list），帳號內 20 個 routine 全為已執行完的一次性提醒 |
| 4 | 第 1 步：`/agents` 建 Technical Translator，兩種提示詞翻 `en.txt`（4-1 節） | ✅ 2026-10-05 完成（由記錄判讀） | **2.1.289 已移除 `/agents` 精靈**（改叫 Claude 建或手改 `.claude/agents/`）。Claude 把它建在**全域** `~/.claude/agents/technical-translator.md`（未提交，教學 session 也看得到）。**第一句沒指名，主對話卻直接交給 subagent**（和書／舊機相反）：說明裡寫了「翻成繁中」等觸發詞。第二句前沒 `/clear`，主對話判斷已翻過而不重翻，比較沒做成。第一句約 26 秒（subagent 約 12 秒） |
| 4 | 第 2 步：單一 agent vs 3 個並行 subagent 寫排序（4-2 節，縮成 3 語言×2 排序） | ✅ 2026-10-05 完成（由記錄判讀，兩輪都偏離計畫） | 使用者在 cmd 裡用 `$env:` 失敗，改 `set`。**第一輪即使設了 `FORCE_DIRECT_WRITE=1`，模型仍派 code-writer**（全域 CLAUDE.md 鐵律影響行為，不只 hook），73.3 秒、6 檔在根目錄。第二輪：3 個 agent 正確建在專案 `.claude/agents/`，但 `/clear` 後被說「不存在」→ 改派 python-pro／code-writer；3 個 Agent 同一秒派出（16–34 秒），但派工前規劃約 63 秒，總 1 分 52 秒，比第一輪慢。未看成本 |
| 4 | 第 3 步：personal-code-reviewer 比較兩輪的 Go 程式（4-3 節） | ✅ 2026-10-05 完成（由記錄判讀） | 模型自己說明「agent 在 session 開始時載入，要重開」（證實第 2 步推測）。重開後主對話**平行派 2 個審查員**（書上 1 個），用 Go 1.27 實際編譯＋200 組隨機比對全部正確。直接生成 7／7.5（1 項必修：同目錄兩個 `package main`）、subagent 版 8／7.5；幾乎打平，和舊機一致。舊機的 Lomuto 重複值退化**這次兩邊都沒有**（一邊中間 pivot 原地、一邊三路切分）。使用者開的是 `/usage` 不是 `/cost`，無成本數據 |
| 4 | 第 4 步：4 個 subagent 新聞團隊（4-4 節） | ✅ 2026-10-05 完成（由記錄判讀） | 只貼提示詞時模型先停下確認。順序照書：aggregator＋style 同秒派出（2 分 12 秒／5 分 15 秒）→ 等兩者完成才派 summarizer（49 秒）→ page-builder（1 分 36 秒），總約 9 分鐘。自行截桌面／手機寬驗證；刊頭自訂、不用 TIME 商標與新聞照片。agent 定義要存 `output/`，但主對話派工時另指定位置 → 只有風格指南在 `output/`（**主對話指示蓋過 agent 設定**）。仍開 `/usage`，第 4 章無成本數據 |
| 5 | 第 1 步：`claude --chrome` 讀 Console 找圖表錯誤（5-2 節） | ✅ 2026-10-05 完成（由記錄判讀） | 44 秒。navigate → console → network → screenshot → 讀程式碼，找到的 2 個錯誤和舊機相同（`graph`／`graphTrend`、`updateChart(currentCityData)` 傳空物件）。另外用 `git diff` 指出是 `ecc4da1`／`a92812c` 引入、疑似故意放的，**沒擅自修**；並推測 `map.js:35` 點地圖也會錯（註明未實測）。沒提 sb-admin 404 |
| 5 | 第 2 步：Playwright MCP 安裝、測試、修正、點遍縣市（5-3 節） | ✅ 2026-10-05 完成（由記錄判讀） | 三句一次貼，約 6.8 分鐘。MCP 裝在 local scope（無 `.mcp.json`）。除 2 個圖表錯誤外，另找出報酬率少 ÷100、滑桿事件重複綁定、驗證訊息堆疊、sb-admin 404；HTML 直接改，JS 走 code-writer→code-qa。用 `browser_run_code_unsafe` 一次點完 21 縣市只回傳摘要 → **沒遇到截斷**；金門租金資料不足、連江無資料。commit `9f2b6ed`，**嘗試 push 到 FlagTech 原 repo 被 403 拒絕**（全域「commit 後一律 push」造成）。該 session 回覆**飄成英文** |
| 5 | 第 3 步：Playwright CLI＋官方 Skill＋自建 `playwright-test` Skill（5-4 節） | ✅ 2026-10-05 完成（由記錄判讀） | 使用者要求使用者層級 → 官方 skill 用 `--global` 裝到 `~/.claude/skills/playwright-cli`（未提交，教學 session 也看得到）。首測又找到 4 個問題（缺資料留舊值、利率 1.75 vs 2.25、坪數 ≤0、預設 radio），使用者要求修 → writer/QA/reviewer＋重測。自建 SKILL.md 224 行、11 步、`disable-model-invocation: true`、allowed-tools 只開 playwright-cli/curl 等；`/playwright-test` 全過且**遵守「只測不改」**，抓到錯誤框一字一行。新增 21 縣市步驟（從地圖讀清單，約 16 秒）。`/context`：Skills 9.9k 計入、**MCP tools 61.8k 延遲載入不計入** → MCP 佔 context 的問題比書上小。本機累積 4 個 commit 無法 push |
| 6 | 第 1 步：PreToolUse exit 2／PostToolUse exit 2／PreToolUse exit 1（6-2 節前半） | ✅ 2026-10-05 完成（由記錄判讀） | **hook 設定改了立即生效，不必重開**（2.1.289 會偵測設定檔變化）。Claude 預期自己會被擋，把寫檔＋驗證＋commit 合成一個指令（`6852f9a`）。t1 被擋、`No stderr output`、明說不繞過 ✅。t2 PostToolUse 擋不住，事後回報錯誤 ✅。t3 使用者只改 `exit 1`、沒改回 Pre → 實測 Post＋exit 1，檔案被改且模型看不到錯誤。全程無全域 Stop hook 訊息 → `--setting-sources project,local` 有效 |
| 6 | 第 2 步：先 stderr 說明原因再 `exit 2`（6-2 節後半） | ✅ 2026-10-05 完成（由記錄判讀） | **hook 擋住了修改 hook 本身**；使用者說「你來做」模型仍拒絕繞過，並指出 **`!` 指令是使用者執行、不受 hook 攔截**。使用者刪掉 PreToolUse 後，模型一次寫檔＋驗證＋commit（`237aa73`）。測試時錯誤變成指定原因，tasks.json 未變，回覆引用原因，和舊機一致。錯誤訊息固定前綴整段 hook 指令 |
| 6 | 第 3 步：Notification hook → Telegram（6-3 節） | ⏭️ 2026-10-05 **使用者決定這台先跳過**（無 Bot Token） | 旁白／影片：`ch06-step3.txt`／`ch06-step3.mp4` 已做好，之後補做可直接用。建議 Token 由使用者自己填 `.env`，不要貼進對話 |
| 6 | 第 4 步：JSON 輸出 deny → ask → updatedInput（6-4 節） | ✅ 2026-10-05 完成（由記錄判讀） | 書上文件網址已轉到 `code.claude.com/docs/en/hooks`。deny：擋下並顯示原因 ✅。ask：拒絕後模型停下等待，再次要求後允許成功；模型指出原因文字與行為不一致。**updatedInput 和舊機相反**：hook 是模型自己寫的，它知道 Read 會被導向，改用 `cat` 繞開，沒被騙 → 要重現須在不知情的新 session 測。模型自測時多次得到「Wasted call — file unchanged」（重複讀取被快取，hook 根本沒觸發）。已移除 Read hook 並驗證 |
| 6 | 第 5 步：`if` 條件（Write/Edit 只對 tasks.json ask；Bash rm／sudo／chmod deny）（6-5 節前半） | ✅ 2026-10-05 完成（由記錄判讀） | `if`: `Write(**/tasks.json)`、`Edit(**/tasks.json)`、`Bash(rm *)` 等。4 個測試都符合預期，和舊機一致。額外驗證 `echo ok && rm …` 也被擋（子指令分開比對）。被擋時明說不改用 Remove-Item／os.remove 繞過，建議用 `!`。留下 `dummy-hook-test.txt`（模型自己 rm 不掉） |
| 6 | 第 6 步：外部 Python 程式分級（rm/sudo deny、curl/mv ask）＋prompt 型 hook（6-5 節後半） | ✅ 2026-10-05 完成（由記錄判讀） | `.claude/hooks/bash_guard.py`（uv 執行），writer/QA/reviewer 約 11 分鐘；**reviewer 在 Git Bash 實測出 `(rm x)`、`{ rm x; }`、`command rm`、`env rm`、`RM`、`bash -c` 都能繞過**，修正後 45 個自測。mv → ask、rm → deny ✅。prompt 型：`claude-opus-5-5`、timeout 15，**prompt 欄位留空**（產生的 prompt 只貼在對話未寫入），空 prompt 下模型仍自行判斷拒絕 `cat .env`、放行 `cat src/todo.py`。**擋下後 Claude 最後回覆為空，和舊機一致** |
| 7 | 第 1 步：Claude Code Desktop 做訂餐前端＋Preview（7-1 節） | ✅ 2026-10-05 完成（由截圖判讀） | 桌面版：左側依專案分組的對話清單、中間對話（底部切模式／模型／effort、語音輸入）、右側 Preview 是內建瀏覽器分頁（file:// 開 index.html，可直接操作）。分析菜單因 CORS 改為 1.5 秒後回範例菜單（6 品項），合計即時計算正確；送出訂單只跳摘要。commit `4abc238`（無遠端），1 分 37 秒、3.5k tokens |
| 7 | 第 2 步：Remote Control 手機遙控寫 Flask 後端（7-2 節） | ✅ 2026-10-05 完成（由記錄判讀） | `/remote-control` 成功（bridge session、`claude.ai/code/session_…` 網址；遠端 session 的 commit 多一行 `Claude-Session:`）。app.py 214 行，writer→QA 3 案例通過，`bfbdde3`；自建 .gitignore 排除 orders.xlsx。使用者另要求接前端 → `92007f3`（**整合提前在本機完成**，書上留給 7-3）。**收尾用 `taskkill //F //FI "WINDOWTITLE eq *" //IM python.exe` 可能誤殺所有 Python**；測試伺服器仍佔 port 5000（PID 13956） |
| 7 | 第 3 步：Claude Code on the Web 雲端整合（7-3 節） | ✅ 2026-10-05 完成（由 GitHub 結果判讀） | repo `chenghyang2001/k120-ch07-practice`。雲端**直接推到 `before-integration`**（未另開分支）`954cf73`，作者 Claude、帶 `Claude-Session:` trailer。只改 index.html；**和本機 `92007f3` 幾乎相同**（同樣 postJson、同樣 file:// 改連 127.0.0.1:5000），差在本機用行內訊息＋聚焦欄位，雲端沿用 alert |
| 7 | 第 4 步：`claude -p` 分析菜單（7-4 節後半；前半 Telegram Channel 跳過） | ✅ 2026-10-05 完成（由記錄＋程式碼判讀） | 約 20 分鐘，QA 3 輪＋reviewer 2 輪；`menu_analyzer.py` 622 行。可不可最終 30 秒、85 品項（舊機 2 分 15 秒、46 品項），中／大杯拆品項、選項拆短項。`claude -p` 關閉所有工具（防網頁 prompt injection）、移除 `ANTHROPIC_API_KEY`（走訂閱）、10 分鐘快取、同時最多 2 個。**shell=True 與 SSRF 都處理**：參數清單、內網 IP 擋、逐跳轉址檢查＋`--resolve` 釘 IP（防 DNS rebinding）、擋 100.64/10；後端只收本機請求、CORS 只允許本機 → 不能再雙擊 file://。commit `c4532a6`／`35c5856` 已 push。模型誤稱 repo 是「自動化流程建的」（實為使用者第 3 步自建） |
| 7 | 7-4 前半 Telegram Channel 外掛 | ⏭️ 這台先跳過（無 Bot Token） | 外掛已安裝於本機但未設定 token |
| 8 | 第 1 步：直接對話開發數獨＋八項改良（8-2 節） | ✅ 2026-10-06 完成（由記錄判讀） | 一句話 → 不發問，直接做單一 `sudoku.html`（純網頁，和書附一致），**還發布成 claude.ai Artifact 私人連結**（書上沒有），約 4 分鐘。八項：先正確解釋 X-Wing／Swordfish，**列出分級規劃表請使用者確認後才動手**（對齊術語）；第二版約 9.5 分鐘，12 種人類技巧求解器分級、Web Worker 預備題庫、首頁、undo／暫停、自動存檔、4 背景、紀錄、日期種子每日挑戰；Node 測 24 題唯一解，專家 30–700ms。**HTML 不在 writer-QA 清單 → 沒派 agent**；未在瀏覽器實測；使用者沒 git init |
| 8 | 第 2 步：PRD 先行（`完成 @PRD.md`）＋雙星號修正（8-3 節） | ✅ 前半完成；⏭️ **雙星號修正使用者決定跳過**（2026-10-06） | 前半（中場判讀 `ch08-step2b.*`）：先問 GUI → PySide6（舊機 tkinter），先寫 `docs/spec.md`；約 40 分鐘、24 檔、3361 行、測試 77→121；reviewer 抓到「中等幾乎都是簡單題（5/40）、每日挑戰全是簡單題」→ 邊挖邊評分＋換格搜尋＋確定性備用種子修好（80/80、92 天）；專家判定只靠「進階技巧也解不開」，與 PRD「依高級技巧頻率」有落差（正是 PRD-v2 雙星號重點）；只做無視窗截圖（emoji 方框）。commit `98406b4` 已 push 到公開 repo `k120-ch08-practice-prd`；使用者又要求修小問題，writer 進行中。 | 旁白／影片／說明：`ch08-step2.txt`／`.mp4`／`teaching/steps/ch08-step2.md`；範本 `teaching/steps/ch08-step2/{CLAUDE.md,PRD.md,PRD-v2.md}`。練習資料夾 `k120-ch08-practice-prd` |
| 8 | 第 3 步：4 個 subagent 分工開發數獨（8-4 節） | ✅ 2026-10-06 完成（由記錄判讀） | 約 30 分鐘。使用者沒重開 → 叫不到專案 agent，主對話改用 general-purpose 讀角色檔扮演。分階段：Phase 0 主對話建骨架＋`docs/interfaces.md` 介面合約 → Phase 1 logic／data／visual 並行 → Phase 2 ui-engineer 串接 → Phase 3 code-qa（不派 reviewer）。CustomTkinter（舊機 pygame）；**困難／專家最慢 0.66 秒**（舊機 >180 秒，書上「高難度過慢」這次沒發生）。326 測試、QA 54 案例、實開視窗 10 張截圖。commit `fb1bf18` 推到公開 repo `k120-ch08-practice-sub` |
| 8 | 第 4 步：grill-me 反問式開發（8-5 節） | ✅ 2026-10-06 完成（由記錄判讀；「新增暫停、每日挑戰」使用者表示不必再做） | 專案 skill 改名 `grill-me-dev`（避開全域同名的知識測驗 skill）。無參數時先從專案目標問起；帶「開發一個數獨python app」後**共 16 題、每次一題、每題附比較表＋建議答案**，使用者全回「照建議」，問答約 10 分鐘。之後分 4 批開發、每批同步 `doc/spec.md`；tkinter、零相依、390 測試、3.12／3.14 都測、實開視窗截圖，約 47 分鐘，推到公開 repo `k120-ch08-practice-grill`。模型指出 `07741af` 不是它 commit 的（不明程序，未查證） |
| 8 | 第 8 章小結 | — | 對話（HTML，約 14 分，未觸發 writer-QA）／PRD（PySide6，約 40 分）／subagent（CustomTkinter，約 30 分）／grill-me（tkinter，10 分問答＋47 分開發）。舊機 subagent 版高難度出不了題，這次四版都沒有；最大差異來自使用者全域規則（.py 一律 writer→QA→reviewer） |
| 9 | 第 1 步：Karpathy 四原則 CLAUDE.md＋Plan 模式 AskUserQuestion 訪談 → 規格文件（9-1 節） | ✅ 2026-10-07 完成（由記錄判讀；判讀影片 `ch09-wrapup.*`） | 訪談 3 輪×4 題＝12 題，專挑難點：雲端 IP 被 YouTube 擋、字幕一變就截圖會爆量、自動字幕重複無標點、**截圖時點選「區間中點」（書上 9-3 才修的做法，訪談就先問出）**。FastAPI＋純 HTML/JS，翻譯用 `claude -p` 走訂閱。M1 走完整 4 輪 QA＋2 輪審查後，模型主動問開發模式 → 使用者選**快速 demo 模式**。該 session 一路做到 M7（SQLite 佇列、SSE、取消、歷史、HTML/PDF/MD 匯出、Whisper 備援、播放清單；M2 交 VPS Ralph）＝實質完成 9-2～9-4。**坑：app 內 `claude -p` 早期會載入全域設定，被 Stop hook「未提交改動」劫持而不翻譯；最終版加 `--setting-sources= --strict-mcp-config` 隔離** |
| 9 | 第 2–4 步（/goal、Playwright 測試、歷史／翻譯／語音辨識） | ✅ 由上一列的 session 以 M2–M7 實質完成 | 未照書上逐步操作 `/goal` |
| — | **課程完成** | ✅ 2026-10-07 | 跳過：6-3、7-4 前半（Telegram，無 Bot Token）、8-3 雙星號修正 |

原機器第 1 步的判讀重點：

- 那個 session 回報結果時，其實**沒有真的執行 `/doctor`**，是用它記得的資訊回答的。
- 第 1 章的核心觀念：**要確認現況，就讓工具實際量測，不要只聽模型說。**

### 2-1 快速模式進度表（另一台家用電腦）

做法見 `teaching/FAST-RUN.md`。每章結束更新一列，然後 commit＋push（一章一次）。

| 章 | 狀態 | 完成日 | 實際耗時 | 和原機器的差異 |
| --- | --- | --- | --- | --- |
| 1 | ✅ | 2026-10-09 | 26 分（預估 15） | Win10、**npm 全域安裝** 2.1.295（原機器 native 2.1.289）；`/doctor` 會主動提清理建議並改全域設定（停用 4 個已整併 skill、本專案停用 6 個 MCP）；scoop v0.6.0 相同，但同一個 cmd 分頁重開 claude 仍是舊 PATH、找不到 scoop（要開新視窗）；2.1.295 的 `!` 指令輸出會交給模型解讀；`echo $0`＝`/usr/bin/bash` 相同。本章由教練視窗用 `wt-send.ps1` 代操作 |
| 2 | ⬜ | | | |
| 3 | ⬜ | | | |
| 4 | ⬜ | | | |
| 5 | ⬜ | | | |
| 6 | ⬜ | | | |
| 7 | ⬜ | | | |
| 8 | ⬜ | | | |
| 9 | ⬜ | | | |

---

## 3. 新電腦的準備步驟（Windows）

> 全新電腦什麼都沒有，請依序做。**每一步做完都要驗證**，驗證不過就不要往下做。

### 3-1 安裝基本工具

開「PowerShell」（一般權限就可以），一行一行執行：

```powershell
winget install --id Git.Git -e
winget install --id Python.Python.3.12 -e
winget install --id astral-sh.uv -e
winget install --id Gyan.FFmpeg -e
winget install --id VideoLAN.VLC -e
winget install --id OpenJS.NodeJS.LTS -e
winget install --id Microsoft.PowerShell -e
```

用途說明：

- **ffmpeg** 和 **VLC**：做字幕影片、播放影片
- **Node**：第 5 章 Playwright、第 9 章前端會用到
- **PowerShell 7**：書中第 1 章安裝 Claude Code 會用到

**全部裝完後，關掉 PowerShell 再重開一個**，讓新的 PATH 生效。然後驗證：

```powershell
git --version; python --version; uv --version; ffmpeg -version | Select-Object -First 1; node --version
```

### 3-2 安裝 Claude Code（照書 1-2 節，用原生安裝）

```powershell
irm https://claude.ai/install.ps1 | iex
```

裝好後輸入 `claude`，第一次啟動會要求登入，用你的 Claude 帳號（Max 訂閱）登入。

驗證：`claude --version` 要能顯示版本號。

### 3-3 安裝字幕影片需要的 Python 套件

```powershell
python -m pip install edge-tts
python -m edge_tts --help
```

### 3-4 下載本 repo（含範例 submodule）

```powershell
mkdir $env:USERPROFILE\workspace -Force
cd $env:USERPROFILE\workspace
git clone --recurse-submodules https://github.com/chenghyang2001/kindle-120-claude-code-vibe-coding-2e
cd kindle-120-claude-code-vibe-coding-2e
```

驗證：`git submodule status` 要列出 11 行，而且每行開頭**不能是 `-`**。開頭是 `-` 代表沒有抓到內容，要重跑 `git submodule update --init`。

### 3-5 驗證字幕影片工具

```powershell
python teaching\tools\make_caption_video.py --self-test
python teaching\tools\make_caption_video.py teaching\narration\ch01-step1-2.txt --out teaching\videos\test.mp4 --play
```

看到 `SELF_TEST_PASS`，而且 VLC 跳出來，同時有聲音和中文字幕，就代表成功了。

### 3-6 開始接續教學

在 repo 資料夾裡輸入 `claude`，把 `teaching/START-PROMPT.md` 裡「貼這段」的內容整段貼進去。

---

## 4. Repo 結構速查

| 路徑 | 內容 |
| --- | --- |
| `book-summary.md` | 全書 9 章重點整理 |
| `code/00-F6757_support/chNN.md` | 出版社提供的各章提示詞原文 |
| `code/chNN-*` | 各章範例專案，以 submodule 收錄，不要修改 |
| `demo/DEMO-LOG.md` | 原機器實際跑範例的結果和發現的問題，可以拿來對照 |
| `teaching/HANDOFF.md` | 本文件 |
| `teaching/START-PROMPT.md` | 新電腦要貼給 Claude 的接續提示詞 |
| `teaching/LESSON-PLAN.md` | 第 1–9 章的分步教學計畫 |
| `teaching/narration/` | 各步的旁白稿 |
| `teaching/videos/` | 各步的字幕影片 |
| `teaching/tools/make_caption_video.py` | 旁白稿轉成「語音＋同步字幕」影片的工具 |

---

## 5. 相關線上資源（不用登入就能看）

- 語音導讀播放清單（8 段，2 小時 27 分）：<http://187.127.109.145/kindle-120.m3u>
- 簡報網頁（8 段，74 張）：<https://chenghyang2001.github.io/kindle-120-slides/>
- YouTube 影片摘要（8 支，**私人**，要登入 ChengHsien Yang 帳號才能看）：<https://www.youtube.com/playlist?list=PLRcrmTuEzYPo>
- 出版社服務專區：<https://github.com/FlagTech/F6757_support>
- **互動教學影片（2026-10-07 上傳，私人）**：每章一支 9 支 <https://www.youtube.com/playlist?list=PLHr9yRuZVFZk>（說明欄含章節時間軸）；逐步版播放清單 36 支 <https://www.youtube.com/playlist?list=PLUOL3y59b9Bk>；全集長片（含章節）<https://www.youtube.com/watch?v=0Sxt9x7EgCo>。手動上傳時 YouTube 把檔名的 `-` 轉成空白，標題顯示為「K120 01 …」。VPS 狀態檔 `/home/claude/k120-yt/state.json`

---

## 6. 已知的坑（原機器踩過的）

| 狀況 | 原因 | 解法 |
| --- | --- | --- |
| Chrome 或 ffmpeg 遇到中文路徑就失敗 | Windows 命令列參數的編碼問題 | 工具會先在 ASCII 路徑的暫存目錄處理完，再把結果搬過去 |
| 字幕的進度條動不了 | ffmpeg 的 `drawbox` 不能用時間 `t` 做動畫 | 工具已改用 `overlay` 搭配 `eval=frame` |
| Flask 或 uvicorn 關掉之後，port 還被占用 | 自動重新載入（reloader）的子行程沒有一起關掉 | 用 `Get-NetTCPConnection -LocalPort <port>` 找出真正占用的 PID 再關掉 |
| Git Bash 用 curl 送中文 JSON 收到 400 | 編碼問題 | 改用 Python 的 `urllib` |
| 字幕影片工具報 `Unrecognized option 'filter_complex_script'` | winget 現在裝的是 ffmpeg 9，已移除這個舊參數 | 工具已改用 `-/filter_complex`（ffmpeg 7.0 起支援）；2026-10-05 新電腦修正 |
| winget 裝完 ffmpeg／uv 後，終端機還是找不到 | 使用者 PATH 已寫入，但已開啟的終端機不會重讀 | 開新的終端機 |
| 第 9 章下載影片失敗 | 範例鎖定 Python 3.9，新版 yt-dlp 已不支援 | 另外建一個 Python 3.12 的虛擬環境，做法見 `README.md` |
