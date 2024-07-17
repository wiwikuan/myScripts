#!/bin/bash

echo "在下方貼上文字。按 Ctrl+D 結束輸入："

# 讀取多行輸入
input=$(cat)

# 使用 sed 擷取 URL
urls=$(echo "$input" | sed -En 's/.*((https?:\/\/)[^ )]*)[ )].*/\1/gp')

# 檢查是否找到 URL
if [ -n "$urls" ]; then
    echo -e "\n擷取到的 URL："
    echo "$urls"
else
    echo -e "\n在輸入的文字中沒有找到 URL。"
fi
