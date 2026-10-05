# 第 7 章 第 1 步：用 Claude Code Desktop 做訂餐前端＋Preview（7-1 節）

本機已安裝 Claude 桌面版（1.52386.3.0）。

## 步驟

### 1. 建立空白練習資料夾（在 cmd 執行）

```bat
mkdir %USERPROFILE%\workspace\k120-ch07-practice
cd %USERPROFILE%\workspace\k120-ch07-practice
git init
```

### 2. 打開 Claude 桌面版

- 切到 **Code** 分頁
- 選擇資料夾：`%USERPROFILE%\workspace\k120-ch07-practice`

### 3. 貼上書上的提示詞（整段複製）

```
幫我建立一個訂餐系統的前端頁面 index.html，需要包含：
1. 頁面標題「旗標訂餐系統」
2. 一個輸入框讓使用者貼入菜單網址，旁邊有「分析菜單」按鈕
3. 分析中要顯示 loading 狀態
4. 分析完成後，用卡片方式顯示每個品項（品名、價格、客製化選項下拉選單），以及對應的數量輸入框
5. 每個品項卡片底部有備註輸入框（placeholder：例如：不要香菜、少冰）
6. 頁面底部有姓名輸入框和「送出訂單」按鈕
樣式要簡潔乾淨，用純 HTML + CSS + JavaScript，不要用框架。
完成後開 Preview 讓我確認。
```

### 4. 在 Preview 裡實際操作

- 目前還沒有後端，按「分析菜單」拿不到真的資料，看它怎麼處理。

## 觀察重點

- 桌面版和終端機版有什麼不一樣
- Preview 怎麼呈現，能不能直接在裡面點按鈕

## 請回報三件事

1. 桌面版的操作畫面和終端機有什麼不同
2. Preview 有沒有自動打開，網頁長什麼樣子
3. 按「分析菜單」時發生了什麼事

## 第 7 章後續步驟預告（每次只做一步）

| 步 | 節 | 內容 |
| --- | --- | --- |
| 1 | 7-1 | Claude Code Desktop 做前端＋Preview（本步） |
| 2 | 7-2 | Remote Control：從手機遙控，寫 Flask 後端 `app.py`（/api/analyze 假資料、/api/order 寫 orders.xlsx） |
| 3 | 7-3 | Claude Code on the Web：連 GitHub，在雲端整合前後端，再拉回本機 |
| 4 | 7-4 | Telegram Channel 外掛（需要 Bot Token，這台可能先跳過） |
