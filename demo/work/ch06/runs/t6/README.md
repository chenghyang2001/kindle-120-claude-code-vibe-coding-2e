#  Todo System

  一個簡單易用的命令列待辦事項管理工具，使用 Python 開發。

  特色

  - 輕量級命令列介面
  - JSON 格式資料儲存
  - 支援任務新增、列表、完成與刪除
  - 可篩選顯示進行中或已完成任務
  - 使用 uv 作為套件管理工具

  快速開始

  - 新增任務
  ```
  uv run src/todo.py add "完成報告" "撰寫月報"
  ```

  - 列出所有任務
  ```
  uv run src/todo.py list
  ```

  - 列出進行中任務
  ```
  uv run src/todo.py list --active
  ```

  - 標記任務完成
  ```
  uv run src/todo.py complete 1
  ```

  - 刪除任務
  ```
  uv run src/todo.py delete 1
  ```

  系統需求

  - Python >= 3.13
  - uv 套件管理工具

  授權

  請根據您的需求添加授權資訊。




