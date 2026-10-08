# 快速 demo 模式（教學演練加速版，第 1–9 章通用）

> 依據：第 8 章四個數獨 demo 分別花了 14／40／30／57 分鐘。
> 唯一沒有走 writer → QA → reviewer 的 8-1（HTML）只花 14 分鐘，
> 寫 `.py` 的三個都被全域「程式碼三 agent 鐵律」拖長。
> 同樣的狀況在第 2 章（浮水印 33 分鐘）、第 6 章、第 7 章 7-4 都出現過，所以這套做法適用第 1–9 章。

各章怎麼做（資料夾、步驟、對照檢查點、平行建議）見 `teaching/FAST-RUN.md`。

## 時間花在哪裡

| 原因 | 證據 |
| --- | --- |
| 全域「寫 `.py` 必須 writer → QA → reviewer」 | 8-1（HTML，不受規則管）14 分；其餘 30～57 分 |
| reviewer 退件 → 修 → 再驗多輪 | 8-3 PRD 版 QA 3 輪＋審查 2 輪；2-2 浮水印 QA 5 輪＋審查 4 輪 |
| 做了超出書上要求的事 | 121～390 個測試、實開視窗截圖、建 GitHub repo＋push |
| 停下來等使用者回答 | 每次先問複雜度、GUI；grill-me 問答 10 分鐘 |
| 四個 demo 依序跑 | 合計 141 分鐘 |

## ① 關掉三 agent 鐵律（效果最大）

只設 hook 開關不夠：第 4 章實測過，模型讀到 CLAUDE.md 的鐵律，仍會自己派 agent。**兩個都要做**。
用 `teaching\tools\fast-start.bat` 啟動，兩件事會一起做好（見下方範本）。

**(a) 啟動前設環境變數（cmd）**

```bat
set DISABLE_WRITER_QA_HOOK=1
claude
```

- 只對這個 cmd 視窗有效，關掉就失效，不會影響其他專案。`fast-start.bat` 設的更窄：只對它啟動的那個 claude 有效。
- 不要改用 `--setting-sources project,local`：那會連全域的 auto 權限模式一起拿掉，反而每一步都要你按允許，更慢。
  例外是第 6 章：要觀察 hook 本身，必須排除全域 hook，所以第 6 章照用（見 FAST-RUN.md）。

**(b) 在練習資料夾的 `CLAUDE.md` 加上這段**

```md
## 本專案例外

本專案是教學 demo，豁免全域「程式碼三 agent 鐵律」：主 Claude 直接寫檔，不派 code-writer／code-qa／code-reviewer；不需詢問複雜度，也不需詢問是否使用快速模式（已選快速模式）。
```

內容來源是 `teaching/tools/fast-start-exception.md`，`fast-start.bat` 會自動追加，已經有就不重複加。

## ② 提示詞前面加「速度優先」

```
這是教學 demo，速度優先：
- 只做最小可玩版本，不加未要求的功能
- 測試只跑一次冒煙測試，不寫完整測試套件、不截圖
- 不建 GitHub repo、不 push
- 遇到選擇題直接採用你的建議，不要停下來問我
```

不寫程式的章節（第 1、3 章）不用加。

## ③ 多個 demo 同時跑

練習資料夾彼此獨立時，開多個 cmd 視窗同時啟動。
總時間從「全部加總」變成「最慢那一個」。代價是訂閱額度會集中在同一時段消耗。
哪些章可以一起跑，見 FAST-RUN.md「平行執行建議」。

注意：**同一個資料夾不要同時開兩個 session**（2-5 實測過，會互相改檔、搶 commit）。

## ④ 換比較快的模型

- `/fast`：快速模式（一樣是 Opus，但輸出比較快）
- `/model`：改用 Sonnet；書上範例這種規模不需要最強模型

## 各章例外

重點本身就是「提問」或「派 agent」的步驟，那部分照書做，只省略 QA／reviewer：

| 章／步 | 例外 |
| --- | --- |
| 第 1 章 1-2 節 | `/doctor` 一定要實際跑，不能讓模型憑印象回答 |
| 第 4 章 | 派 subagent 是重點，全部保留；只是不再派 QA／reviewer |
| 第 6 章 | 改用 `claude --setting-sources project,local` 排除全域 hook；6-3 Telegram 略過 |
| 第 7 章 | 只做 7-1（Desktop＋Preview）；7-2～7-4 略過，因為需要手機、雲端或 Telegram |
| 第 8 章第 3 步（8-4 節 subagent） | 派 4 位角色 agent 是重點，保留；不要再派 QA／reviewer |
| 第 8 章第 4 步（8-5 節 grill-me） | 提問本身是重點，**不要加②的最後一行**；問到第 5 題左右回答「其餘全部照建議，開始做」 |
| 第 9 章第 1 步（Plan 模式訪談） | 訪談是重點，**不要加②的最後一行** |
| 第 9 章第 4 步（AI 翻譯） | 書上要 API key，改用本機 `claude -p` 走 Max 訂閱 |

## 快速 demo 範本（cmd）

```bat
cd /d %USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
teaching\tools\fast-start.bat <練習資料夾>
```

`fast-start.bat` 會：

1. 資料夾 `%USERPROFILE%\workspace\<練習資料夾>` 不存在就建立並 `git init`；已存在就沿用、不清空
2. CLAUDE.md 沒有「本專案例外」才追加
3. `set DISABLE_WRITER_QA_HOOK=1`、`cd /d` 到資料夾、啟動 `claude`

加 `--no-launch` 只做 1、2，不啟動 claude（第 6 章、第 7 章 Desktop 用）。
進入 Claude Code 後，貼「速度優先」＋書上的提示詞。

## 預估效果

- 參考 8-1（沒走 agent 流程）的 14 分鐘：①② 做到後，每個 demo 預估 10～20 分鐘。
- 再加上 ③ 同時跑：第 8 章全部預估約 20 分鐘。
- 第 1–9 章各章預估見 FAST-RUN.md 總覽表。
- 以上是根據記錄的推估，實際以跑過為準。

## ⚠️ 代價

品質會降低。例如 8-3 reviewer 抓到的「中等難度其實是簡單題」、7-4 的 SSRF 漏洞，這類問題都不會被發現。
**適合快速體驗書上流程；要實際使用的程式，請走完整流程。**
