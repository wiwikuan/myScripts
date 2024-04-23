#!/bin/bash

# 檢查是否提供了 YouTube URL 作為參數
# 如果沒有提供參數，則顯示錯誤訊息並退出腳本
if [ $# -eq 0 ]; then
  echo "請提供 YouTube URL 作為參數。"
  exit 1
fi

# 獲取提供的 YouTube URL
url=$1

# 使用 yt-dlp 獲取影片的 ID
# --get-id 選項會從 URL 中提取影片的 ID
video_id=$(yt-dlp --get-id "$url")

# 設定輸出檔案的名稱，使用影片的 ID 作為檔名
# 輸出檔案將包含字幕的文字內容或音頻轉錄的內容
output_file="${video_id}.txt"

# 生成臨時檔案的隨機檔名
# 使用當前時間（以納秒為單位）生成隨機且唯一的檔名
# 這樣可以避免多個腳本實例之間的檔名衝突
subs_file="/tmp/subs_$(date +%s%N).vtt"
audio_file="/tmp/audio_$(date +%s%N).mp3"

# 生成下載的 VTT 檔案的隨機檔名
# 下載的字幕檔案將被重新命名為此隨機檔名
downloaded_subs_file="/tmp/downloaded_subs_$(date +%s%N).vtt"

# 嘗試下載字幕的語言代碼陣列
# 按照優先順序列出要嘗試下載的字幕語言
languages=("en" "zh-TW" "zh")

# 用於跟踪是否找到字幕的標誌
# 初始值為 false，表示還沒有找到字幕
subs_found=false

# 使用 yt-dlp 按照指定的語言順序嘗試下載字幕
for lang in "${languages[@]}"; do
  echo "正在嘗試下載 $lang 字幕..."

  # 使用 yt-dlp 下載指定語言的字幕
  # --write-subs 選項表示要下載字幕
  # --skip-download 選項表示只下載字幕，不下載影片
  # --sub-lang 選項指定要下載的字幕語言
  # --output 選項指定字幕檔案的輸出路徑和檔名模板
  if yt-dlp --write-subs --skip-download --sub-lang "$lang" --output "$subs_file" "$url"; then
    # 檢查是否成功下載了字幕檔案
    # 下載的字幕檔案會以 "字幕檔名.語言代碼.vtt" 的格式命名
    if [ -f "${subs_file}.${lang}.vtt" ]; then
      # 如果找到了字幕檔案，將其重新命名為隨機的下載檔名
      mv "${subs_file}.${lang}.vtt" "$downloaded_subs_file"

      # 將 subs_found 標誌設置為 true，表示找到了字幕
      subs_found=true

      # 使用 break 語句跳出迴圈，因為已經找到了字幕
      break
    fi
  fi
done

# 檢查是否找到了字幕
if [ "$subs_found" = true ]; then
  echo "找到字幕，正在提取字幕文字..."

  # 使用 sed 命令從 VTT 檔案中提取字幕文字
  # 第一個 sed 命令移除以數字開頭的行（時間戳）
  # 第二個 sed 命令移除空行
  # 提取的字幕文字被重定向到輸出檔案
  sed '/^[0-9]/d' "$downloaded_subs_file" | sed '/^$/d' > "$output_file"

  echo "字幕已保存到 $output_file"

  # 刪除下載的字幕檔案，因為已經提取了字幕文字
  rm "$downloaded_subs_file"
else
  echo "找不到字幕，正在下載音頻..."

  # 如果找不到字幕，則下載影片的音頻
  # -f bestaudio 選項表示選擇最佳音頻品質
  # --extract-audio 選項表示只提取音頻，不下載影片
  # --audio-format 選項指定音頻的輸出格式為 mp3
  # --output 選項指定音頻檔案的輸出路徑和檔名
  yt-dlp -f bestaudio --extract-audio --audio-format mp3 --output "$audio_file" "$url"

  echo "音頻下載完成，正在使用 Whisper 進行轉錄..."

  # 使用 Whisper 對下載的音頻進行轉錄
  # --model 選項指定使用的 Whisper 模型
  # --output_dir 選項指定轉錄結果的輸出目錄
  # --output_format 選項指定轉錄結果的輸出格式為 txt
  # --language 選項指定轉錄的語言為英語
  # 轉錄結果會以 "音頻檔名.txt" 的格式保存
  whisper --model small --output_dir /tmp --output_format txt "$audio_file"

  # 獲取轉錄結果的檔案路徑
  transcription_file="${audio_file%.*}.txt"

  # 檢查轉錄結果檔案是否存在
  if [ -f "$transcription_file" ]; then
    # 如果轉錄結果檔案存在，將其移動到輸出檔案
    mv "$transcription_file" "$output_file"
    echo "轉錄已保存到 $output_file"
  else
    # 如果找不到轉錄結果檔案，顯示錯誤訊息並退出腳本
    echo "無法找到轉錄檔案。"
    exit 1
  fi

  # 刪除下載的音頻檔案，因為已經完成了轉錄
  rm "$audio_file"
fi

# 使用 ollama 生成轉錄的摘要
# 摘要檔案的名稱為影片ID-summary.txt
summary_file="${video_id}-summary.txt"

echo "正在生成摘要..."

# 檢查轉錄結果檔案是否存在
if [ -f "$output_file" ]; then
  # 如果轉錄結果檔案存在，使用 ollama 生成摘要
  # llama3 是 ollama 的一個模型
  # "Summarize this file: $(cat "$output_file")" 是提供給 ollama 的輸入，表示對輸出檔案的內容進行摘要
  # 使用 tee 命令將 ollama 的輸出同時顯示在終端和摘要檔案中
  ollama run llama3 "Summarize this file: $(cat "$output_file")" | tee "$summary_file"

  echo "摘要已保存到 $summary_file"
else
  # 如果找不到轉錄結果檔案，顯示錯誤訊息並退出腳本
  echo "無法找到轉錄檔案。"
  exit 1
fi
