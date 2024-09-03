只是一些自己平時用到的 Scripts。

- **combine-md-files.sh** - 搜尋當前目錄下所有具有特定前綴的 .md 檔案，並將它們組合成一個單一的輸出檔案。
- **create-subs.sh** - 我用來產生影片內嵌字幕檔，並自動修改 .ass 格式設定的 script。
- **ff-preset.sh** - 轉換影片檔案、內嵌字幕，輸出成適合常用平台的格式。
- **ff-preset-nvidia.sh** - 轉換影片檔案、內嵌字幕，輸出成適合常用平台的格式。（使用 nVidia GPU 加速）
- **jpg-resize.sh** - 把圖片縮放到某個百分比的長寬，並且限制最大檔案大小，輸出成 .jpg 檔案。
- **occ.sh** - 配合 opencc 使用，簡體轉繁體。
- **png-seq-to-prores.sh** - 把 000000.png、000001.png……轉成 ProRes 4444 影片檔。
- **remove-crunch.sh** - 把當前目錄中所有符合 "*-crunch.png" 模式的圖片檔重新命名。
- **text-to-ascii.py** - 輸入文字，利用點陣字型檔轉成 ASCII。
- **url-extract.sh** - 貼入文字，擷取文字中的網址。
- **wav-to-mp3.sh** - 把當前資料夾裡的所有 .wav 轉成 160 kbps 的 .mp3 檔案。
- **yt-tldr.sh** - 自動下載 YouTube 影片的字幕或音訊，並使用 Whisper 和 ollama 產生影片內容的摘要。
- **yt-res.sh** - 自動下載某解析度以下的 YouTube 影片。
