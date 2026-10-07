# Session 1 摘要：K120 互動教學全程（第 1～9 章）＋YouTube 上傳＋K98 啟動

- 日期：2026-10-05 ～ 2026-10-07（同一個 session，約 50 小時）
- 機器：家用機 DESKTOP-6LST1BR（使用者 USER），Windows 11，Claude Code 2.1.289 原生安裝，Opus 5.5
- Repo：`chenghyang2001/kindle-120-claude-code-vibe-coding-2e`（main，本 session 共 43 個 commit，最後 `6ebf510`）

## 完成事項

### 環境（新電腦）

- 補裝 ffmpeg 9.0.2、uv 0.12.23、edge-tts 7.2.8（winget／pip），PowerShell 7.6.6 由使用者自裝
- **修好字幕影片工具相容 ffmpeg 9**：`-filter_complex_script` → `-/filter_complex`（`teaching/tools/make_caption_video.py:273`，commit `63c7e98`）
- 發現 `--self-test` 不碰 ffmpeg，必須實際產生一支影片才算驗證

### 互動教學 K120 第 1～9 章（全部完成）

- 每步：旁白稿 → 字幕影片（VLC 播放）→ 使用者在練習資料夾操作 → 讀練習 session 的 jsonl 判讀 → 更新 `teaching/HANDOFF.md` → commit／push
- 共產生 37 支教學影片（上傳 YouTube 時排除與重做內容重複的舊機 `ch01-step1-2`，所以是 36 支）（`teaching/videos/`）、`teaching/steps/` 說明檔 13 份
- 跳過：6-3、7-4 前半（Telegram，無 Bot Token）、8-3 雙星號修正（使用者決定）
- 9-1 由使用者另一個 session 一路做到 M7（實質涵蓋 9-2～9-4）

### 重要判讀發現（和書上不同）

- 2.1.289：`/doctor` 是模型跑指令的健康檢查＋清理；`/agents` 建立精靈已移除；hook 設定改了立即生效；MCP 工具延遲載入不計入 `/context`
- `/rewind` 只還原 Edit 工具改的檔，Bash 產生的檔案（PDF）不還原
- 專案 agent 在 session 開始時載入，新建後要重開
- updatedInput 騙不了「自己寫 hook 的模型」；prompt 型 hook 擋下後最後回覆為空（和舊機一致）
- 使用者全域規則（writer→QA→reviewer、commit 後 push、Stop hook）是時間差異主因；第 8 章四個數獨 14／40／30／57 分鐘
- app 內 `claude -p` 會被全域 Stop hook 劫持 → 需 `--setting-sources= --strict-mcp-config`

### 新規則與工具

- **學習情境快速 demo 模式**：全域 `~/.claude/instructions/learning-fast-mode.md`，CLAUDE.md 引入，三 agent 鐵律加例外；非正式專案寫程式前先 AskUserQuestion 問（commit `f2fc2e98`，~/.claude repo）
- `teaching/steps/fast-demo.md`（commit `5503f71`）

### YouTube（頻道 ChengHsien Yang，全部私人）

- 全集長片 2:21:53（36 段，含章節）：<https://www.youtube.com/watch?v=0Sxt9x7EgCo>（VPS uploader API 上傳）
- 逐步版 36 支（使用者手動上傳＋API 建清單）：<https://www.youtube.com/playlist?list=PLUOL3y59b9Bk>
- 每章一支 9 支（手動上傳＋API 補說明欄章節＋建清單）：<https://www.youtube.com/playlist?list=PLHr9yRuZVFZk>
- 播放清單 ID 是 API 回傳的新短格式（13 碼），已實測可加入影片與查詢
- 暫存檔已清除；VPS 狀態檔留在 `/home/claude/k120-yt/`（40 KB）

### 本機 NotebookLM 認證修復

- 症狀：缺 `__Secure-1PSIDTS`；新設定檔時 CLI 誤報 Already logged in
- 修法：手動用 `--user-data-dir` 開 Chrome 讓使用者登入 → 殺殘留 chrome 程序 → `notebooklm login --browser chrome` → `notebooklm list` 兩次驗證成功（42 cookies）
- 記入 `~/.claude/instructions/notebooklm-delegation.md` v2.8（commit `470b6f23`，~/.claude repo）

### K98 啟動

- `kindle-98-ai-skill-10x-guide` 建 `teaching/` 結構、複製工具、HANDOFF、START-PROMPT（commit `0e9eec9`、`802268e`，kindle-98 repo）
- 另一個 session 執行階段 0：NotebookLM 12 段萃取 7／12 成功；使用者要求改派 VPS，提示詞已寄 Gmail

## 關鍵技術筆記

- Git Bash 的 PATH 沒有 winget 的 ffmpeg，要手動 export
- 開 VLC 要用 PowerShell `Start-Process`（Git Bash `&` 背景啟動會失敗）
- 使用者在終端機下指令用 cmd（不是 PowerShell）；PowerShell 只用來啟動 VLC／記事本這類 GUI 程式
- YouTube 手動上傳會把檔名的 `-` 轉成空白
- YouTube 配額：每天 10,000，自動發片約用 8,000；上傳 1,600、清單操作 50
- VPS 時區 UTC（台北 02:10 = UTC 18:10）

## 產出檔案

| 檔案 | 說明 |
| --- | --- |
| `teaching/HANDOFF.md` | 進度表（第 1～9 章判讀）、第 0 節教學做法 |
| `teaching/START-PROMPT.md` | 同一台隔天接續提示詞 |
| `teaching/narration/*.txt`、`teaching/videos/*.mp4` | 37 段旁白與字幕影片 |
| `teaching/steps/*.md`、`teaching/steps/ch08-step2/`、`ch08-step4/`、`ch09-step1/` | 每步說明與範本 |
| `teaching/steps/fast-demo.md` | 快速 demo 模式 |
| `teaching/tools/make_caption_video.py` | ffmpeg 9 修正 |
| `~/.claude/instructions/learning-fast-mode.md` | 新全域規則 |
| `~/.claude/instructions/notebooklm-delegation.md` | v2.8 PSIDTS 修法 |
| `kindle-98-ai-skill-10x-guide/teaching/*` | K98 教學骨架 |

## HANDOFF（下次 session 優先處理）

### 立即行動

- [ ] 到 K98 session 貼「提示詞 A」改派 VPS 萃取（已寄 Gmail，主旨「K98 互動教學：改由 VPS 萃取＋換電腦接續用提示詞」）
- [ ] K98 階段 0 完成後確認 book-summary／LESSON-PLAN／DEMO-INDEX，再從第 01 段第 1 步開始
- [ ] 確認本機 NotebookLM 幾天內正常後，刪除 `~/.notebooklm/profiles/default/*.bak-20261007-130353`（62 MB）

### 進行中（需接續）

- K98 NotebookLM 萃取：成功 01、03、04、05、06、09、11；失敗 02、07、08、10、12（重試中，將改由 VPS 執行，結果放 `/home/claude/k98-nlm/status.json`）
- K120 已全部完成；選做：6-3／7-4 Telegram（需 Bot Token）、8-3 雙星號修正、YouTube 標題改回含「-」

### 注意事項

- 使用者本週用量接近上限（約 97%），重活等額度重置
- 非正式專案寫程式前要先問快速 demo 模式（新全域規則）
- 判讀依賴練習 session 的本機 jsonl → 做完一整步才換電腦
- VPS YouTube token（OAuth Testing 模式）約 7 天失效，失效要重新授權
- 某練習 session 曾用 `taskkill //F //FI "WINDOWTITLE eq *" //IM python.exe` 誤殺所有 Python，需留意
