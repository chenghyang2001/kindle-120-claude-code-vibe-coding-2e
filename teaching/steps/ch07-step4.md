# 第 7 章 第 4 步：用 claude -p 分析菜單（7-4 節後半）

7-4 前半的 Telegram Channel 外掛需要 Bot Token，這台先跳過（和第 6 章 6-3 一樣）。
後半的「LLM 分析菜單」不需要 Telegram，直接在終端機做。

## 1. 關掉背景測試伺服器（cmd）

```bat
netstat -ano | findstr :5000
taskkill /PID <最後一欄的 PID> /F
```

## 2. 啟動 Claude Code 並貼提示詞

```bat
cd %USERPROFILE%\workspace\k120-ch07-practice
claude
```

```
我希望寫一個 Python 程式或腳本之類的，
可以做到讓使用者在訂餐表單輸入菜單網頁的網址 (如 https://kebuke.com/menu/) 後，
執行 curl 命令抓取網頁內容，
並用 claude -p 分析這個網頁內容，
然後回傳專案中指定的菜單 json 格式來即時更新這個訂餐網頁，
讓它顯示出這間店的所有品項供使用者訂餐
```

## 3. 實測

```bat
python app.py
```

瀏覽器開 <http://127.0.0.1:5000>，貼 `https://kebuke.com/menu/`，按「分析菜單」，等 1～2 分鐘。

## 舊電腦對照

- 2 分 15 秒、46 個品項，每個品項有杯型／甜度／冰塊／加料四組選項
- 安全疑慮：
  1. `shell=True` 執行外部指令 → 網址夾帶特殊符號可能執行任意指令
  2. 伺服器會抓使用者給的任何網址 → 可被拿來存取內網（SSRF）

## 請回報四件事

1. 它怎麼呼叫 curl 和 `claude -p`
2. 分析花了多久、出現幾個品項
3. 有沒有處理上面兩個安全疑慮
4. 全域規則有沒有讓它走 writer → QA → reviewer
