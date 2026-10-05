# 第 7 章 第 3 步：Claude Code on the Web 雲端整合（7-3 節）

本機在第 2 步已經把前後端整合好了（commit `92007f3`）。
這一步讓雲端從**整合之前**的版本（commit `bfbdde3`）重做一次，再和本機結果比較。

## 0. 先關掉背景的測試伺服器（佔著 port 5000）

```bat
netstat -ano | findstr :5000
taskkill /PID <上面最後一欄的 PID> /F
```

## 1. 推上 GitHub（cmd）

```bat
cd %USERPROFILE%\workspace\k120-ch07-practice
gh repo create chenghyang2001/k120-ch07-practice --public --source . --push
git branch before-integration bfbdde3
git push -u origin before-integration
```

## 2. 打開網頁版

- 瀏覽器開 <https://claude.ai/code>
- 第一次要連結 GitHub，並允許存取 `k120-ch07-practice`

## 3. 選 repo 與分支，貼提示詞

- Repo：`chenghyang2001/k120-ch07-practice`
- 分支：`before-integration`

```
幫我整合前端 @index.html 和後端 @app.py
```

## 4. 觀察

- 雲端怎麼執行、要不要你允許權限
- 完成後推到 GitHub 的新分支名稱

## 5. 拉回本機比較（cmd）

```bat
git fetch origin
git branch -r
git diff 92007f3 origin/<雲端的新分支名稱> -- index.html app.py
```

## 請回報三件事

1. 網頁版連 GitHub 的過程順不順利
2. 雲端完成後，新分支叫什麼名字
3. 雲端整合和本機整合有什麼不一樣
