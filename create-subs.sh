# create-subs.sh
# 將 NiceChord 字幕工具產生的 .srt 字幕檔轉換成 .ass 和 .vtt 格式
# 並對 .ass 檔案進行樣式設定。

# 將腳本的第一個參數（即輸入的 .srt 檔案名）賦值給變數 name
name=$1

# 使用 ffmpeg 將 .srt 檔案轉換成 .ass 格式，輸出檔案名為原檔案名去掉 .srt 後綴，再加上 .ass 後綴
ffmpeg -i ${name} ${name%.srt}.ass

# 使用 ffmpeg 將 .srt 檔案轉換成 .vtt 格式，輸出檔案名為原檔案名去掉 .srt 後綴，再加上 .vtt 後綴
ffmpeg -i ${name} ${name%.srt}.vtt

# 使用 sed 編輯 .ass 檔案，刪除第 11 行
sed -i '' '11d' ${name%.srt}.ass

# 使用 sed 在 .ass 檔案的第 10 行後插入一個新的樣式設定行，設定字幕的字體、大小、顏色等參數
# 插入的樣式設定行格式為：
# Style: Name,Fontname,Fontsize,PrimaryColour,SecondaryColour,OutlineColour,BackColour,Bold,Italic,Underline,StrikeOut,ScaleX,ScaleY,Spacing,Angle,BorderStyle,Outline,Shadow,Alignment,MarginL,MarginR,MarginV,Encoding
#
# 參數詳細說明：
# 1. Name: 樣式名稱，這裡設定為 "Default"。
# 2. Fontname: 字體名稱，這裡使用 "jf-jinxuan SemiBold"。
# 3. Fontsize: 字體大小，設定為 16。
# 4. PrimaryColour: 主要字體顏色，設定為 "&Hffffff"（白色）。
# 5. SecondaryColour: 次要字體顏色，設定為 "&Hffffff"（白色）。
# 6. OutlineColour: 字體邊框顏色，設定為 "&H20000000"（半透明黑色）。
# 7. BackColour: 字體背景顏色，設定為 "&H0"（透明）。
# 8. Bold: 是否粗體，設定為 1（啟用）。
# 9. Italic: 是否斜體，設定為 0（禁用）。
# 10. Underline: 是否下劃線，設定為 0（禁用）。
# 11. StrikeOut: 是否刪除線，設定為 0（禁用）。
# 12. ScaleX: 橫向縮放比例，設定為 100。
# 13. ScaleY: 縱向縮放比例，設定為 100。
# 14. Spacing: 字符間距，設定為 0。
# 15. Angle: 旋轉角度，設定為 0。
# 16. BorderStyle: 邊框樣式，設定為 1（僅有邊框，無陰影）。
# 17. Outline: 邊框寬度，設定為 1.3。
# 18. Shadow: 陰影深度，設定為 0。
# 19. Alignment: 對齊方式，設定為 2（底部置中）。
# 20. MarginL: 左邊距，設定為 10。
# 21. MarginR: 右邊距，設定為 10。
# 22. MarginV: 垂直邊距，設定為 10。
# 23. Encoding: 編碼方式，設定為 0（Unicode）。

sed -i '' '10a\\
Style: Default,jf-jinxuan SemiBold,16,&Hffffff,&Hffffff,&H20000000,&H0,1,0,0,0,100,100,0,0,1,1.3,0,2,10,10,10,0\\
' ${name%.srt}.ass
