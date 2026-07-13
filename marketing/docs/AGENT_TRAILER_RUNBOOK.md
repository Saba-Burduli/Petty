# Petty 30-Second Trailer Agent Runbook

## Purpose

Produce the Petty v2 trailer from real macOS app footage with no narration,
generated UI, or simulated product behavior. The finished trailer must explain
the product when muted and end with a GitHub star call to action.

This document is the production contract. Use the shot IDs, filenames, action
timing, title timing, and render commands exactly as written.

## Approved Toolchain

| Job | Primary tool | Backup |
| --- | --- | --- |
| Full-display capture | Screen Studio 3.7.3 | OBS 32 with macOS Screen Capture |
| Music source | GarageBand Apple Loops | FFmpeg loop assembly from the same local loops |
| Edit and export | FFmpeg 8.1.1 | None |
| Overlay generation | Swift/AppKit | None |
| Technical validation | `ffprobe` and `ffmpeg` | None |

Do not install another editor, recorder, codec, font, or media dependency.

## Product Truth

The trailer may show only behavior present in the current Petty build:

- Petty runs as a native macOS menu bar app.
- `Store & Settings` opens the Character Store.
- The store contains nine bundled characters.
- Selecting a character changes the floating desktop character immediately.
- The character is transparent, borderless, draggable, and resizable.
- The size control supports 75% through 135%.
- Dragging responds to movement speed.
- Clicking triggers the character's real reaction animation.
- Recent pointer or keyboard activity triggers an active animation.
- More than 18 seconds without system activity triggers the sleep state.
- Pointer or keyboard activity wakes the character.

Do not imply accounts, purchases, cloud sync, AI conversation, downloadable
characters, skeletal physics, or behavior not visible in the recording.

## Fixed Creative Specification

- Duration: `30.0` seconds.
- Language: English.
- Voice: no narration.
- Primary character: **Graveyard Intern**.
- Montage characters: **Tux**, **Surge**, **Redcap Runner**,
  **Shadowbyte Kunoichi**, and **Ironkeep Sentinel**.
- Capture: complete 16:9 display at native resolution and 60 FPS.
- Master delivery: 1920x1080, 30 FPS, H.264 High Profile, AAC.
- Type: SF Pro, white, bold, uppercase, with Petty green accents.
- Text region: left side of landscape frame.
- Character region: center-right or lower-right.
- Camera motion: restrained 8-15% push-ins only.
- Music: 105 BPM instrumental, approximately -14 LUFS integrated and no
  higher than -1 dB true peak.

## Source And Output Layout

```text
marketing/trailer/
  raw-v2/
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
  work-v2/
    overlays/
    contact-sheet.jpg
    music.wav
  exports-v2/
    petty-launch-trailer-30s.mp4
    petty-launch-trailer-square.mp4
    petty-launch-trailer-vertical.mp4
    petty-launch-trailer-preview.gif
```

Never overwrite `docs/media/trailers/` until every v2 validation check passes.

## Desktop Preparation

1. Build the unsigned local app:

   ```bash
   ./script/build_and_run.sh
   ```

2. Use one 16:9 display. Record the entire display, not an app window.
3. Use a quiet dark wallpaper with contrast around the character.
4. Hide desktop icons and the Dock. Keep the menu bar visible.
5. Close or hide private and unrelated windows.
6. Enable Do Not Disturb. Disable screen saver, display sleep, and auto-lock.
7. Keep the default cursor size.
8. Use a blank TextEdit document for the work scene.
9. Set Petty to Graveyard Intern at 125% and place it in the lower-right safe
   area with at least 80 pixels of visible margin.
10. Confirm no debug paths, terminals, messages, account details, or
    notifications are visible.

Start a temporary keep-awake process during recording:

```bash
caffeinate -dimsu -w "$(pgrep -n Petty)" &
```

## Recorder Configuration

### Screen Studio

- Source: `Display`.
- Display: prepared 16:9 display.
- Resolution: native.
- Frame rate: 60 FPS.
- Camera: off.
- Microphone: off.
- System audio: off.
- Cursor: visible, default size, smoothing enabled.
- Automatic zoom: off during recording. Camera moves are added in the scripted
  edit.

### OBS Backup

- Source: `macOS Screen Capture` using ScreenCaptureKit.
- Method: display capture.
- Canvas/output: native display resolution.
- FPS: 60.
- Recording format: MOV or MKV with a visually lossless or high-quality codec.
- Capture cursor: on.
- Audio: off.

## Mandatory Test Take

Before the real takes, record ten seconds containing:

1. Graveyard Intern idling at 125%.
2. One slow drag.
3. One click reaction.
4. A resize to 135%.

Inspect the result at 100% scale. Continue only when:

- transparent edges contain no box or halo;
- the cursor is visible;
- motion is smooth;
- the complete character remains visible at 135%;
- the recorder UI and selection outlines are absent.

Delete the test take after it passes.

## Recording Rules

- Record each shot as a separate file with the exact filename below.
- Begin with two seconds of stillness.
- Perform the listed action in the specified action window.
- End with two seconds of stillness.
- Keep the wallpaper, display scale, cursor, and settings-window position fixed.
- Repeat a failed take immediately; do not attempt to repair an incomplete
  interaction in the edit.
- Keep Graveyard Intern at 125% unless the shot explicitly changes size.

## Shot List And Fixed Action Timing

| ID / filename | Record length | Action window | Required action | Edit range |
| --- | ---: | ---: | --- | ---: |
| `V2-A01-launch.mov` | 8s | 2.0-5.5s | Start on clean desktop, launch Petty, and hold after Graveyard Intern appears | 2.0-4.0s |
| `V2-A02-menu-store.mov` | 10s | 2.0-7.0s | Click the Petty menu, pause, then open `Store & Settings` | 2.0-5.0s |
| `V2-A03-select-three.mov` | 12s | 2.0-10.0s | Select Tux, Redcap Runner, then Graveyard Intern; pause after each change | 2.0-5.0s |
| `V2-A04-drag.mov` | 12s | 2.0-9.5s | Slow horizontal drag, pause, then clearly faster drag | 2.0-6.0s |
| `V2-A05-resize.mov` | 10s | 2.0-8.0s | Move slider to 75%, hold, 100%, hold, 135%, hold | 2.0-5.0s |
| `V2-A06-click.mov` | 8s | 2.5-4.5s | Click Graveyard Intern once and let the complete reaction finish | 2.0-5.0s |
| `V2-A07-work.mov` | 10s | 2.0-8.0s | Type `Petty stays with you while you work.` in blank TextEdit | 2.0-6.0s |
| `V2-A08-idle-wake.mov` | 28s | 2.0-25.0s | No input until the real sleep state, hold, then move pointer once to wake | 20.0-23.0s |
| `V2-A09-montage.mov` | 18s | 2.0-15.0s | Select Tux, Surge, Redcap Runner, Shadowbyte Kunoichi, Ironkeep Sentinel; pause after each | 2.0-5.0s using scripted sub-trims |
| `V2-A10-hero.mov` | 8s | 2.0-6.0s | Graveyard Intern at 125%, lower-right, clean desktop, no input | 2.0-4.0s |

For `V2-A03-select-three.mov`, the editor uses three one-second windows. Space
the visible character changes at 2.3s, 3.3s, and 4.3s after recording starts.

For `V2-A09-montage.mov`, space the visible character changes at 2.3s, 4.8s,
7.3s, 9.8s, and 12.3s after recording starts. The render script extracts 0.6
seconds after each change and joins them into the three-second montage.

## 30-Second Edit Decision List

| Timeline | Source | Title | Edit instruction |
| --- | --- | --- | --- |
| 0:00-0:02 | A01 | `MEET PETTY` | Start at real launch; 8% push-in |
| 0:02-0:05 | A02 | `CHOOSE YOUR COMPANION` | Show menu and store opening |
| 0:05-0:08 | A03 | `9 CHARACTERS. ONE DESKTOP.` | Three position-matched hard cuts |
| 0:08-0:12 | A04 | `DRAG IT ANYWHERE` | 0.2s horizontal transition into shot; show slow and fast motion |
| 0:12-0:15 | A05 | `MAKE IT YOUR SIZE` | Hold 75%, 100%, and 135% visibly |
| 0:15-0:18 | A06 | `CLICK FOR A REACTION` | Preserve complete click response |
| 0:18-0:22 | A07 | `IT MOVES WHILE YOU WORK` | Keep TextEdit and Petty in frame |
| 0:22-0:25 | A08 | `AND RESTS WHEN YOU DO` | 0.25s dip at sleep, retain wake movement |
| 0:25-0:28 | A09 | `SWITCH ANYTIME` | Five 0.6s character cuts on beat |
| 0:28-0:30 | A10 | `PETTY IS OPEN SOURCE` / `STAR ON GITHUB` / `github.com/Saba-Burduli/Petty` | 0.3s fade into end card |

No title may cover the character, cursor target, settings control, or typed
text. Keep every landscape title inside x=90-930 and y=170-850.

## Music Assembly

Use these locally installed Apple Loops:

```text
/Library/Audio/Apple Loops/Apple/01 Hip Hop/Dusk Drive Pluck.caf
/Library/Audio/Apple Loops/Apple/07 Chillwave/Minimal Backbeat 01.caf
/Library/Audio/Apple Loops/Apple/04 Modern RnB/Digital Halo Synth.caf
/Library/Audio/Apple Loops/Apple/09 Disco Funk/Hang Tight Synth Riser FX.caf
```

Build a 105 BPM instrumental in GarageBand or let the render script assemble
the same local loops. Use no vocals. Keep UI effects restrained: click,
selection pop, drag whoosh, sleep drop, and end sting.

Export music as 48 kHz WAV to:

```text
marketing/trailer/work-v2/music.wav
```

## Render Commands

From the repository root:

```bash
chmod +x marketing/scripts/render_trailer_v2.sh
marketing/scripts/render_trailer_v2.sh
```

The script must fail when a required source file is absent. Do not substitute a
placeholder, screenshot, generated scene, or old export.

## Required Exports

| File | Size | FPS | Use |
| --- | ---: | ---: | --- |
| `petty-launch-trailer-30s.mp4` | 1920x1080 | 30 | README, X landscape, Reddit, YouTube |
| `petty-launch-trailer-square.mp4` | 1080x1080 | 30 | X square |
| `petty-launch-trailer-vertical.mp4` | 1080x1920 | 30 | Reels, TikTok, Shorts |
| `petty-launch-trailer-preview.gif` | 720x405 | 12 | README preview, under 15 MB |

## Technical Validation

Run:

```bash
for file in marketing/trailer/exports-v2/*.mp4; do
  ffprobe -v error \
    -show_entries format=duration:stream=codec_name,width,height,r_frame_rate \
    -of default=noprint_wrappers=1 "$file"
done

stat -f '%z %N' marketing/trailer/exports-v2/petty-launch-trailer-preview.gif
```

Every export must satisfy:

- duration between 29.9 and 30.1 seconds;
- landscape is 1920x1080 at 30 FPS;
- square is 1080x1080 at 30 FPS;
- vertical is 1080x1920 at 30 FPS;
- H.264 video and AAC audio for MP4;
- GIF is below 15 MB;
- no black or frozen frames;
- no clipped character at 135%;
- titles are readable with sound off;
- all visible interactions are real app behavior;
- no personal content appears.

## Visual QA

Generate the fixed boundary contact sheet:

```bash
ffmpeg -y -i marketing/trailer/exports-v2/petty-launch-trailer-30s.mp4 \
  -vf "select='eq(t,0)+eq(t,2)+eq(t,5)+eq(t,8)+eq(t,12)+eq(t,15)+eq(t,18)+eq(t,22)+eq(t,25)+eq(t,28)+eq(t,29.8)',scale=480:-1,tile=4x3" \
  -frames:v 1 marketing/trailer/work-v2/contact-sheet.jpg
```

Inspect the contact sheet plus one complete playback of the landscape, square,
vertical, and GIF outputs. Confirm the safe areas manually in every format.

## Promotion To README Media

Only after technical and visual QA pass:

```bash
cp marketing/trailer/exports-v2/petty-launch-trailer-30s.mp4 \
  docs/media/trailers/petty-launch-trailer-30s.mp4
cp marketing/trailer/exports-v2/petty-launch-trailer-square.mp4 \
  docs/media/trailers/petty-launch-trailer-square.mp4
cp marketing/trailer/exports-v2/petty-launch-trailer-vertical.mp4 \
  docs/media/trailers/petty-launch-trailer-vertical.mp4
cp marketing/trailer/exports-v2/petty-launch-trailer-preview.gif \
  docs/media/trailers/petty-launch-trailer-preview.gif
```

Keeping the filenames unchanged preserves current README links.

## Restore The Mac

After capture:

1. Stop the recorder and any `caffeinate` process.
2. Restore the previous wallpaper and Dock preference.
3. Restore desktop icons and notification settings.
4. Restore the previous cursor and display settings if changed.
5. Restore Petty's prior character, scale, position, and Always On Top setting.
6. Reopen only the applications that were intentionally closed.

## Commit Boundaries

Commit this runbook independently:

```bash
git add marketing/docs/AGENT_TRAILER_RUNBOOK.md
git commit -m "docs(marketing): add agent trailer production runbook"
```

Commit the renderer and validated media separately. Never commit raw footage,
temporary Screen Studio projects, exported GarageBand projects, or personal
desktop captures unless the repository explicitly tracks them.
