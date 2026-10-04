# Kindle 120《Claude Code Vibe Coding 開發手冊 第 2 版》範例演練

旗標《Claude Code Vibe Coding 開發手冊 第 2 版》（施威銘研究室，2026/06，書號 F6757，ISBN 978-986-312-886-1）的書附範例全章演練紀錄。

這本書手上沒有內文，章節整理是用博客來的簡介和目錄，加上出版社的書附服務專區整理出來的。

## 目錄

| 路徑 | 內容 |
| --- | --- |
| `book-summary.md` | 全書 9 章的整理，每段標明來源：〔簡介〕〔服務專區〕〔範例〕〔推論〕 |
| `code/` | 書附範例，共 11 個 **git submodule**，演練過程完全沒有修改 |
| `code/00-F6757_support/` | 出版社服務專區（[FlagTech/F6757_support](https://github.com/FlagTech/F6757_support)），有各章提示詞和第 3 章的 context 計算說明 |
| `demo/DEMO-LOG.md` | **逐章演練結果、找到的 bug、評測數據** |
| `demo/screenshots/` | 驗證截圖 |
| `demo/logs/` | 執行紀錄，包括 ch06 hook 10 個情境的解析結果、ch08 出題器評測 |
| `demo/outputs/` | 演練產物：浮水印 PDF、譯文、程式碼審查報告、菜單 JSON、訂單 Excel、處理任務的結果 |
| `demo/work/` | 演練用的工作區：ch04 的 subagent 定義、ch06 的 hook 設定檔和專案副本 |

## 快速開始

```bash
git clone --recurse-submodules https://github.com/chenghyang2001/kindle-120-claude-code-vibe-coding-2e
cd kindle-120-claude-code-vibe-coding-2e

# 第 2 章 PDF 浮水印
cd code/ch02-F6757_ch02 && uv run create_test_pdf.py && uv run watermark.py test.pdf

# 第 5 章 臺灣房價地圖（submodule 已固定在 update_data 分支的 commit）
cd code/ch05-test_buyhouse && uv run wsgi.py      # http://127.0.0.1:5000

# 第 9 章 後端：repo 鎖定的 Python 3.9 會讓 yt-dlp 太舊而下載失敗，改用 3.12
uv venv --python 3.12 demo/work/ch09-venv312
uv pip install --python demo/work/ch09-venv312 -r code/ch09-YouTube2Slides/backend/pyproject.toml
uv pip install --python demo/work/ch09-venv312 -U yt-dlp
cd code/ch09-YouTube2Slides/backend && ../../../demo/work/ch09-venv312/Scripts/python.exe app.py
```

## 重點發現

- **第 4 章**：沒有明確 `@` 指名時，主 agent 會自己做，不會委派給 subagent。小任務用並行 subagent 反而比較貴。
- **第 5 章**：範例刻意埋了兩個 bug，已找出根因，並在瀏覽器裡驗證修正可行。
  1. 模板宣告 `graph`，使用時卻寫 `graphTrend`
  2. `updateChart` 傳進去的是空物件
- **第 6 章**：Hook 10 個情境全部和書上一致。
  - `updatedInput` 偷換讀取的檔案時，模型完全不知情
  - prompt 型 hook 擋下後，模型最後的回覆是空字串
- **第 8 章**：subagent 版的 hard／expert 難度 180 秒內出不了一題，正好對應書中 8-4 最後提出的修改。PRD 版最快也最穩定。
- **第 9 章**：`.python-version` 鎖定 3.9，導致 yt-dlp 被卡在舊版而無法下載 YouTube 影片。改用 3.12 後，19 分鐘的影片 66 秒產出 421 張投影片。

範例程式碼的著作權屬於旗標科技與原作者，本 repo 只用於個人學習。
