# 快速 demo 模式（教學演練加速版）

> 依據：第 8 章四個數獨 demo 分別花了 14／40／30／57 分鐘。
> 唯一沒有走 writer → QA → reviewer 的 8-1（HTML）只花 14 分鐘，
> 寫 `.py` 的三個都被全域「程式碼三 agent 鐵律」拖長。

## 時間花在哪裡

| 原因 | 證據 |
| --- | --- |
| 全域「寫 `.py` 必須 writer → QA → reviewer」 | 8-1（HTML，不受規則管）14 分；其餘 30～57 分 |
| reviewer 退件 → 修 → 再驗多輪 | 8-3 PRD 版 QA 3 輪＋審查 2 輪 |
| 做了超出書上要求的事 | 121～390 個測試、實開視窗截圖、建 GitHub repo＋push |
| 停下來等使用者回答 | 每次先問複雜度、GUI；grill-me 問答 10 分鐘 |
| 四個 demo 依序跑 | 合計 141 分鐘 |

## ① 關掉三 agent 鐵律（效果最大）

只設 hook 開關不夠：第 4 章實測過，模型讀到 CLAUDE.md 的鐵律，仍會自己派 agent。**兩個都要做**。

**(a) 啟動前設環境變數（cmd）**

```bat
set DISABLE_WRITER_QA_HOOK=1
claude
```

- 只對這個 cmd 視窗有效，關掉就失效，不會影響其他專案。
- 不要改用 `--setting-sources project,local`：那會連全域的 auto 權限模式一起拿掉，反而每一步都要你按允許，更慢。

**(b) 在練習資料夾的 `CLAUDE.md` 加上這段**

```md
## 本專案例外
本專案是教學 demo，豁免全域「程式碼三 agent 鐵律」：主 Claude 直接寫檔，
不派 code-writer／code-qa／code-reviewer；不需詢問複雜度。
```

## ② 提示詞前面加「速度優先」

```
這是教學 demo，速度優先：
- 只做最小可玩版本，不加未要求的功能
- 測試只跑一次冒煙測試，不寫完整測試套件、不截圖
- 不建 GitHub repo、不 push
- 遇到選擇題直接採用你的建議，不要停下來問我
```

例外：

- **grill-me（8-5）**：提問本身就是重點，**不要加最後一行**。改成問到第 5 題左右回答「其餘全部照建議，開始做」。
- **subagent 分工（8-4）**：派 4 位角色 agent 是重點，保留；只是不要再派 QA／reviewer。
- **Plan 模式訪談（9-1）**：訪談是重點，不要加最後一行。

## ③ 多個 demo 同時跑

練習資料夾彼此獨立時，開多個 cmd 視窗同時啟動。
總時間從「全部加總」變成「最慢那一個」。代價是訂閱額度會集中在同一時段消耗。

注意：**同一個資料夾不要同時開兩個 session**（2-5 實測過，會互相改檔、搶 commit）。

## ④ 換比較快的模型

- `/fast`：快速模式（一樣是 Opus，但輸出比較快）
- `/model`：改用 Sonnet；數獨這種規模不需要最強模型

## 快速 demo 範本（cmd，整段貼上後再貼提示詞）

```bat
set K120=%USERPROFILE%\workspace\kindle-120-claude-code-vibe-coding-2e
set DISABLE_WRITER_QA_HOOK=1
mkdir %USERPROFILE%\workspace\<練習資料夾>
cd /d %USERPROFILE%\workspace\<練習資料夾>
git init
claude
```

進入 Claude Code 後，先貼這句建立專案例外，再貼「速度優先」＋書上的提示詞：

```
在這個資料夾的 CLAUDE.md 最後加上：「## 本專案例外：本專案是教學 demo，豁免全域程式碼三 agent 鐵律，主 Claude 直接寫檔，不派 code-writer／code-qa／code-reviewer；不需詢問複雜度。」
```

## 預估效果

- 參考 8-1（沒走 agent 流程）的 14 分鐘：①② 做到後，每個 demo 預估 10～20 分鐘。
- 再加上 ③ 同時跑：第 8 章全部預估約 20 分鐘。
- 以上是根據記錄的推估，實際以跑過為準。

## ⚠️ 代價

品質會降低。例如 8-3 reviewer 抓到的「中等難度其實是簡單題」、7-4 的 SSRF 漏洞，這類問題都不會被發現。
**適合快速體驗書上流程；要實際使用的程式，請走完整流程。**
