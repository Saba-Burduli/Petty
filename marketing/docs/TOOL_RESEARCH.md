# Petty Trailer Tool Research

## Scope

This research covers tools and workflow for a trailer made from **real Petty
app footage**. It does not recommend generated replacement footage, app code
changes, or final asset production.

Research and pricing were checked against official product pages on
June 18, 2026. Prices can change by region, billing period, taxes, and
promotion.

## Recommendation Summary

| Need | Recommendation | Why |
| --- | --- | --- |
| Best recording tool | **Screen Studio** | Fastest route to a polished macOS product demo, with automatic zoom, cursor smoothing, manual zoom control, system audio, camera/mic capture, background styling, and up to 4K/60 FPS export. |
| Best editing tool | **Final Cut Pro** | Best fit for high-quality Mac-native finishing, precise timing, titles, music, keyframed crops/pans, color, audio, captions, and multiple aspect-ratio versions. |
| Best AI-assisted tool | **Descript** | Useful for transcript-based editing, filler-word cleanup, captions, voiceover correction, and converting a spoken demo into shorter social cuts without replacing real footage. |
| Best budget/free option | **OBS Studio + DaVinci Resolve** | OBS provides reliable full-display recording; Resolve provides professional editing, color, audio, effects, captions, and vertical timelines at no cost. |
| Best high-quality/pro option | **Screen Studio + Final Cut Pro**, with Descript as needed | Screen Studio accelerates capture and cursor presentation; Final Cut keeps the master edit local and gives the strongest control over final delivery. |

## Petty-Specific Capture Requirement

Petty renders its character in a separate transparent, borderless, floating
macOS window. That creates an important capture constraint:

- Prefer **full-display capture** rather than capturing only one app window.
- A window-only recorder may capture the settings window but omit the separate
  floating character window.
- Record a 10-second test showing both the Character Store and the floating
  character before recording the full trailer.
- Verify transparent edges, shadows, cursor visibility, dragging, and resize
  behavior in the recorded file, not only in the live preview.
- If a recorder's automatic zoom follows only one window, use manual zooms or
  edit zooms later so the floating character remains framed.

This is a workflow recommendation based on Petty's window architecture. No
vendor reviewed here explicitly guarantees capture of every custom transparent
window configuration.

## Tool Comparison

| Tool | Best role | Relevant strengths | Limitations for Petty | Pricing notes |
| --- | --- | --- | --- | --- |
| [Screen Studio](https://screen.studio/) | Best polished recorder | macOS-focused; automatic zoom; manual zoom; smooth cursor; cursor loop control; screen, system audio, mic, and camera capture; backgrounds; crop and resize; up to 4K/60 FPS export | Paid; automatic framing still needs a test with Petty's separate floating window; not as deep as a full nonlinear editor | Official pricing page showed about **$29/month billed monthly** or **$9/month billed yearly** |
| [ScreenFlow](https://www.telestream.net/screenflow/overview.htm) | Strong Mac all-in-one recorder/editor | Records screen, camera, mic, and computer audio; multitrack timeline; titles, transitions, animation, captions, media library, and high-resolution capture | Interface and workflow are heavier than Screen Studio; one application must handle both capture and finishing; transparent overlay still requires full-display testing | Official store listed **$169** for ScreenFlow 10 and **$239** for the Super Pak |
| [OBS Studio](https://obsproject.com/) | Best free recorder | Free/open source; macOS display capture; multiple sources and scenes; high-quality local recording; flexible frame rate, resolution, and audio routing | No automatic cursor smoothing or product-demo zooms; setup is more technical; editing must happen elsewhere | Free |
| [QuickTime Player](https://support.apple.com/guide/quicktime-player/record-your-screen-qtp97b08e666/mac) | Simplest built-in fallback | Included with macOS; records the entire screen or a selected portion; dependable for a clean raw master | No product-demo cursor polish, automatic zoom, scene management, or serious editing | Included with macOS |
| [CleanShot X](https://cleanshot.com/) | Fast utility recorder and screenshots | Fullscreen/window/area recording, cursor controls, click display, keystroke display, camera overlay, system audio, scrolling capture, screenshot annotation | Better as a capture utility than a full trailer editor; polished zoom/pan work still belongs in an editor | Basic license **$29 one-time** with one year of updates; Cloud Pro shown from **$8/user/month billed annually** |
| [Camtasia](https://www.techsmith.com/camtasia/) | Tutorial-style all-in-one | Screen recording, cursor path editing, cursor effects, zoom/pan, annotations, captions, transitions, templates, and timeline editing | Subscription cost; visual style can feel instructional unless edited carefully; less Mac-native than Final Cut | Subscription plans; verify current checkout price before purchase |
| [CapCut Desktop](https://www.capcut.com/tools/desktop-video-editor) | Fast social cutdowns | Desktop editor, auto captions, effects, keyframes, background tools, templates, music, and social-first vertical editing | Pricing/features vary by region and plan; template-heavy output can look generic; cloud/AI features may require uploads | Free tier; Pro pricing varies by region and promotion |
| [Descript](https://www.descript.com/pricing) | Best AI-assisted dialogue/caption workflow | Transcript-based video editing, screen recording, captions, filler-word removal, Studio Sound, eye contact, voice tools, clip creation | Not the best primary tool for precise motion design, cursor choreography, or layered visual finishing | Free plan; official pricing showed Hobbyist from **$16/person/month billed annually**, with higher Creator and Business tiers |
| [Final Cut Pro](https://www.apple.com/final-cut-pro/) | Best Mac-native professional editor | Magnetic timeline, titles, captions, audio, color, effects, object tracking, Magnetic Mask, automatic reframing tools, optimized Apple-silicon performance | Learning curve; no built-in automatic cursor tracking like Screen Studio; complex motion graphics may need Apple Motion | **$299.99 one-time** on the Mac App Store, or included in Apple Creator Studio shown at **$12.99/month** or **$129/year** |
| [DaVinci Resolve](https://www.blackmagicdesign.com/products/davinciresolve) | Best free professional editor | Full edit, color, Fusion effects, Fairlight audio, captions, vertical resolutions, smart reframing tools, and broad delivery controls | Steeper learning curve and heavier hardware demands than CapCut or Screen Studio | Free; DaVinci Resolve Studio listed at **$295 one-time** |
| [Adobe Premiere](https://www.adobe.com/products/premiere.html) | Best cross-platform pro/editorial workflow | Mature timeline, text-based editing, captions, Auto Reframe, motion controls, audio tools, After Effects integration, broad format support | Subscription; more setup and application overhead than Final Cut for a Mac-only project | US individual plan shown around **$22.99/month** with annual billing; verify current plan bundle |
| [Runway](https://runwayml.com/pricing) | Best optional AI cleanup/effects tool | Remove Background, Inpainting, motion tracking, object removal, generative tools, web workflow | Do not use it to replace Petty with generated footage; credit limits and cloud upload; weaker than Final Cut/Resolve for the main edit | Free tier; Standard shown from **$12/user/month billed annually** |
| [VEED](https://www.veed.io/pricing) | Fast browser-based social editor | Auto subtitles, resize, text, music, brand kit, cleanup tools, and browser collaboration | Upload-dependent; less precise than Final Cut/Resolve; paid limits and pricing vary | Free tier plus paid plans; verify current regional checkout |

## Recording Recommendation

### Primary: Screen Studio

Use Screen Studio when the priority is a clean product-demo look with minimal
manual cursor and zoom work.

Recommended settings:

- Capture the entire display containing Petty.
- Record at the display's native resolution.
- Use 60 FPS if the Mac records it smoothly; otherwise use 30 FPS consistently.
- Record system audio only when it is intentionally part of the trailer.
- Hide desktop icons and notifications.
- Keep cursor smoothing enabled, but disable excessive automatic zooms.
- Export a high-quality master before social compression.

Why it wins:

- Petty benefits from cursor emphasis during store selection, clicking, dragging,
  and resizing.
- Screen Studio's automatic and manual zoom systems can quickly create a
  polished demo without simulating any app behavior.
- Background and canvas controls can make a raw macOS capture presentable before
  it reaches the editor.

### Capture fallback: OBS Studio

Use OBS when Screen Studio fails to include the floating transparent character,
when maximum capture control is required, or when avoiding paid software.

Suggested OBS setup:

- Add a macOS Screen Capture source for the complete display.
- Use a 1920x1080 or native-resolution canvas.
- Record to MKV for crash resilience, then remux to MP4 inside OBS.
- Use H.264 or HEVC hardware encoding where stable.
- Record at 60 FPS for fast drag motion if performance permits.
- Keep a clean scene with no browser overlays, webcam, or decorative frame.

### Simple fallback: QuickTime Player

QuickTime is appropriate for a clean raw recording when no cursor effects are
needed during capture. Add all zooms, cursor callouts, titles, and sound later
in Final Cut Pro or DaVinci Resolve.

## Editing Recommendation

### Primary: Final Cut Pro

Build one high-quality 16:9 master timeline first. Final Cut Pro provides enough
control for:

- Intro and outro title cards.
- Exact text overlays and feature captions.
- Keyframed zooms, pans, crops, and position changes.
- Cursor callouts or highlight graphics.
- Music editing, fades, sound effects, and loudness balancing.
- Color correction between takes.
- Speed ramps and freeze frames where useful.
- Captions and multiple aspect-ratio timelines.
- Compound clips for reusable Petty sequences.

Avoid aggressive motion. Petty is a small desktop character, so zooms should
help viewers see real interactions rather than make the footage feel artificial.

### Free alternative: DaVinci Resolve

Resolve can complete the same core workflow without a software purchase. It is
the best budget choice when the editor is comfortable with a more complex
interface.

### Fast social alternative: CapCut Desktop

CapCut is suitable after the master trailer exists. Use it for quick vertical
cutdowns, captions, music timing, and platform-specific variants. Do not make
templates or generic effects the visual identity of the trailer.

## AI-Assisted Recommendation

### Descript for useful AI assistance

Use Descript only when the trailer includes narration or spoken explanation:

- Transcribe the voiceover.
- Remove filler words and long pauses.
- Correct small voiceover mistakes.
- Generate and style captions.
- Create draft short clips from the approved real-footage edit.

Return the cleaned voice/caption assets to Final Cut Pro for finishing.

### Runway for targeted cleanup only

Runway can be useful for:

- Removing an accidental desktop item from a short shot.
- Masking or tracking a small callout.
- Creating a clean plate when a minor visual obstruction cannot be recaptured.

Do not use Runway to generate Petty interactions, replace characters, invent
UI, or create fake desktop footage. Recapturing the real app is preferred.

## Recommended End-to-End Workflow

1. **Prepare the Mac**
   - Use a clean desktop and neutral wallpaper.
   - Disable notifications, badges, auto-hiding distractions, and unrelated
     menu bar items.
   - Close private windows and remove personal information.
   - Set Petty to a readable size and confirm all nine characters load.

2. **Create a shot checklist**
   - Launch Petty.
   - Open Character Store.
   - Select a character.
   - Show idle animation.
   - Type or move the pointer to trigger active behavior.
   - Click to trigger the poke/attack state.
   - Drag slowly and quickly to show speed response.
   - Resize the character.
   - Stop input long enough to show bored/sleep behavior.
   - Switch between selected characters.

3. **Test transparent-window capture**
   - Record 10 seconds using full-display capture.
   - Verify both settings and floating character windows are visible.
   - Check transparent edges and shadows at 100% playback size.

4. **Record clean takes in Screen Studio**
   - Record each behavior as a separate take.
   - Leave two seconds of still footage before and after every action.
   - Repeat important actions rather than relying on one long recording.
   - Capture at 60 FPS when drag motion remains smooth.

5. **Record a backup master**
   - Capture one uninterrupted full-display pass with OBS or QuickTime.
   - Keep this recording visually plain and high quality.

6. **Edit the 16:9 master in Final Cut Pro**
   - Target roughly 30-60 seconds.
   - Open with the character already visible on the desktop.
   - Demonstrate behavior before explaining it.
   - Use short labels such as `REACTS TO ACTIVITY`, `DRAG TO MOVE`, and
     `CHOOSE YOUR CHARACTER`.
   - Add restrained zooms, cursor emphasis, music, and an end card.

7. **Use Descript only if narration is present**
   - Clean the voice track and captions.
   - Bring the approved audio and subtitle file back into Final Cut Pro.

8. **Create platform versions from the approved master**
   - Reframe manually so the small floating character stays inside safe areas.
   - Do not rely only on automatic reframing.
   - Keep text away from the top/bottom interface overlays on vertical apps.

9. **Quality-control every export**
   - Watch once with sound and once muted.
   - Confirm text readability on a phone.
   - Check that no cursor highlight covers the character.
   - Verify the footage represents current app behavior.

## Export Plan

Use H.264 video with AAC audio for broad compatibility. Match the timeline
frame rate to the recorded footage; avoid converting 30 FPS footage to 60 FPS.

| Destination | Recommended deliverable | Notes |
| --- | --- | --- |
| YouTube | 1920x1080, 16:9, 30 or 60 FPS | Full 30-60 second trailer; keep a high-bitrate master archive. YouTube officially recommends MP4/H.264/AAC-style upload settings. |
| YouTube Shorts | 1080x1920, 9:16, up to 60 seconds for this campaign | YouTube accepts square or vertical videos as Shorts; keep Petty centered above lower UI overlays. |
| TikTok | 1080x1920, 9:16 | Use the shortest cut, larger captions, and immediate action. TikTok recommends vertical 9:16 creative. |
| Instagram Reels | 1080x1920, 9:16 | Keep essential text and Petty within the central safe area because profile/feed crops and UI differ. |
| X | 1920x1080, 16:9; optional 1080x1080 cut | X supports broad aspect ratios and MP4/MOV uploads. A concise 20-45 second cut is safer than targeting account-specific maximums. |
| Reddit | 1920x1080, 16:9; optional 1080x1350 | Prefer a direct native upload where the community permits video. Lead with the app in action and avoid a long branded intro. |

Create these files from the final approved edit:

```text
petty-trailer-master-prores.mov
petty-trailer-youtube-1080p.mp4
petty-trailer-x-reddit-1080p.mp4
petty-trailer-vertical-1080x1920.mp4
petty-trailer-square-1080x1080.mp4
```

The ProRes file is the archival master. Platform files should be generated from
that master, not downloaded and recompressed from a social platform.

## Top Three Tools

1. **Screen Studio** - best capture experience for this Mac product demo.
2. **Final Cut Pro** - best final edit and multi-format delivery on this Mac.
3. **Descript** - best AI-assisted narration, transcript, and caption workflow.

For a zero-cost workflow, replace Screen Studio and Final Cut Pro with OBS
Studio and DaVinci Resolve.

## Official Sources

### Recording

- [Screen Studio product and pricing](https://screen.studio/)
- [ScreenFlow overview](https://www.telestream.net/screenflow/overview.htm)
- [ScreenFlow store](https://www.telestream.net/telestream-store/screenflow-store.asp)
- [OBS Studio](https://obsproject.com/)
- [OBS macOS screen capture source](https://obsproject.com/kb/macos-screen-capture-source)
- [Apple QuickTime screen recording](https://support.apple.com/guide/quicktime-player/record-your-screen-qtp97b08e666/mac)
- [CleanShot X](https://cleanshot.com/)
- [CleanShot X pricing](https://cleanshot.com/pricing)
- [Camtasia](https://www.techsmith.com/camtasia/)

### Editing and AI

- [Final Cut Pro](https://www.apple.com/final-cut-pro/)
- [Final Cut Pro Mac App Store](https://apps.apple.com/us/app/final-cut-pro/id424389933)
- [DaVinci Resolve](https://www.blackmagicdesign.com/products/davinciresolve)
- [Adobe Premiere](https://www.adobe.com/products/premiere.html)
- [CapCut Desktop](https://www.capcut.com/tools/desktop-video-editor)
- [Descript pricing](https://www.descript.com/pricing)
- [Runway pricing](https://runwayml.com/pricing)
- [VEED pricing](https://www.veed.io/pricing)

### Export guidance

- [YouTube recommended upload encoding](https://support.google.com/youtube/answer/1722171)
- [YouTube Shorts upload guidance](https://support.google.com/youtube/answer/12779649)
- [X video upload requirements](https://help.x.com/en/using-x/x-videos)
- [TikTok video ad specifications](https://ads.tiktok.com/help/article/video-ads-specifications)
- [Instagram Reels placement specifications](https://www.facebook.com/business/ads-guide/update/video/instagram-reels)
- [Reddit posting videos](https://support.reddithelp.com/hc/en-us/articles/360043513151-Posting-videos-on-Reddit)
