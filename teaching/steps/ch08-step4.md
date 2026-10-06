# 第 8 章 第 4 步：用 grill-me 讓 Claude 反過來問你（8-5 節）

⚠️ 你的全域已有一個同名 `grill-me` skill（「考考我」知識測驗，內容完全不同）。
為避免名稱衝突，這次專案版改名為 **`grill-me-dev`**，內容是書上的中文改版。

## ① 建立資料夾、放入 skill（cmd，整段貼上）

```bat
set K120=%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
mkdir %USERPROFILE%\workspace\k120-ch08-practice-grill
cd /d %USERPROFILE%\workspace\k120-ch08-practice-grill
copy %K120%\teaching\steps\ch08-step2\CLAUDE.md .
mkdir .claude\skills\grill-me-dev
copy %K120%\teaching\steps\ch08-step4\grill-me-dev\SKILL.md .claude\skills\grill-me-dev\
git init
claude
```

## ② 讓它反過來問你（在 Claude Code 貼上）

```
/grill-me-dev 開發一個數獨python app
```

- 它應該**每次只問一題**，並附上**建議答案**。
- 你可以直接回答「照建議」，或自己決定。
- 問完、雙方一致後，再請它開始開發。

## ③ 補齊功能（書上的提示詞）

```
新增暫停功能、每日挑戰
```

## ④ 試玩（另開 cmd）

```bat
cd /d %USERPROFILE%\workspace\k120-ch08-practice-grill
uv run src/main.py
```

（如果它的進入點不是 `src/main.py`，照它說的方式執行。）

## 舊電腦對照

- grill-me 版用 pygame-ce
- **難度最精準**：每種難度的提示數完全固定（hard 一律 27、easy 一律 45）
- 專家級出題較慢：平均 4.8 秒，最慢 9.1 秒

## 請回報四件事

1. 它一共問了幾題、問了哪些面向
2. 每題有沒有附建議答案、是不是一次只問一題
3. 問完之後做出來的 app 和 PRD 版有什麼不同
4. 總共花了多久
