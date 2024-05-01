#! /bin/bash

# 這個 bash 腳本的目的是移除 PNG 圖片檔名中的 "-crunch" 後綴
# 通常這個後綴是由 PNG 壓縮軟體 crunch 在壓縮圖片時自動添加的
# 執行此腳本可以批次將當前目錄中所有符合 "*-crunch.png" 模式的圖片檔重新命名
# 移除其檔名中的 "-crunch" 部分，還原為原始的檔名
# 注意，這會覆寫原始的 PNG 檔案

for file in *-crunch.png; do mv "$file" "${file/-crunch/}"; done
