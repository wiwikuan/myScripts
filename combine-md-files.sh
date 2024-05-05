#!/bin/bash

# combine-md-files.sh
# 搜尋當前目錄下所有具有特定前綴的 Markdown (.md) 檔案，
# 並將它們的內容組合成一個單一的輸出檔案。

# 檢查是否提供了足夠的參數
# Check if enough arguments are provided
if [ $# -lt 2 ]; then
  echo "用法: $0 <前綴> <輸出檔案>"
  echo "Usage: $0 <prefix> <output_file>"
  exit 1
fi

# 設置要組合的 .md 檔案的前綴
# Set the prefix for the .md files to combine
prefix="$1"

# 設置輸出檔案名稱
# Set the output file name
output_file="$2"

# 找到所有具有指定前綴的 .md 檔案並遞歸組合它們
# Find all .md files with the specified prefix recursively and combine them
echo "正在搜尋具有前綴 '$prefix' 的 .md 檔案..."
echo "Searching for .md files with prefix '$prefix'..."
files=$(find . -type f -name "${prefix}*.md")

# 檢查是否找到任何符合條件的檔案
# Check if any matching files are found
if [ -z "$files" ]; then
  echo "找不到具有前綴 '$prefix' 的 .md 檔案。"
  echo "No .md files found with prefix '$prefix'."
  exit 0
fi

# 組合找到的 .md 檔案到輸出檔案，並在每個檔案的開頭添加原始檔案名稱
# Combine the found .md files into the output file, adding the original filename at the beginning of each file
echo "正在組合找到的 .md 檔案到 '$output_file'，並添加原始檔案名稱..."
echo "Combining found .md files into '$output_file', adding original filenames..."
for file in $files; do
  echo "--- $(basename "$file") ---" >> "$output_file"
  echo "" >> "$output_file"  # 添加空行
  cat "$file" >> "$output_file"
  echo "" >> "$output_file"
done

# 輸出完成訊息
# Print the completion message
echo "已將所有具有前綴 '$prefix' 的 .md 檔案組合到 '$output_file'，並添加了原始檔案名稱。"
echo "Combined all .md files with prefix '$prefix' into '$output_file', with original filenames added."
