# 第 8 章 第 2 步：先寫 PRD 再開發數獨（8-3 節）

範本已準備好（從書附 `code/00-F6757_support/ch08.md` 抽出）：

- `teaching\steps\ch08-step2\CLAUDE.md`：uv＋繁中
- `teaching\steps\ch08-step2\PRD.md`：初版 PRD
- `teaching\steps\ch08-step2\PRD-v2.md`：用 `**雙星號**` 標示要修正處的版本

## 1. 建立練習資料夾（cmd）

```bat
set K120=%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
mkdir %USERPROFILE%\workspace\k120-ch08-practice-prd
cd %USERPROFILE%\workspace\k120-ch08-practice-prd
copy %K120%\teaching\steps\ch08-step2\CLAUDE.md .
copy %K120%\teaching\steps\ch08-step2\PRD.md .
git init
claude
```

## 2. 只輸入一句話

```
完成 @PRD.md
```

提醒：.py 會觸發全域 writer → QA → reviewer，規模大；建議回答「中等、不派 reviewer」。

## 3. 執行試玩

```bat
uv run python main.py
```

## 4. 用雙星號修正（書上示範）

先在 cmd 用 v2 取代 PRD.md：

```bat
copy /Y %K120%\teaching\steps\ch08-step2\PRD-v2.md PRD.md
```

再對 Claude 說：

```
我將需修正與未成功實作的內容用**雙星號**標示於 @PRD.md，請幫我修正。
```

## 舊電腦對照

- PRD 版用 tkinter
- 出題評測最快最穩：easy 0.009 秒、medium 0.026 秒、hard 0.045 秒、expert 0.441 秒，全部唯一解

## 請回報四件事

1. 它選了哪個 GUI 套件
2. 花了多久
3. 玩起來功能有沒有都做到
4. 雙星號修正後改了哪些地方
