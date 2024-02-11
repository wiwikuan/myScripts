#!/bin/bash

# opencc 的 command line tool 只能輸入和輸出檔案，有點麻煩；
# 我想要直接可以終端機打 `occ.sh "某些简体中文"`，然後它直接輸出繁體中文，
# 因此才有這個 Script。

# 檢查是否有提供輸入字符串
if [ "$#" -ne 1 ]; then
    echo "使用方法: $0 \"某些中文\""
    exit 1
fi

# 將輸入的字符串保存到臨時檔案中
input=$(mktemp)
echo "$1" > "$input"

# 指定一個臨時檔案作為輸出
output=$(mktemp)

# 執行轉換
opencc -i "$input" -o "$output" -c s2tw.json

# 輸出結果
cat "$output"

# 清理臨時檔案
rm "$input" "$output"
