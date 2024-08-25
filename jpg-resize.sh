#!/bin/bash

# 檢查參數數量
if [ "$#" -ne 3 ]; then
    echo "用法: $0 <輸入文件> <縮放百分比> <目標大小(kB)>"
    exit 1
fi

input_file="$1"
scale_percent="$2"
target_size="$3"

# 檢查輸入文件是否存在
if [ ! -f "$input_file" ]; then
    echo "錯誤: 輸入文件 '$input_file' 不存在"
    exit 1
fi

# 生成輸出文件名（始終使用 .jpg 擴展名）
filename=$(basename -- "$input_file")
filename="${filename%.*}"
output_file="${filename}_resized.jpg"

# 執行轉換，強制輸出為 JPG 格式
convert "$input_file" -resize "${scale_percent}%" -define jpeg:extent="${target_size}kb" "$output_file"

# 檢查轉換是否成功
if [ $? -eq 0 ]; then
    echo "轉換成功: 輸出文件為 $output_file"
else
    echo "錯誤: 轉換失敗"
    exit 1
fi
