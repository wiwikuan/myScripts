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
sed -i '' '10a\\
Style: Default,jf-jinxuan SemiBold,16,&Hffffff,&Hffffff,&H20000000,&H0,1,0,0,0,100,100,0,0,1,1.3,0,2,10,10,10,0\\
' ${name%.srt}.ass
