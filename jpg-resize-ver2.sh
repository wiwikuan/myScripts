#!/bin/bash

usage() {
    echo "用法: $0 <輸入文件> [-l <最大寬度或高度>] [-p <縮放百分比>] [-s <目標大小(kB)>]"
    echo "至少需要指定 -l、-p 或 -s 中的一個選項"
    echo "注意: -l 和 -p 選項不能同時使用"
    exit 1
}

# 初始化變數
input_file=""
max_dimension=""
scale_percent=""
target_size=""

# 檢查第一個參數是否為輸入文件
if [ $# -lt 1 ]; then
    echo "錯誤: 請指定一個輸入文件"
    usage
fi

input_file="$1"
shift

# 解析命令行參數
while getopts ":l:p:s:" opt; do
    case $opt in
        l) max_dimension="$OPTARG" ;;
        p) scale_percent="$OPTARG" ;;
        s) target_size="$OPTARG" ;;
        \?) echo "無效選項: -$OPTARG" >&2; usage ;;
        :) echo "選項 -$OPTARG 需要一個參數" >&2; usage ;;
    esac
done

# 檢查是否至少指定了一個選項
if [ -z "$max_dimension" ] && [ -z "$scale_percent" ] && [ -z "$target_size" ]; then
    echo "錯誤: 請至少指定 -l、-p 或 -s 中的一個選項"
    usage
fi

# 檢查 -l 和 -p 是否同時使用
if [ -n "$max_dimension" ] && [ -n "$scale_percent" ]; then
    echo "錯誤: -l 和 -p 選項不能同時使用"
    usage
fi

# 檢查輸入文件是否存在
if [ ! -f "$input_file" ]; then
    echo "錯誤: 輸入文件 '$input_file' 不存在"
    exit 1
fi

# 生成輸出文件名（始終使用 .jpg 擴展名）
filename=$(basename -- "$input_file")
filename="${filename%.*}"
output_file="${filename}_resized.jpg"

# 構建 convert 命令
convert_cmd="convert \"$input_file\""

if [ -n "$max_dimension" ]; then
    convert_cmd+=" -resize ${max_dimension}x${max_dimension}>"
elif [ -n "$scale_percent" ]; then
    convert_cmd+=" -resize ${scale_percent}%>"
fi

if [ -n "$target_size" ]; then
    convert_cmd+=" -define jpeg:extent=${target_size}kb"
fi

convert_cmd+=" \"$output_file\""

# 執行轉換
echo "Executing: $convert_cmd"
eval $convert_cmd 2>&1 | grep -v "unable to open image \`extent="

# 檢查輸出文件是否存在和大小是否大於 0
if [ -f "$output_file" ] && [ -s "$output_file" ]; then
    echo "轉換成功: 輸出文件為 $output_file"
else
    echo "錯誤: 轉換失敗"
    exit 1
fi
