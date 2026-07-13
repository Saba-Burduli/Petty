#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
RAW_DIR="$ROOT_DIR/marketing/trailer/raw-v2"
WORK_DIR="$ROOT_DIR/marketing/trailer/work-v2"
OVERLAY_DIR="$WORK_DIR/overlays"
EXPORT_DIR="$ROOT_DIR/marketing/trailer/exports-v2"
MUSIC="$WORK_DIR/music.wav"

MASTER="$EXPORT_DIR/petty-launch-trailer-30s.mp4"
SQUARE="$EXPORT_DIR/petty-launch-trailer-square.mp4"
VERTICAL="$EXPORT_DIR/petty-launch-trailer-vertical.mp4"
GIF="$EXPORT_DIR/petty-launch-trailer-preview.gif"
CONTACT_SHEET="$WORK_DIR/contact-sheet.jpg"

LOOP_PLUCK="/Library/Audio/Apple Loops/Apple/01 Hip Hop/Dusk Drive Pluck.caf"
LOOP_BEAT="/Library/Audio/Apple Loops/Apple/07 Chillwave/Minimal Backbeat 01.caf"
LOOP_SYNTH="/Library/Audio/Apple Loops/Apple/04 Modern RnB/Digital Halo Synth.caf"
LOOP_RISER="/Library/Audio/Apple Loops/Apple/09 Disco Funk/Hang Tight Synth Riser FX.caf"

SHOT_NAMES=(
  V2-A01-launch.mov
  V2-A02-menu-store.mov
  V2-A03-select-three.mov
  V2-A04-drag.mov
  V2-A05-resize.mov
  V2-A06-click.mov
  V2-A07-work.mov
  V2-A08-idle-wake.mov
  V2-A09-montage.mov
  V2-A10-hero.mov
)

fail() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

require_file() {
  [[ -f "$1" ]] || fail "missing required file: $1"
}

command -v ffmpeg >/dev/null || fail "ffmpeg is not installed"
command -v ffprobe >/dev/null || fail "ffprobe is not installed"
command -v swift >/dev/null || fail "swift is not installed"

mkdir -p "$RAW_DIR" "$WORK_DIR" "$OVERLAY_DIR" "$EXPORT_DIR"

for shot in "${SHOT_NAMES[@]}"; do
  require_file "$RAW_DIR/$shot"
done

for loop in "$LOOP_PLUCK" "$LOOP_BEAT" "$LOOP_SYNTH" "$LOOP_RISER"; do
  require_file "$loop"
done

swift "$ROOT_DIR/marketing/scripts/make_title_overlays_v2.swift" "$OVERLAY_DIR"

build_music() {
  printf 'Building 105 BPM music and restrained UI effects...\n'

  ffmpeg -hide_banner -loglevel error -y \
    -stream_loop -1 -i "$LOOP_PLUCK" \
    -stream_loop -1 -i "$LOOP_BEAT" \
    -stream_loop -1 -i "$LOOP_SYNTH" \
    -i "$LOOP_RISER" \
    -f lavfi -i "sine=frequency=880:duration=0.08:sample_rate=48000" \
    -f lavfi -i "anoisesrc=color=pink:duration=0.45:sample_rate=48000" \
    -f lavfi -i "sine=frequency=620:duration=0.14:sample_rate=48000" \
    -f lavfi -i "sine=frequency=180:duration=0.28:sample_rate=48000" \
    -f lavfi -i "sine=frequency=523.25:duration=1.0:sample_rate=48000" \
    -filter_complex "
      [0:a]aresample=48000,aformat=channel_layouts=stereo,atempo=1.009615,
        atrim=duration=30,asetpts=PTS-STARTPTS,volume=0.30[pluck];
      [1:a]aresample=48000,aformat=channel_layouts=stereo,atempo=0.875,
        atrim=duration=30,asetpts=PTS-STARTPTS,volume=0.17[beat];
      [2:a]aresample=48000,aformat=channel_layouts=stereo,atempo=0.875,
        atrim=duration=30,asetpts=PTS-STARTPTS,volume=0.11[synth];
      [3:a]aresample=48000,atrim=start=6.9:end=11.3,asetpts=PTS-STARTPTS,atempo=0.905172,
        aformat=channel_layouts=stereo,afade=t=in:st=0:d=0.4,
        afade=t=out:st=4.4:d=0.45,adelay=25000|25000,volume=0.22[riser];

      [4:a]aformat=channel_layouts=stereo,
        asplit=11[pop0][pop1][pop2][pop3][pop4][pop5][pop6][pop7][pop8][pop9][pop10];
      [pop0]adelay=5250|5250,volume=0.16[p0];
      [pop1]adelay=6250|6250,volume=0.16[p1];
      [pop2]adelay=7250|7250,volume=0.16[p2];
      [pop3]adelay=12200|12200,volume=0.12[p3];
      [pop4]adelay=13200|13200,volume=0.12[p4];
      [pop5]adelay=14200|14200,volume=0.12[p5];
      [pop6]adelay=25250|25250,volume=0.14[p6];
      [pop7]adelay=25850|25850,volume=0.14[p7];
      [pop8]adelay=26450|26450,volume=0.14[p8];
      [pop9]adelay=27050|27050,volume=0.14[p9];
      [pop10]adelay=27650|27650,volume=0.14[p10];

      [5:a]aformat=channel_layouts=stereo,highpass=f=280,lowpass=f=2100,afade=t=in:st=0:d=0.08,
        afade=t=out:st=0.2:d=0.25,adelay=8100|8100,volume=0.11[whoosh];
      [6:a]aformat=channel_layouts=stereo,afade=t=out:st=0.05:d=0.09,
        adelay=15300|15300,volume=0.14[click];
      [7:a]aformat=channel_layouts=stereo,afade=t=out:st=0.05:d=0.23,
        adelay=22250|22250,volume=0.10[sleep];
      [8:a]aformat=channel_layouts=stereo,afade=t=in:st=0:d=0.08,afade=t=out:st=0.62:d=0.38,
        adelay=28500|28500,volume=0.12[sting];

      [pluck][beat][synth][riser]
      [p0][p1][p2][p3][p4][p5][p6][p7][p8][p9][p10]
      [whoosh][click][sleep][sting]
      amix=inputs=19:duration=longest:normalize=0,
      atrim=duration=30,afade=t=in:st=0:d=0.35,afade=t=out:st=29.2:d=0.8,
      loudnorm=I=-14:TP=-1:LRA=7,aresample=48000[a]
    " \
    -map "[a]" -c:a pcm_s24le "$MUSIC"
}

build_music

overlay_input_args=()
for overlay in \
  00-meet 01-choose 02-nine 03-drag 04-size \
  05-click 06-work 07-rest 08-switch 09-end; do
  overlay_input_args+=( -loop 1 -framerate 30 -i "$OVERLAY_DIR/$overlay.png" )
done

ffmpeg -hide_banner -y \
  -i "$RAW_DIR/V2-A01-launch.mov" \
  -i "$RAW_DIR/V2-A02-menu-store.mov" \
  -i "$RAW_DIR/V2-A03-select-three.mov" \
  -i "$RAW_DIR/V2-A04-drag.mov" \
  -i "$RAW_DIR/V2-A05-resize.mov" \
  -i "$RAW_DIR/V2-A06-click.mov" \
  -i "$RAW_DIR/V2-A07-work.mov" \
  -i "$RAW_DIR/V2-A08-idle-wake.mov" \
  -i "$RAW_DIR/V2-A09-montage.mov" \
  -i "$RAW_DIR/V2-A10-hero.mov" \
  "${overlay_input_args[@]}" \
  -i "$MUSIC" \
  -filter_complex "
    [0:v]trim=start=2:end=4,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,
      zoompan=z='min(zoom+0.00135,1.08)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30,
      settb=AVTB[v0base];
    [10:v]trim=duration=2,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.15:alpha=1,fade=t=out:st=1.82:d=0.18:alpha=1[o0];
    [v0base][o0]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s0];

    [1:v]trim=start=2:end=5,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,
      zoompan=z='min(zoom+0.0009,1.08)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30,
      settb=AVTB[v1base];
    [11:v]trim=duration=3,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.15:alpha=1,fade=t=out:st=2.82:d=0.18:alpha=1[o1];
    [v1base][o1]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s1];

    [2:v]trim=start=2:end=5,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,
      zoompan=z='min(zoom+0.0008,1.07)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30,
      settb=AVTB[v2base];
    [12:v]trim=duration=3,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.12:alpha=1,fade=t=out:st=2.82:d=0.18:alpha=1[o2];
    [v2base][o2]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s2];

    [3:v]trim=start=2:end=6,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,settb=AVTB[v3base];
    [13:v]trim=duration=4,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.12:alpha=1,fade=t=out:st=3.82:d=0.18:alpha=1[o3];
    [v3base][o3]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s3];

    [4:v]trim=start=2:end=5,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,settb=AVTB[v4base];
    [14:v]trim=duration=3,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.12:alpha=1,fade=t=out:st=2.82:d=0.18:alpha=1[o4];
    [v4base][o4]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s4];

    [5:v]trim=start=2:end=5,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,
      zoompan=z='min(zoom+0.0007,1.06)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30,
      settb=AVTB[v5base];
    [15:v]trim=duration=3,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.12:alpha=1,fade=t=out:st=2.82:d=0.18:alpha=1[o5];
    [v5base][o5]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s5];

    [6:v]trim=start=2:end=6,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,
      zoompan=z='min(zoom+0.00055,1.07)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30,
      settb=AVTB[v6base];
    [16:v]trim=duration=4,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.12:alpha=1,fade=t=out:st=3.82:d=0.18:alpha=1[o6];
    [v6base][o6]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s6];

    [7:v]trim=start=20:end=23,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,
      fade=t=out:st=1.25:d=0.125,fade=t=in:st=1.375:d=0.125,settb=AVTB[v7base];
    [17:v]trim=duration=3,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.12:alpha=1,fade=t=out:st=2.82:d=0.18:alpha=1[o7];
    [v7base][o7]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s7];

    [8:v]trim=start=2.3:end=2.9,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1[m0];
    [8:v]trim=start=4.8:end=5.4,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1[m1];
    [8:v]trim=start=7.3:end=7.9,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1[m2];
    [8:v]trim=start=9.8:end=10.4,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1[m3];
    [8:v]trim=start=12.3:end=12.9,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1[m4];
    [m0][m1][m2][m3][m4]concat=n=5:v=1:a=0,settb=AVTB[v8base];
    [18:v]trim=duration=3,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.12:alpha=1,fade=t=out:st=2.82:d=0.18:alpha=1[o8];
    [v8base][o8]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s8];

    [9:v]trim=start=2:end=4,setpts=PTS-STARTPTS,fps=30,
      scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,
      zoompan=z='min(zoom+0.0014,1.08)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30,
      fade=t=in:st=0:d=0.3,settb=AVTB[v9base];
    [19:v]trim=duration=2,setpts=PTS-STARTPTS,format=rgba,
      fade=t=in:st=0:d=0.3:alpha=1[o9];
    [v9base][o9]overlay=shortest=1,fps=30,setpts=N/(30*TB),settb=AVTB[s9];

    [s0][s1][s2]concat=n=3:v=1:a=0,settb=AVTB,
      tpad=stop_mode=clone:stop_duration=0.4[prepad];
    [prepad][s3]xfade=transition=slideleft:duration=0.2:offset=8,
      fps=30,setpts=N/(30*TB),settb=AVTB[throughdrag];
    [throughdrag][s4][s5][s6][s7][s8][s9]concat=n=7:v=1:a=0,
      tpad=stop_mode=clone:stop_duration=0.3,trim=duration=30,
      setpts=N/(30*TB),fps=30,format=yuv420p[v]
  " \
  -map "[v]" -map 20:a \
  -c:v libx264 -preset slow -crf 18 -profile:v high -level 4.1 \
  -c:a aac -b:a 192k -ar 48000 -movflags +faststart -r 30 -t 30 \
  "$MASTER"

ffmpeg -hide_banner -loglevel error -y -i "$MASTER" -filter_complex "
  [0:v]split=2[bgsrc][fgsrc];
  [bgsrc]scale=1080:1080:force_original_aspect_ratio=increase,crop=1080:1080,
    gblur=sigma=32,eq=brightness=-0.24[bg];
  [fgsrc]scale=1080:608:flags=lanczos[fg];
  [bg][fg]overlay=(W-w)/2:(H-h)/2,format=yuv420p[v]
" -map "[v]" -map 0:a -c:v libx264 -preset slow -crf 19 -profile:v high \
  -c:a aac -b:a 192k -movflags +faststart -r 30 -t 30 "$SQUARE"

ffmpeg -hide_banner -loglevel error -y -i "$MASTER" -filter_complex "
  [0:v]split=2[bgsrc][fgsrc];
  [bgsrc]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,
    gblur=sigma=38,eq=brightness=-0.30[bg];
  [fgsrc]scale=1080:608:flags=lanczos[fg];
  [bg][fg]overlay=(W-w)/2:(H-h)/2,format=yuv420p[v]
" -map "[v]" -map 0:a -c:v libx264 -preset slow -crf 19 -profile:v high \
  -c:a aac -b:a 192k -movflags +faststart -r 30 -t 30 "$VERTICAL"

ffmpeg -hide_banner -loglevel error -y -i "$MASTER" -filter_complex "
  [0:v]fps=12,scale=720:405:flags=lanczos,split[gifsrc][palettesrc];
  [palettesrc]palettegen=max_colors=192:stats_mode=diff[palette];
  [gifsrc][palette]paletteuse=dither=bayer:bayer_scale=4:diff_mode=rectangle[gif]
" -map "[gif]" -loop 0 "$GIF"

boundary_times=(0 2 5 8 12 15 18 22 25 28 29.7)
contact_inputs=()
stack_inputs=()
stack_layout=()
for index in "${!boundary_times[@]}"; do
  frame="$WORK_DIR/contact-$index.png"
  ffmpeg -hide_banner -loglevel error -y -ss "${boundary_times[$index]}" -i "$MASTER" \
    -frames:v 1 -vf "scale=480:270" "$frame"
  contact_inputs+=( -i "$frame" )
  stack_inputs+=( "[$index:v]" )
  x=$((index % 4 * 480))
  y=$((index / 4 * 270))
  stack_layout+=( "${x}_${y}" )
done

input_labels="$(IFS=; printf '%s' "${stack_inputs[*]}")"
layout="$(IFS='|'; printf '%s' "${stack_layout[*]}")"
ffmpeg -hide_banner -loglevel error -y "${contact_inputs[@]}" \
  -filter_complex "${input_labels}xstack=inputs=11:layout=${layout}:fill=0x111318[contact]" \
  -map "[contact]" -frames:v 1 "$CONTACT_SHEET"
rm -f "$WORK_DIR"/contact-[0-9]*.png

validate_video() {
  local file="$1"
  local expected_size="$2"
  local duration dimensions fps video_codec audio_codec

  duration="$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=duration -of csv=p=0 "$file")"
  dimensions="$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=width,height -of csv=s=x:p=0 "$file")"
  fps="$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=avg_frame_rate -of csv=p=0 "$file")"
  video_codec="$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=codec_name -of csv=p=0 "$file")"
  audio_codec="$(ffprobe -v error -select_streams a:0 \
    -show_entries stream=codec_name -of csv=p=0 "$file")"

  awk -v value="$duration" 'BEGIN { exit !(value >= 29.9 && value <= 30.1) }' \
    || fail "duration outside 30.0 +/- 0.1 seconds: $file ($duration)"
  [[ "$dimensions" == "$expected_size" ]] \
    || fail "unexpected dimensions: $file ($dimensions)"
  [[ "$fps" == "30/1" ]] || fail "unexpected frame rate: $file ($fps)"
  [[ "$video_codec" == "h264" ]] || fail "unexpected video codec: $file ($video_codec)"
  [[ "$audio_codec" == "aac" ]] || fail "unexpected audio codec: $file ($audio_codec)"
}

validate_video "$MASTER" "1920x1080"
validate_video "$SQUARE" "1080x1080"
validate_video "$VERTICAL" "1080x1920"

gif_size="$(stat -f '%z' "$GIF")"
(( gif_size < 15728640 )) || fail "README GIF exceeds 15 MiB ($gif_size bytes)"

printf '\nRendered and validated:\n'
printf '  %s\n' "$MASTER" "$SQUARE" "$VERTICAL" "$GIF" "$CONTACT_SHEET"
