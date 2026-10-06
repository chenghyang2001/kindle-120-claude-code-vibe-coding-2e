# 第 8 章 第 3 步：4 個 subagent 分工開發數獨（8-4 節）

## ① 建立資料夾、複製範本（cmd，整段貼上）

```bat
set K120=%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
mkdir %USERPROFILE%\workspace\k120-ch08-practice-sub
cd /d %USERPROFILE%\workspace\k120-ch08-practice-sub
copy %K120%\teaching\steps\ch08-step2\CLAUDE.md .
copy %K120%\teaching\steps\ch08-step2\PRD.md .
git init
claude
```

## ② 請 Claude 建立 4 個專案 subagent（在 Claude Code 貼上）

```
在這個專案的 .claude/agents/ 建立四個 subagent，不要放在全域：
1. game-logic-engineer：你是遊戲邏輯工程師，負責數獨題目的生成、解題驗證與難度分級。難度分級需參考人類解題時使用進階技巧（X-Wing、Swordfish）的頻率，以及挖空格數的多寡。題目生成請使用最小剩餘值啟發法與回溯搜尋，確保生成速度流暢不卡頓。
2. ui-engineer：你是介面工程師，負責遊戲畫面的排版、按鈕配置、鍵盤操作與高亮顯示等互動功能。操作邏輯需符合直覺，並與遊戲邏輯工程師產出的模組串接。
3. data-engineer：你是資料工程師，負責自動存檔、遊玩紀錄、生涯總覽，以及每日挑戰的題目種子與連續天數記錄。存檔需於每次填入及每秒計時時自動觸發，確保重新開啟程式後可繼續上次進度。
4. visual-designer：你是視覺設計師，負責整體美術風格、色彩主題切換、深色模式，以及色塊與邊框的精緻化。深色模式下需確保九宮格線條清晰可見，整體風格需現代、簡潔。
```

## ③ 重新啟動，讓 agent 載入

```
/exit
```

```bat
claude
```

輸入 `@` 確認選單裡有這 4 個 agent。

## ④ 分工開發（在 Claude Code 貼上）

```
請四位 agent 依照各自的職責，協作完成 @PRD.md 中的數獨專案。
```

## ⑤ 試玩（另開 cmd）

```bat
cd /d %USERPROFILE%\workspace\k120-ch08-practice-sub
uv run python main.py
```

## ⑥ 書上的修改提示（遇到同樣問題時用）

```
遊戲完成後按鈕與文字重疊，以及高難度題目生成過慢。
```

## 觀察重點

- 主對話有沒有真的派這 4 個 agent，還是因為全域鐵律改派 code-writer
- 4 個 agent 是同時跑，還是有先後順序（介面要等邏輯模組）
- 4 個 agent 之間怎麼串接，介面有沒有對不上

## 舊電腦對照

- subagent 版用 pygame
- **困難／專家 180 秒內出不了一題**（出題器每次都做完整技巧分級、最多試 10 次）——正對應書上「高難度題目生成過慢」的修改提示
- 測試寫死作者電腦路徑 `C:\Users\Admin\subagent sudoku`

## 請回報四件事

1. 主對話派了哪些 agent、順序如何
2. 選了哪個 GUI 套件、花了多久
3. 困難和專家出題快不快
4. 有沒有按鈕和文字重疊
