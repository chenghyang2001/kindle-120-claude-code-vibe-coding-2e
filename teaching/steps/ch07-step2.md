# 第 7 章 第 2 步：Remote Control，用手機遙控寫後端（7-2 節）

## 步驟

### 1. 在終端機啟動（cmd）

```bat
cd %USERPROFILE%\workspace\k120-ch07-practice
claude
```

### 2. 開啟遠端控制

在 Claude Code 裡輸入：

```
/remote-control
```

畫面會出現網址或 QR code。

### 3. 用手機連上

用手機開 Claude App（或掃 QR code），找到這個對話。

### 4. 在手機上貼提示詞（可先把這段傳到手機）

```
幫我建立後端 app.py，使用 Flask，需要：
1. POST /api/analyze：接收 JSON {"url": "餐廳網址"}，
目前先回傳假資料（之後會換成真的分析），假資料格式：
{"items": [{"name": "大腸麵線", "price": 60, "options": ["正常", "少辣", "不辣"]},
...]}
2. POST /api/order：接收訂單資料，寫入 orders.xlsx，
欄位：姓名、分機、品項、選項、備註、數量、金額、送出時間
3. 允許跨域（CORS）讓前端可以呼叫
需要的套件：flask, flask-cors, openpyxl。
完成後告訴我怎麼啟動。
```

### 5. 觀察

- 電腦端終端機會不會同步顯示手機下的指令和回應
- 需要權限時，手機上能不能直接按允許

### 6. 啟動後端

照它說的方式啟動。port 5000 目前是空的（已檢查）。

## 補充：伺服器模式

```bat
claude remote-control
```

不進入對話畫面，專門給遠端連線用。可以和 `/remote-control` 比較差別。

## 請回報三件事

1. 手機怎麼連上的，畫面長什麼樣子
2. 手機下的指令，電腦端有沒有同步顯示
3. 後端用什麼指令啟動，有沒有成功
