# Petty Marketing Prompt Library

## Purpose

This library provides reusable prompts for Petty marketing images, trailer
planning, and motion direction.

Petty already has real 2D character assets and a working macOS app. These
prompts must support those assets, not replace them.

## Non-Negotiable Visual Rules

Apply these rules to every image or video prompt:

- Use the real transparent PNG character supplied as an input.
- Keep the character's pixels, proportions, colors, face, clothing, pose, and
  silhouette unchanged.
- Use real Petty screenshots or recordings when showing the product UI.
- Generate or design only backgrounds, typography, framing, decorative
  elements, and motion graphics.
- Keep backgrounds and effects visibly 2D.
- Leave clear negative space for the real character and approved copy.
- Do not generate new characters, mascots, creatures, people, or character
  variations.
- Do not recreate copyrighted game, anime, film, comic, or television worlds.
- Do not copy another product's brand system, logo, interface, or campaign.
- Do not create fake app UI, fake Character Store cards, fake settings, or
  unsupported product behavior.
- Avoid 3D rendering, photorealism, realistic depth, ray-traced materials,
  cinematic 3D environments, plastic figurine treatments, and volumetric 3D
  scenes.
- Avoid watermarks, signatures, unrelated logos, and extra text.

## Input Roles

Use these placeholders consistently:

| Placeholder | Meaning | Allowed treatment |
| --- | --- | --- |
| `[REAL_CHARACTER_PNG]` | Existing transparent character frame exported from `Petty/Petty/Resources/Characters` | Position, scale uniformly, and add a restrained 2D shadow; do not redraw or alter |
| `[REAL_CHARACTER_PNG_1..N]` | Multiple approved existing character PNGs | Arrange as a lineup; preserve each asset unchanged |
| `[REAL_APP_SCREENSHOT]` | Screenshot captured from the current Petty app | Crop and place inside a simple frame; do not redraw UI |
| `[REAL_DESKTOP_SCREENSHOT]` | Current macOS desktop screenshot with Petty visible | Crop, mask private content, and add text outside product UI |
| `[REAL_APP_FOOTAGE]` | Current screen recording | Edit, crop, zoom, caption, and add sound; do not fabricate behavior |
| `[APPROVED_COPY]` | Exact marketing text supplied for the composition | Render verbatim; do not invent additional claims |
| `[TARGET_SIZE]` | Required canvas dimensions | Keep text and character inside platform-safe margins |

## Universal Image Prompt Suffix

Append this block to image-generation or image-editing prompts:

```text
The existing character PNG is a locked compositing asset. Do not redraw,
repaint, restyle, relight, regenerate, expand, or replace it. Generate only the
empty 2D background and supporting graphic elements. Use flat illustrated
shapes, restrained soft gradients, simple texture, and clean layered depth.
Leave the requested character area empty when the character is not supplied to
the generation tool. No new characters, people, creatures, mascots, fake app
UI, copyrighted worlds, brand logos, watermarks, 3D rendering, photorealism,
realistic materials, or extra text.
```

## Universal Video Prompt Suffix

Append this block to editing or motion prompts:

```text
Use only the supplied real Petty screen recording and approved graphic assets.
Do not generate replacement product footage, new character animation, fake
cursor actions, fake UI, or interactions not present in the recording. Preserve
the real timing of click, drag, resize, activity, and sleep behavior. Motion
graphics must remain flat and 2D, with restrained easing and no 3D camera scene.
```

## 1. 2D Background Prompts

These prompts generate **backgrounds only**. Composite the real character
afterward in Figma, Photoshop, Canva, or another layer-based editor.

### Prompt 1A - Cozy Mac workspace

```text
Create an empty 2D illustrated background for a macOS desktop companion app
showcase.

Canvas: [TARGET_SIZE]
Scene: a calm modern home workspace with a desk edge, small plant, notebook,
soft window light, and a simplified monitor shape.
Style: polished editorial 2D illustration, flat shapes, gentle soft gradients,
subtle paper-grain texture, crisp silhouettes, restrained detail.
Palette: charcoal, cool gray, off-white, muted green, and one warm accent.
Composition: keep the foreground area at [CHARACTER_POSITION] completely empty
for placing [REAL_CHARACTER_PNG]. Reserve [TEXT_POSITION] for approved copy.
Mood: playful, focused, cozy, Mac-friendly, contemporary startup product.

Do not include a character, person, animal, mascot, app interface, logo, or
readable screen content. Avoid 3D, realism, isometric rendering, glossy
materials, and clutter.
```

### Prompt 1B - Minimal desktop color field

```text
Design a clean abstract 2D background for a desktop companion social image.

Canvas: [TARGET_SIZE]
Use large flat geometric fields, one soft radial gradient, a subtle grid or
paper texture, and two or three small decorative marks suggesting motion.
Create a clear ground line or shallow 2D platform so an existing transparent
PNG character can feel placed without creating realistic perspective.
Leave 40 percent of the canvas empty at [CHARACTER_POSITION].
Leave a separate high-contrast text zone at [TEXT_POSITION].
Palette: [PALETTE].

No characters, faces, bodies, UI, logos, realistic rooms, 3D shapes, rendered
objects, lens effects, or text.
```

### Prompt 1C - Night coding workspace

```text
Create an empty 2D illustrated night workspace background for a macOS desktop
companion showcase.

Canvas: [TARGET_SIZE]
Scene elements: simplified desk, flat monitor glow, code-like abstract lines
with no readable text, small desk lamp, mug silhouette, dark window, and a few
city-light rectangles.
Style: flat 2D animation background, clean linework, limited shapes, subtle
grain, no realistic depth.
Palette: deep navy, graphite, muted cyan, and a small warm amber accent.
Composition: leave the lower-right foreground empty for [REAL_CHARACTER_PNG];
leave upper-left negative space for [APPROVED_COPY].

No character, person, animal, mascot, branded software, readable code, fake app
UI, 3D render, photorealism, neon-city franchise imagery, or text.
```

### Prompt 1D - Playful collectible shelf

```text
Create an empty 2D illustrated display environment for presenting multiple
existing character PNGs.

Canvas: [TARGET_SIZE]
Build a simple flat shelf or stepped platform with nine clearly separated
placement zones. Use rounded 2D shapes, thin outlines, quiet shadows, and a
light neutral background. Keep every placement zone empty. Add small abstract
labels or color tabs without readable text.
Style: modern collectible catalog illustration, playful but not childlike.
Composition: balanced front view with no perspective distortion.

No characters, toys, figurines, faces, mascots, names, logos, 3D shelves,
realistic materials, glass cases, or text.
```

### Prompt 1E - Quiet abstract motion field

```text
Create an empty 2D campaign background suggesting that a desktop is becoming
more alive.

Canvas: [TARGET_SIZE]
Use a calm dark base, thin curved motion lines, small flat sparks, subtle
concentric rings, and one bright accent path moving toward an empty character
placement zone. Keep the scene minimal and graphic.
Style: contemporary 2D motion-design keyframe, vector-like, soft grain.
Leave the center-right empty for [REAL_CHARACTER_PNG] and the upper-left empty
for [APPROVED_COPY].

Do not draw living creatures, eyes, faces, hands, app windows, logos, 3D depth,
realistic lighting, or text.
```

## 2. X Post Layout Prompts

Use these prompts with a layout/composition assistant or as a design brief.
Real character and screenshot assets must be supplied separately.

### Prompt 2A - X landscape launch post

```text
Create a precise layout plan for a 1600x900 X launch image.

Inputs:
- [REAL_CHARACTER_PNG] as a locked foreground asset
- [REAL_APP_SCREENSHOT] as a locked product screenshot
- Copy: [APPROVED_COPY]

Layout:
- Put the real app screenshot on the left at approximately 58 percent width.
- Put the real character on the lower-right at a readable scale.
- Place the headline above the character using no more than two lines.
- Add one short support line and a small Petty wordmark area.
- Use a simple 2D illustrated background with high contrast and no decorative
  card behind the headline.
- Keep 64-pixel outer margins and avoid placing important content at the
  extreme bottom-right.

Do not redraw either input asset. Do not generate characters, fake UI, feature
badges, ratings, awards, or unsupported claims.
```

### Prompt 2B - X square character-first post

```text
Design a 1080x1080 X image composition using [REAL_CHARACTER_PNG] unchanged.

Use a bold character-first layout:
- Character occupies approximately 42 percent of the canvas.
- Headline occupies the opposite upper quadrant.
- Add three small flat 2D state markers labeled only with approved terms from
  [APPROVED_COPY].
- Use one simple 2D environment cue related to desktop work, not a full scene.
- Keep the composition readable at mobile feed size.

Typography should be large, compact, and left aligned. Use no more than 12 words
in the main copy. Do not create new character poses or draw additional
characters.
```

### Prompt 2C - X four-image thread system

```text
Create a consistent four-image X thread layout system for Petty.

Image 1: product hook using [REAL_CHARACTER_PNG] and [APPROVED_COPY].
Image 2: [REAL_APP_SCREENSHOT] showing Character Store selection.
Image 3: real desktop screenshot showing drag or resize behavior.
Image 4: real asset lineup using [REAL_CHARACTER_PNG_1..N].

Use the same typography, margins, corner treatment, background palette, and
small Petty identifier on all four images. Keep every background 2D and simple.
Do not alter or regenerate supplied assets. Return layout specifications,
placement percentages, text hierarchy, and safe margins only.
```

## 3. Reddit Launch Image Prompts

### Prompt 3A - Reddit product proof image

```text
Create a 1920x1080 Reddit launch-image layout that prioritizes product proof
over branding.

Inputs:
- [REAL_DESKTOP_SCREENSHOT] showing Petty running
- [REAL_CHARACTER_PNG] for one optional enlarged detail
- Exact headline: [APPROVED_COPY]

Use the real desktop screenshot as the primary content. Add a narrow 2D
illustrated title band at the top or left, not a fake device mockup. If the
character detail is used, place the unchanged PNG beside the screenshot with a
simple flat arrow pointing to the real character in the screenshot.
Keep labels factual and minimal.

No fake app UI, fake comments, upvote graphics, platform logos, generated
characters, 3D laptop frames, or marketing-award badges.
```

### Prompt 3B - Reddit developer story image

```text
Design a 1600x900 launch image for a developer-focused Reddit post about a
native macOS desktop companion.

Use [REAL_APP_SCREENSHOT] unchanged at full readable size.
Place [REAL_CHARACTER_PNG] outside the screenshot as a locked decorative asset.
Use a quiet 2D grid background, monospace-inspired secondary typography, and
one short headline from [APPROVED_COPY].
Include a small factual footer area for: native macOS, transparent desktop
window, authored PNG animation states.

Do not invent performance numbers, user counts, AI features, code screenshots,
or extra interface elements.
```

## 4. Character Card Background Prompts

Generate these backgrounds without the character, then place the real PNG in
the reserved space.

### Prompt 4A - Neutral reusable card

```text
Create an empty 2D character-card background.

Canvas: 1200x1500 portrait.
Layout: large empty character area in the upper 68 percent, name area below,
small state-label row at the bottom.
Style: flat editorial illustration with a subtle frame, simple ground ellipse,
two abstract accent shapes, and soft paper texture.
Palette: [CHARACTER_PALETTE] with a neutral background and high text contrast.
Keep the character area completely empty for [REAL_CHARACTER_PNG].

No character, silhouette, face, props, fake stats, rarity tier, price, logo,
3D card, foil effect, trading-card imitation, or text.
```

### Prompt 4B - Character mood card

```text
Create an empty 2D scene background for an individual Petty character card.

Theme: [MOOD_THEME], expressed through abstract environment cues rather than a
recognizable franchise world.
Use flat layered shapes, a restrained horizon, simple decorative particles, and
a clear foreground placement zone. Keep the visual weight around the edges so
[REAL_CHARACTER_PNG] remains the focus.
Canvas: [TARGET_SIZE]
Palette: [CHARACTER_PALETTE]

Do not draw characters, weapons, branded locations, copyrighted architecture,
realistic scenery, 3D materials, or text.
```

### Prompt 4C - Four-state card layout

```text
Create a layout specification for a 1600x900 character-state card using four
real PNG inputs:

- [REAL_IDLE_PNG]
- [REAL_WALK_PNG]
- [REAL_ATTACK_PNG]
- [REAL_SLEEP_PNG]

Keep every PNG unchanged. Arrange one large idle pose on the left and three
smaller state poses on the right in a clean 2D editorial grid. Use labels
`IDLE`, `ACTIVE`, `POKE`, and `REST` only if they match the supplied assets.
Add a quiet flat-color background and thin dividers. Return placement, scale,
spacing, typography, and color guidance.

Do not generate poses, interpolate frames, redraw characters, or add fake
effects over their bodies.
```

## 5. Desktop Mockup Composition Prompts

### Prompt 5A - Real screenshot composition

```text
Compose a polished social image from [REAL_DESKTOP_SCREENSHOT].

Canvas: [TARGET_SIZE]
Preserve the screenshot and all visible Petty UI exactly. Crop only to improve
focus and mask any private information without changing the product.
Add a flat 2D background outside the screenshot, one headline from
[APPROVED_COPY], and a small arrow or ring highlighting the real desktop
character. Use a simple border or shallow shadow around the screenshot.

Do not redraw the Mac desktop, create a fake monitor, replace the screenshot,
insert a different character, alter the app UI, or use a 3D device mockup.
```

### Prompt 5B - Desktop plus source character detail

```text
Create a split editorial composition using:

- [REAL_DESKTOP_SCREENSHOT] as the product proof
- [REAL_CHARACTER_PNG] as an unchanged close-up detail
- [APPROVED_COPY] as exact text

Place the screenshot across the lower two-thirds. Place the character close-up
partially outside the screenshot boundary without covering the real character
inside the screenshot. Use a flat 2D background and a thin connector line
between the close-up and the real desktop position.
Keep the design quiet, modern, and readable on mobile.

No fake UI, new character pose, 3D laptop, realistic room, excessive glow, or
extra text.
```

## 6. Trailer Editing Prompts

These are instructions for an editor or editing assistant. They require real
footage.

### Prompt 6A - 30-second real-footage edit

```text
Edit a 30-second Petty launch trailer using only [REAL_APP_FOOTAGE].

Required sequence:
1. Open Petty and show the character within the first second.
2. Open Store & Settings.
3. Browse real character cards.
4. Select one character and show the immediate desktop change.
5. Show one slow drag and one faster drag.
6. Show the size slider moving between 75%, 100%, and 135%.
7. Show the complete real poke reaction.
8. Show pointer or typing activity.
9. Show the end of a real idle-to-sleep recording.
10. End with several real character selections and a Petty title.

Use restrained cuts, short 2D text overlays, subtle cursor emphasis, and a
playful electronic instrumental. Preserve real product timing. Do not generate,
reconstruct, or simulate missing footage.
```

### Prompt 6B - 10-second social cut

```text
Create a 10-second social teaser using only approved clips from
[REAL_APP_FOOTAGE].

Open on the real app launch and character appearance. Cut quickly to character
selection, drag, resize, poke, and a two-character montage. Use these exact text
beats:

`YOUR MAC JUST GOT A TINY SIDEKICK`
`CHOOSE. MOVE. REACT.`
`PETTY FOR macOS`

Keep the character visible within the first second. Use flat 2D title animation,
hard cuts on the music beat, and no fake product actions.
```

### Prompt 6C - Vertical reframe

```text
Reframe the approved Petty trailer into 1080x1920 using only the existing
edited footage.

Track the real floating character manually and keep it within the center 60
percent of the frame. Crop Character Store footage tightly enough to show two
cards clearly. Reposition existing text overlays into vertical safe areas.
Do not use generative extend, fake desktop pixels, automatic character
replacement, or new UI. If a shot cannot fit, use a different real take.
```

### Prompt 6D - Sound and caption pass

```text
Create a sound-design and caption pass for the approved real-footage Petty
trailer.

Add only subtle sounds: launch chime, menu click, selection pop, drag accent,
three slider ticks, poke reaction, sleep cue, and short montage whooshes.
Use one upbeat instrumental around 105-125 BPM.
Keep captions brief and synchronized with visible behavior.
Do not add speech, character voices, game sound effects from copyrighted
sources, or sounds implying unimplemented physics.
```

## 7. Product Demo Storyboard Prompts

### Prompt 7A - Evidence-first storyboard

```text
Create a timestamped 30-second storyboard for Petty using only these verified
features:

- native macOS app launch
- Character Store browsing
- nine bundled character cards
- immediate character selection
- transparent draggable desktop character
- size control from 75% to 135%
- click/poke animation
- pointer and typing activity response
- sleep/bored state after real idle time

For every scene, specify timestamp, required real footage, exact overlay text,
cursor action, and sound cue. Start with the character visible within the first
second. End with `PETTY FOR macOS`.

Do not add features, generated footage, fake UI, accounts, purchases, AI chat,
or character unlocks.
```

### Prompt 7B - Shot-list generator

```text
Turn the approved Petty storyboard into a practical recording shot list.

For each shot provide:
- shot ID
- setup
- exact real user action
- expected app response
- minimum recording duration
- pre-roll and post-roll
- cursor position
- privacy risks
- landscape and vertical framing notes

Group shots by setup to reduce repeated app state changes. Require a complete
uninterrupted idle recording before using the sleep transition.
```

### Prompt 7C - Storyboard audit

```text
Audit this Petty storyboard against [VERIFIED_FEATURE_LIST].

Mark every scene as:
- verified by current app behavior
- requires a real capture test
- unsupported and must be removed

Check specifically for fake UI, invented character animation, shortened idle
claims, purchases, unlocks, AI chat, generated desktop footage, and replacement
characters. Return only actionable corrections and a revised scene order.
```

## 8. Intro and Motion Graphics Prompts

These prompts create flat overlays or motion directions, not product footage.

### Prompt 8A - Petty title reveal

```text
Design a 1.2-second flat 2D title reveal for the exact text `PETTY`.

Style: clean macOS-adjacent motion design, bold sans-serif typography, one
accent color, two or three flat geometric marks, subtle grain.
Motion: quick opacity and position ease, small accent-line sweep, then settle.
Background: transparent or flat solid color.
Keep the title readable and restrained.

No mascot, character, app UI, 3D extrusion, metallic letters, particles in
depth, lens flare, copyrighted logo styling, or extra text.
```

### Prompt 8B - Feature-label motion system

```text
Create a reusable 2D motion system for these exact Petty feature labels:

`CHOOSE YOUR COMPANION`
`MOVE IT ANYWHERE`
`MAKE IT YOUR SIZE`
`IT REACTS WHILE YOU WORK`

Each label should enter in 6-10 frames, hold, and exit cleanly. Use consistent
typography, a flat underline or side marker, and restrained ease-out motion.
Provide timing, position, safe margins, and color guidance for 16:9, 1:1, and
9:16.

No cards, 3D text, bounce-heavy presets, fake UI, icons implying unsupported
features, or additional copy.
```

### Prompt 8C - Character transition overlay

```text
Design a flat 2D transition overlay for cutting between separate real Petty
character-selection clips.

Use one quick color wipe, a small circular ripple, or two crossing flat shapes.
Duration: 6-8 frames.
The overlay must fully clear before the new real character is visible.
Use a neutral palette that does not recolor the character footage.

Do not morph characters, generate in-between poses, replace the real selection
change, use 3D rotation, or imitate a game franchise transition.
```

### Prompt 8D - End card

```text
Create a clean 2D end-card layout for the exact text:

`PETTY FOR macOS`
`A TINY DESKTOP COMPANION`

Canvas: [TARGET_SIZE]
Use a flat dark or light background, one accent line, restrained grain, and an
empty placement area for [REAL_CHARACTER_PNG]. The character will be composited
later and must remain unchanged. Keep the card readable for at least two
seconds.

No extra claims, store badges, download buttons, platform logos, characters,
3D effects, photorealism, or fake UI.
```

## Reference-Image Editing Prompt

Use this when a tool accepts both a real character PNG and a separate background
reference:

```text
Image 1 is [REAL_CHARACTER_PNG], a locked product asset.
Image 2 is [BACKGROUND_REFERENCE], used only for flat 2D palette, texture, and
composition direction.

Create a new empty 2D background inspired only by the broad color balance and
graphic simplicity of Image 2. Do not copy identifiable objects, characters,
logos, architecture, or composition. Do not modify Image 1. Leave a clean empty
placement zone matching Image 1's aspect ratio so it can be composited later.
Return the background without any character or text.
```

## Prompt Fill-In Checklist

Before running an image prompt, replace:

- `[TARGET_SIZE]`
- `[CHARACTER_POSITION]`
- `[TEXT_POSITION]`
- `[PALETTE]` or `[CHARACTER_PALETTE]`
- `[MOOD_THEME]`
- `[APPROVED_COPY]`

Before running a video prompt, provide:

- The approved real footage folder.
- The verified feature list.
- The required trailer length.
- Exact overlay copy.
- Target aspect ratio.
- Music-license constraints.

Never send the tool an approved character image without explicitly labeling it
as a locked input that must remain unchanged.

## Recommended First Five Prompts

1. **Prompt 1A - Cozy Mac workspace**

   Best first background test. It creates an empty, flexible 2D setting for one
   real character.

2. **Prompt 2A - X landscape launch post**

   Best first social composition using one real screenshot and one real
   character PNG.

3. **Prompt 4C - Four-state card layout**

   Best way to prove actual animation variety using existing source frames.

4. **Prompt 6A - 30-second real-footage edit**

   Best trailer-editing brief because it maps directly to current Petty
   behavior.

5. **Prompt 8B - Feature-label motion system**

   Best reusable motion-graphics direction for all trailer formats.

## Image vs. Video Prompt Index

### Image and layout prompts

- 1A-1E: 2D backgrounds.
- 2A-2C: X post layouts.
- 3A-3B: Reddit launch layouts.
- 4A-4C: Character card backgrounds and state layouts.
- 5A-5B: Desktop screenshot compositions.
- Reference-Image Editing Prompt.

### Trailer and video prompts

- 6A-6D: Trailer edit, social cut, vertical reframe, and sound/captions.
- 7A-7C: Storyboard, shot list, and feature-truth audit.
- 8A-8D: Intro, labels, transitions, and end-card motion direction.

## Final Prompt Audit

Reject or rewrite a prompt if it:

- Asks the model to draw, improve, restyle, or reinterpret a Petty character.
- Names a copyrighted franchise as a visual target.
- Requests a realistic, 3D, cinematic-rendered, or toy-like character.
- Requests a fake app window, menu, store, desktop, or interaction.
- Adds characters or props not present in approved source assets.
- Copies a known game, anime, film, or product campaign.
- Claims purchases, unlocks, AI chat, rarity, cloud features, or other
  unsupported behavior.
- Does not reserve empty space for the real PNG or screenshot.
- Uses generated footage in place of real Petty capture.
