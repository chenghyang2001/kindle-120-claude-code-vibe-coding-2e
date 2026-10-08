# 另一台家用電腦：快速模式重跑第 1–9 章

先 `git pull` 本 repo 和 `~/.claude`，再在 repo 資料夾（`%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e`）輸入 `claude`，整段貼上：

```
我要在另一台家用電腦，用快速 demo 模式重跑 K120《Claude Code Vibe Coding 開發手冊 第 2 版》第 1–9 章。

這次已經決定用快速模式：不要再問我要用哪種模式；不做旁白稿和字幕影片（不用 VLC、edge-tts），說明一律在聊天視窗用文字。

請先讀：
1. teaching/FAST-RUN.md：各章的練習資料夾、步驟、保留／省略、對照檢查點、平行建議
2. teaching/steps/fast-demo.md：快速模式三件事和各章例外

開始前先確認環境：claude、uv、ffmpeg、git、gh 都要能執行（ffmpeg 第 9 章需要）。缺什麼就告訴我怎麼補，不要跳過。

做法：
- 一律繁體中文。我用 cmd，指令用 %USERPROFILE%、set，不要給 $env:。
- 每次帶一章：告訴我用 teaching\tools\fast-start.bat 開哪個練習資料夾，以及每一步要貼的提示詞（指向 code/00-F6757_support/chNN.md 的哪一節，原文很短就直接列出）。
- 我在另一個終端機操作，回報後（或只說 proceed next 時，直接讀練習資料夾的對話記錄判讀），用 3–5 行比對「和原機器有什麼不同、原因是什麼」，對照 FAST-RUN.md 的檢查點、demo/DEMO-LOG.md 和 teaching/HANDOFF.md 第 2 節。
- 每章結束時更新 teaching/HANDOFF.md 的「快速模式進度表」（完成日、實際耗時、和原機器的差異），然後 commit 並 push。一章只 commit 一次。

從第 1 章開始。
```

---

# 同一台電腦隔天接續（2026-10-06 起用這段）

在 repo 資料夾（`%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e`）輸入 `claude`，貼上：

```
我要接續 K120《Claude Code Vibe Coding 開發手冊 第 2 版》的互動式教學演練（同一台家用機，昨天做到第 7 章結束）。

請先讀：
1. teaching/HANDOFF.md，特別是「0. 明天從這裡開始」那一節（教學做法、環境狀態）和第 2 節進度表
2. teaching/LESSON-PLAN.md 第 8、9 章
3. code/00-F6757_support/ch08.md

規則照 HANDOFF.md：繁體中文；每步要語音＋同步字幕影片（用 Start-Process 開 VLC 播放）＋聊天文字版＋teaching/steps/ 說明檔（用記事本開）；一次只講一步；我說 proceed next 時，直接讀練習資料夾的對話記錄來判讀；指出和書上不同的地方與原因；每步更新 HANDOFF.md 進度表並 commit、push。

從第 8 章第 1 步（8-2 直接對話開發數獨）開始：旁白和影片已經做好了，請直接重播 teaching/videos/ch08-step1.mp4，並用記事本打開 teaching/steps/ch08-step1.md。
```

---

# 新電腦接續提示詞

新電腦完成 `HANDOFF.md` 第 3 節的準備步驟後，照下面做：

1. 在 repo 資料夾（`%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e`）裡輸入 `claude` 啟動
2. 把下面「貼這段」整段複製貼上

---

## 貼這段

```
我要接續《Claude Code Vibe Coding 開發手冊 第 2 版》（K120）的互動式教學演練。這台是新電腦，之前在另一台電腦做到一半。

請先讀這三個檔案，了解規則和進度：
1. teaching/HANDOFF.md：教學規則、目前進度、已知的坑
2. teaching/LESSON-PLAN.md：第 1–9 章的分步計畫
3. book-summary.md：全書重點

教學規則（一定要遵守）：
- 一律用繁體中文。
- 每一步都要「語音＋同步字幕」：
  - 先寫口語化的旁白稿到 teaching/narration/chNN-stepX.txt（不放表格和符號）
  - 再執行 python teaching/tools/make_caption_video.py <旁白稿> --out teaching/videos/<同名>.mp4 --title "<標題>" --play
  - 聊天視窗裡也要附同樣內容的文字版
- 每次只講一步，講完就停下來，等我回報結果，不要一次講完整章。
- 我會在另一個終端機操作，練習資料夾是 %USERPROFILE%\workspace\k120-chNN-practice。
- 判讀我的結果時，要指出和書上不同的地方，以及原因。
- 書上的提示詞原文在 code/00-F6757_support/chNN.md；舊電腦跑範例的結果在 demo/DEMO-LOG.md，可以對照。

開始前請先確認環境：python teaching/tools/make_caption_video.py --self-test 要通過；ffmpeg、VLC、edge-tts 都要可用。缺什麼就告訴我怎麼補，不要跳過。

然後從 HANDOFF.md 標示「⏳ 從這裡接續」的那一步開始：
- 這台新電腦是照書 1-2 節用原生安裝的。請先帶我用 /doctor 實際確認安裝方式、版本、自動更新三項（第 1 步重做，這次要真的跑工具，不要憑印象回答）。
- 確認完再進行第 2 步：請 Claude Code 安裝 scoop。

每完成一步，就更新 teaching/HANDOFF.md 的進度表，然後 git commit 並 push。
```

---

## 如果新電腦是 macOS

做法相同，只有兩點不一樣：

- 準備步驟改用 `brew install git python@3.12 uv ffmpeg node` 和 `brew install --cask vlc`
- 第 2 步書上的提示詞是用 Homebrew（macOS 本來就會用 Homebrew，所以這一步改成確認 Homebrew 的狀態）

字幕影片工具會自動抓 macOS 的中文字型（PingFang）。
