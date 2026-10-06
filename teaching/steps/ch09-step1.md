# 第 9 章 第 1 步：Karpathy 四原則 CLAUDE.md＋Plan 模式訪談（9-1 節）

範本（從書附 `code/00-F6757_support/ch09.md` 抽出）：

- `teaching\steps\ch09-step1\CLAUDE.md`：Karpathy 四原則＋uv 環境管理
- `teaching\steps\ch09-step1\prompt.txt`：YouTube 轉投影片的需求提示詞

## ① 建立資料夾（cmd，整段貼上）

```bat
set K120=%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
mkdir %USERPROFILE%\workspace\k120-ch09-practice
cd /d %USERPROFILE%\workspace\k120-ch09-practice
copy %K120%\teaching\steps\ch09-step1\CLAUDE.md .
git init
claude
```

## ② 切到 Plan 模式

按 `Shift + Tab`，直到畫面下方顯示 **plan mode**。

## ③ 貼上需求提示詞（在 Claude Code 貼上）

```
我希望開發一個能夠將 YouTube 影片轉換為靜態閱讀版本 （投影片） 的 Web 應用程式。

主要功能如下：
1. YouTube 影片處理
-支援透過 YouTube URL 來下載 YouTube 影片
-取得標題、時長、縮圖等影片資訊
-取得影片主要語言的字幕檔

2. 字幕處理
-支援多語言字幕 （zh-TW, zh-CN, en, ja, ko）
-自動翻譯功能
-時間軸同步處理

3. 投影片生成
-當字幕變換時，使用 ffmpeg 截取關鍵幀
-可調整畫質 （360p/480p/720p/1080p）
-圖片壓縮與最佳化

請先使用 AskUserQuestion 工具詳細詢問我，例如技術實作、UI/UX 設計，不要問顯而易見的問題，要挖掘我可能沒想到的難點。訪談完成後，請設計完整的規格文件。
```

## ④ 回答訪談

- 它會用選單（AskUserQuestion）一題一題問你。
- 可以選建議選項，也可以選 Other 自己打字。
- **這一步只到「規格文件」為止**，計畫出來後先不要讓它開始實作（下一步才用 `/goal` 實作）。

## 觀察重點

- 訪談問了哪些「你沒想到的難點」（例如字幕沒有、YouTube 擋下載、著作權、長影片處理時間）
- Karpathy「簡單優先、不為不可能情況寫錯誤處理」和你全域 CLAUDE.md「一定要錯誤處理、writer→QA」互相衝突時，它怎麼取捨

## 舊電腦對照

- 書附範例 `ch09-YouTube2Slides`：前後端分離＋ffmpeg
- 範例鎖 Python 3.9，新版 yt-dlp 已不支援 → 解析 YouTube 失敗；要改用 Python 3.12＋新版 yt-dlp

## 請回報三件事

1. 訪談一共問了幾題、哪幾題是你沒想到的
2. 規格文件寫了哪些技術選擇（前後端、下載工具、翻譯方式）
3. 它怎麼處理 Karpathy 規則和你全域規則的衝突
