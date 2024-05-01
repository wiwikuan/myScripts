#!/bin/bash

function display_help {
  echo "使用方法: ./ff-preset.sh [參數] [輸入文件] [輸出文件] [字幕檔案(可選)]"
  echo ""
  echo "可用的參數:"
  echo "  odysee               適用於 Odysee 平台的轉碼設定"
  echo "  wiwivideo            適用於 WiwiVideo 平台的轉碼設定"
  echo "  wiwivideo_vertical   適用於 WiwiVideo 平台的垂直影片轉碼設定"
  echo "  wiwihq               適用於 WiwiVideo 平台的高品質轉碼設定"
  echo "  wiwilq               適用於 WiwiVideo 平台的低品質轉碼設定"
  echo "  wiwilq240            適用於 WiwiVideo 平台的 240p 低品質轉碼設定"
  echo "  nicecode             適用於 NiceCode 平台的轉碼設定"
  echo "  nicecode_hq          適用於 NiceCode 平台的高品質轉碼設定"
  echo "  subs                 轉碼並嵌入字幕"
  echo "  ytsubs               適用於 YouTube 平台的轉碼設定，並嵌入字幕"
  echo "  ytsubs720            適用於 YouTube 平台的 720p 轉碼設定，並嵌入字幕"
  echo "  ytsubs4k             適用於 YouTube 平台的 4K 轉碼設定，並嵌入字幕"
  echo "  superhq              超高品質轉碼設定"
  echo "  copy                 直接複製影片和音訊，不進行轉碼"
  echo ""
  echo "註釋:"
  echo "  輸入文件和輸出文件是必需的參數，字幕文件是可選的。"
  echo "  當使用 subs、ytsubs、ytsubs720 或 ytsubs4k 參數時，需要提供字幕檔案。"
  echo ""
  echo "示例:"
  echo "  ./ff-preset.sh odysee input.mp4 output.mp4"
  echo "  ./ff-preset.sh ytsubs input.mp4 output.mp4 subtitles.srt"
  echo ""
}

function ff_odysee {
  ffmpeg -i "$1" -c:v libx264 -b:v 1.5M -minrate 0.5M -preset slower -vf scale=1440:-1 -c:a aac -b:a 160K "$2"
}

function ff_wiwivideo {
  ffmpeg -i "$1" -c:v libx264 -b:v 1.2M -minrate 0.2M -preset slower -vf scale=1280:-1 -c:a aac -b:a 160K "$2"
}

function ff_wiwivideo_vertical {
  ffmpeg -i "$1" -c:v libx264 -b:v 1.2M -minrate 0.2M -preset slower -vf scale=-1:1280 -c:a aac -b:a 128K "$2"
}

function ff_wiwihq {
  ffmpeg -i "$1" -c:v libx264 -b:v 1.6M -minrate 0.5M -preset slower -vf scale=1600:-1 -c:a aac -b:a 160K "$2"
}

function ff_wiwilq {
  ffmpeg -i "$1" -c:v libx264 -b:v 0.4M -minrate 0.2M -preset slower -vf scale=960:-1 -c:a aac -b:a 160K "$2"
}

function ff_wiwilq240 {
  ffmpeg -i "$1" -c:v libx264 -b:v 0.1M -minrate 0.01M -vf scale=-1:216 -c:a aac -b:a 48K "$2"
}

function ff_nicecode {
  ffmpeg -i "$1" -c:v libx264 -b:v 0.7M -minrate 0.1M -preset slower -vf scale=1600:-1 -c:a aac -b:a 160K "$2"
}

function ff_nicecode_hq {
  ffmpeg -i "$1" -c:v libx264 -b:v 1.2M -minrate 0.3M -preset slower -vf scale=1600:-1 -c:a aac -b:a 160K "$2"
}

function ff_subs {
  ffmpeg -i "$1" -c:v libx264 -b:v 1.6M -minrate 0.5M -preset slower -c:a aac -b:a 160K -vf "subtitles=$3, scale=1600:-1" "$2"
}

function ff_ytsubs {
  ffmpeg -i "$1" -c:v libx264 -b:v 10M -minrate 0.5M -preset slower -c:a aac -b:a 224K -vf "subtitles=$3, scale=1920:-1" "$2"
}

function ff_ytsubs720 {
  ffmpeg -i "$1" -c:v libx264 -b:v 5M -minrate 0.5M -preset fast -c:a aac -b:a 224K -vf "subtitles=$3, scale=1280:-1" "$2"
}

function ff_ytsubs4k {
  ffmpeg -i "$1" -c:v libx264 -b:v 25M -minrate 5M -preset fast -c:a aac -b:a 224K -vf "subtitles=$3, scale=3840:-1" "$2"
}

function ff_superhq {
  ffmpeg -i "$1" -c:v libx264 -b:v 2.5M -minrate 0.8M -preset slower -vf scale=1920:-1 -c:a aac -b:a 224K "$2"
}

function ff_copy {
  ffmpeg -i "$1" -c:v copy -c:a copy "$2"
}

# 根據傳入的參數執行相應的函數
case "$1" in
  "-h"|"--help")
    display_help
    ;;
  "odysee")
    ff_odysee "$2" "$3"
    ;;
  "wiwivideo")
    ff_wiwivideo "$2" "$3"
    ;;
  "wiwivideo_vertical")
    ff_wiwivideo_vertical "$2" "$3"
    ;;
  "wiwihq")
    ff_wiwihq "$2" "$3"
    ;;
  "wiwilq")
    ff_wiwilq "$2" "$3"
    ;;
  "wiwilq240")
    ff_wiwilq240 "$2" "$3"
    ;;
  "nicecode")
    ff_nicecode "$2" "$3"
    ;;
  "nicecode_hq")
    ff_nicecode_hq "$2" "$3"
    ;;
  "subs")
    ff_subs "$2" "$3" "$4"
    ;;
  "ytsubs")
    ff_ytsubs "$2" "$3" "$4"
    ;;
  "ytsubs720")
    ff_ytsubs720 "$2" "$3" "$4"
    ;;
  "ytsubs4k")
    ff_ytsubs4k "$2" "$3" "$4"
    ;;
  "superhq")
    ff_superhq "$2" "$3"
    ;;
  "copy")
    ff_copy "$2" "$3"
    ;;
  "")
    echo "錯誤: 請提供有效的參數。"
    echo "使用 './ff-preset.sh -h' 查看可用的參數和說明。"
    ;;
  *)
    echo "無效的參數: $1"
    echo "使用 './ff-preset.sh -h' 查看可用的參數和說明。"
    ;;
esac
