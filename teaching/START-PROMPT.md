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
