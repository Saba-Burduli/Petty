#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
RAW_DIR="$ROOT_DIR/marketing/trailer/raw"
EXPORT_DIR="$ROOT_DIR/marketing/trailer/exports"
FONT="/System/Library/Fonts/SFNS.ttf"
MASTER="$EXPORT_DIR/petty-launch-trailer-30s.mp4"
OVERLAY_DIR="$ROOT_DIR/marketing/trailer/work/overlays"

mkdir -p "$EXPORT_DIR"
swift "$ROOT_DIR/marketing/scripts/make_title_overlays.swift" "$OVERLAY_DIR"

ffmpeg -y \
  -i "$RAW_DIR/A02-launch.mov" \
  -i "$RAW_DIR/A04-A07-store-window-final.mov" \
  -i "$RAW_DIR/A10-size75.mov" \
  -i "$RAW_DIR/A11-size135-positioned.mov" \
  -i "$RAW_DIR/A08-A12-drag-poke-final.mov" \
  -loop 1 -framerate 30 -t 4 -i "$OVERLAY_DIR/00-launch.png" \
  -loop 1 -framerate 30 -t 6 -i "$OVERLAY_DIR/01-store.png" \
  -loop 1 -framerate 30 -t 2 -i "$OVERLAY_DIR/02-size75.png" \
  -loop 1 -framerate 30 -t 2 -i "$OVERLAY_DIR/03-size135.png" \
  -loop 1 -framerate 30 -t 6 -i "$OVERLAY_DIR/04-react.png" \
  -loop 1 -framerate 30 -t 5 -i "$OVERLAY_DIR/05-rest.png" \
  -loop 1 -framerate 30 -t 5 -i "$OVERLAY_DIR/06-end.png" \
  -f lavfi -t 30 -i "aevalsrc=0.018*sin(2*PI*220*t)*(0.72+0.28*sin(2*PI*1.5*t))+0.012*sin(2*PI*277.18*t)+0.010*sin(2*PI*329.63*t):s=48000" \
  -filter_complex "
    [0:v]trim=start=0:end=4,setpts=PTS-STARTPTS,crop=3456:1944:0:145,scale=1920:1080,fps=30[v0base];
    [v0base][5:v]overlay=shortest=1[v0];

    color=c=0x0B1020:s=1920x1080:d=6:r=30[storebg];
    [1:v]trim=start=32:end=38,setpts=PTS-STARTPTS,crop=1038:1184:69:53,scale=700:798,fps=30[storewindow];
    [storebg][storewindow]overlay=x=1110:y=(H-h)/2[storebase];
    [storebase][6:v]overlay=shortest=1[v1];

    [2:v]trim=start=1:end=3,setpts=PTS-STARTPTS,crop=3456:1944:0:145,scale=1920:1080,fps=30[v2base];
    [v2base][7:v]overlay=shortest=1[v2];

    [3:v]trim=start=0:end=2,setpts=PTS-STARTPTS,crop=3456:1944:0:145,scale=1920:1080,fps=30[v3base];
    [v3base][8:v]overlay=shortest=1[v3];

    [4:v]trim=start=52:end=58,setpts=PTS-STARTPTS,crop=3456:1944:0:145,scale=1920:1080,fps=30[v4base];
    [v4base][9:v]overlay=shortest=1[v4];

    [4:v]trim=start=63:end=68,setpts=PTS-STARTPTS,crop=3456:1944:0:145,scale=1920:1080,fps=30[v5base];
    [v5base][10:v]overlay=shortest=1[v5];

    [3:v]trim=start=0:end=5,setpts=PTS-STARTPTS,crop=3456:1944:0:145,scale=1920:1080,fps=30[v6base];
    [v6base][11:v]overlay=shortest=1[v6];

    [v0][v1][v2][v3][v4][v5][v6]concat=n=7:v=1:a=0,format=yuv420p[v];
    [12:a]afade=t=in:st=0:d=1.2,afade=t=out:st=28:d=2,volume=0.8[a]
  " \
  -map "[v]" -map "[a]" \
  -c:v libx264 -preset medium -crf 18 -profile:v high -level 4.1 \
  -c:a aac -b:a 192k -movflags +faststart -r 30 -t 30 \
  "$MASTER"

ffmpeg -y -i "$MASTER" -filter_complex "
  [0:v]split=2[squarebg][squarefg];
  [squarebg]scale=1080:1080:force_original_aspect_ratio=increase,crop=1080:1080,gblur=sigma=28,eq=brightness=-0.28[bg];
  [squarefg]scale=1080:608[fg];
  [bg][fg]overlay=(W-w)/2:(H-h)/2[v]
" -map "[v]" -map 0:a \
  -c:v libx264 -preset medium -crf 20 -c:a aac -b:a 160k -movflags +faststart \
  "$EXPORT_DIR/petty-launch-trailer-square.mp4"

ffmpeg -y -i "$MASTER" -filter_complex "
  [0:v]split=2[verticalbg][verticalfg];
  [verticalbg]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=34,eq=brightness=-0.32[bg];
  [verticalfg]scale=1080:608[fg];
  [bg][fg]overlay=(W-w)/2:(H-h)/2[v]
" -map "[v]" -map 0:a \
  -c:v libx264 -preset medium -crf 20 -c:a aac -b:a 160k -movflags +faststart \
  "$EXPORT_DIR/petty-launch-trailer-vertical.mp4"

printf 'Rendered:\n%s\n' "$MASTER"
