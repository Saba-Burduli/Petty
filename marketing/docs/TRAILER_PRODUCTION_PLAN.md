# Petty Trailer Production Plan

## Objective

Create a clean, Mac-native product trailer using only current Petty app footage.
The trailer should make the product understandable without narration:

1. Open Petty.
2. Browse the Character Store.
3. Select a character.
4. Show the character living on the desktop.
5. Drag and resize it.
6. Trigger its real animation states.
7. End with a lineup that makes the character library feel collectible.

Do not generate replacement UI, character animation, or fake interactions.

## Recommended Master

The **30-second launch trailer** should be the primary edit.

Why:

- Ten seconds is enough for a hook but not enough to explain all interactions.
- Thirty seconds supports the complete choose, place, resize, react, and switch
  loop without feeling like a tutorial.
- The 10-second teaser can be cut from its strongest moments.
- The 60-second version can extend the same footage with more characters and
  slower state demonstrations.

Recommended hook:

> Your Mac just got a tiny sidekick.

The visual should prove the statement immediately by showing the real app-open
action and the animated character appearing on a clean desktop.

## Feature Truth

Only show behavior implemented in the current app:

- Petty launches as a menu bar accessory and shows the selected character.
- `Store & Settings` opens from the `Petty` menu bar item.
- The Character Store contains nine bundled character cards.
- Selecting a card immediately changes the desktop character.
- The size slider supports 75% to 135%.
- The character window is transparent, borderless, and draggable.
- Slow and fast dragging change animation playback and subtle pose treatment.
- Clicking the character triggers its attack/poke animation for about 1.2
  seconds.
- Recent keyboard or pointer activity triggers the active/walk state.
- More than 18 seconds without system activity triggers the bored sleep/dead
  state.
- `Always On Top`, Show, Hide, and Reset Position controls exist.

Do not imply:

- Character purchases, downloads, unlocks, rarity, accounts, or cloud sync.
- AI conversation or generated character behavior.
- Physics, skeletal animation, or interactions that are not visible in the app.

## Trailer Formats

### 10-second teaser

Purpose: fast social hook for X, Reels, TikTok, Shorts, and Reddit.

Structure:

- Character visible immediately.
- Fast Character Store browse and selection.
- Drag plus poke interaction.
- Three-character switch montage.
- Petty title and short call to action.

Target copy:

- `YOUR MAC JUST GOT A TINY SIDEKICK`
- `CHOOSE. MOVE. REACT.`
- `MEET PETTY`

### 30-second launch trailer

Purpose: primary launch asset and strongest general product explanation.

Structure:

- Character-first hook.
- App/menu bar open.
- Character Store browse.
- Character selection.
- Desktop placement and resize.
- Poke, active, and bored states.
- Character-switch montage.
- End card.

Target copy:

- `YOUR MAC JUST GOT A TINY SIDEKICK`
- `CHOOSE YOUR COMPANION`
- `MOVE IT ANYWHERE`
- `MAKE IT YOUR SIZE`
- `IT REACTS WHILE YOU WORK`
- `9 CHARACTERS. ONE DESKTOP.`
- `PETTY FOR macOS`

### 60-second full demo

Purpose: YouTube, product page, GitHub release notes, and detailed Reddit posts.

Structure:

- Use the 30-second sequence at a calmer pace.
- Show the Petty menu bar controls.
- Browse more character cards.
- Demonstrate slow versus fast dragging.
- Show the 75%, 100%, and 135% size settings.
- Show click/poke, pointer movement, typing activity, and idle/sleep as separate
  moments.
- End with a longer character montage.

Optional narration should describe only visible behavior. The video must remain
understandable when muted.

## Exact Scenes to Record

Record each scene as a separate take. Leave at least two seconds before and
after the intended action.

| ID | Scene | Exact action | Required result |
| --- | --- | --- | --- |
| A01 | Clean desktop plate | Record a neutral macOS desktop with no app windows open | Clean opening/closing plate and edit handles |
| A02 | App launch | Open the built `Petty.app` from Finder, Spotlight, or Applications | Petty menu bar item appears and selected character automatically shows |
| A03 | Menu bar open | Click the `Petty` menu bar item | Show Character, Hide Character, Reset Position, Store & Settings, Always On Top, and Quit Petty are visible |
| A04 | Settings open | Choose `Store & Settings` | Settings window opens while the floating character remains visible |
| A05 | Store browse | Scroll through the Character Store grid at a steady pace | Several real character cards, names, taglines, sources, and previews are readable |
| A06 | Character select | Select Tux, Redcap Runner, or Graveyard Intern | Green selected state appears and desktop character changes immediately |
| A07 | Character montage | Select three to five distinct characters in separate clean takes | Provides fast match-cut material without fake lineup animation |
| A08 | Slow drag | Drag the character slowly across the desktop | Character follows the cursor with the real dragging animation |
| A09 | Fast drag | Drag the same character quickly to a new location | Faster playback and subtle drag-speed response are visible |
| A10 | Resize small | Move the size slider to 75% | Character and transparent panel resize without clipping |
| A11 | Resize large | Move the size slider through 100% to 135% | Growth is smooth and the character remains fully visible |
| A12 | Poke/click | Close or move settings aside, then click the character once | Attack/poke state plays for about 1.2 seconds |
| A13 | Pointer activity | Move the pointer for several seconds | Active/walk animation is visible |
| A14 | Typing activity | Type in a neutral text field while Petty remains visible | Active animation plays at the typing playback rate |
| A15 | Idle/sleep | Record continuously without input for at least 25 seconds | Character transitions to the bored sleep/dead slot after the real idle threshold |
| A16 | Wake from sleep | Move the pointer after the sleep state is visible | Character returns from bored state to active/idle behavior |
| A17 | Always on top | Toggle Always On Top and place a neutral window behind Petty | Demonstrates desktop presence without exposing private content |
| A18 | End pose | Place a selected character near the lower-right desktop area and stop input | Clean hero frame for title and call to action |

## Recording Order

Record in this order to reduce setup changes:

1. Desktop plates and app launch: A01-A04.
2. Character Store and selection: A05-A07.
3. Size controls: A10-A11.
4. Drag interactions: A08-A09.
5. Poke and activity states: A12-A14.
6. Idle transition and wake: A15-A16.
7. Always-on-top and end pose: A17-A18.

Use one primary character for interaction continuity. Recommended:

- **Graveyard Intern** for clear idle, walk, attack, and sleepy differentiation.
- **Redcap Runner** as a colorful alternative.
- **Tux**, **Surge**, and **Cyberpunk Ninja** for quick montage contrast.

## Recording Checklist

### Technical

- [ ] Build and launch the current `dev` version.
- [ ] Confirm all nine Character Store cards load.
- [ ] Confirm click, drag, resize, active, and bored states work before capture.
- [ ] Capture the complete display, not only one window.
- [ ] Verify both the floating panel and settings window appear in a test file.
- [ ] Record at native display resolution.
- [ ] Use 60 FPS if the character and drag motion remain smooth; otherwise use
      30 FPS consistently.
- [ ] Record a high-quality master with no platform compression.
- [ ] Record an OBS or QuickTime backup pass.
- [ ] Check transparent edges and shadows at 100% playback size.

### Performance

- [ ] Move the cursor deliberately and pause before clicking.
- [ ] Scroll the store slowly enough for names to be readable.
- [ ] Select one character per clean take.
- [ ] Drag on a clear path that does not cross text overlays.
- [ ] Demonstrate one slow drag and one clearly faster drag.
- [ ] Hold the resize slider at 75%, 100%, and 135% for at least one second.
- [ ] Leave two seconds of handles around each action.
- [ ] Record the complete idle threshold without cutting or simulating it.
- [ ] Repeat every critical action at least twice.

### Privacy and continuity

- [ ] Remove personal files, account names, messages, and browser content.
- [ ] Keep the same wallpaper, display scaling, menu bar layout, and pointer
      size across takes.
- [ ] Keep Petty's starting position consistent unless the shot demonstrates
      movement.
- [ ] Use a neutral text document for the typing shot.
- [ ] Disable notification banners and Focus interruptions.

## Desktop Preparation Checklist

- [ ] Use one display for the final recording.
- [ ] Select a quiet wallpaper with enough contrast around the character.
- [ ] Hide desktop icons.
- [ ] Close private and unrelated applications.
- [ ] Remove unrelated menu bar items where practical.
- [ ] Enable Do Not Disturb or a recording Focus mode.
- [ ] Disable automatic wallpaper changes.
- [ ] Disable screen saver, display sleep, and auto-lock for the session.
- [ ] Set system cursor size to default unless a larger cursor is needed for
      readability.
- [ ] Set display brightness and color profile before recording.
- [ ] Clean the Dock or use auto-hide consistently.
- [ ] Place a neutral editor or text window behind Petty for the activity shot.
- [ ] Reset Petty's saved position before the first take.
- [ ] Set Petty to 100% scale for launch and store shots.
- [ ] Confirm no debug windows, Terminal output, Xcode, or build paths are
      visible in final product shots.

## Text Overlay Plan

Use short, literal overlays that match visible behavior.

| Moment | Primary overlay | Optional support line |
| --- | --- | --- |
| Opening character shot | `YOUR MAC JUST GOT A TINY SIDEKICK` | None |
| Store browse | `CHOOSE YOUR COMPANION` | `9 BUNDLED CHARACTERS` |
| Character selection | `PICK A PERSONALITY` | Avoid implying purchases or rarity |
| Drag | `MOVE IT ANYWHERE` | None |
| Resize | `MAKE IT YOUR SIZE` | `75% - 135%` |
| Poke | `GIVE IT A POKE` | None |
| Pointer/typing activity | `IT REACTS WHILE YOU WORK` | `POINTER / TYPING / IDLE` |
| Sleep | `AND RESTS WHEN YOU DO` | None |
| Character montage | `9 CHARACTERS. ONE DESKTOP.` | `CHOOSE YOUR PETTY` |
| End card | `PETTY FOR macOS` | `A TINY DESKTOP COMPANION` |

Overlay rules:

- Use one message at a time.
- Keep each message on screen for at least 1.2 seconds in the 30-second edit.
- Keep text outside the character's movement path.
- Use sentence case or restrained uppercase consistently.
- Do not put feature instructions inside floating cards.
- Build vertical versions with larger type and central safe margins.

## Music and Sound Direction

### Music

Use an upbeat instrumental with:

- Playful electronic percussion.
- Light chiptune or plucked-synth character.
- Clean modern production rather than retro-game pastiche.
- A clear beat for character-switch match cuts.
- A small lift around the interaction montage.
- A resolved final beat for the Petty end card.

Target tempo: approximately 105-125 BPM.

Avoid:

- Epic cinematic music.
- Aggressive EDM drops.
- Childish novelty music.
- Recognizable game or film themes.
- Music with vocals competing with text overlays.

Use properly licensed music and retain the license record with the project.

### Sound design

Use subtle interface sound effects:

- Soft launch chime.
- Light menu/store click.
- Small selection pop.
- Gentle drag movement accent.
- Slider ticks at key size stops.
- Short poke reaction sound.
- Quiet sleep cue.
- Soft whoosh between montage characters.

Do not add sounds that imply unimplemented physics or speech.

## Editing Style

- Mac-native, restrained, and interaction-first.
- Open on the product, not a long logo animation.
- Use hard cuts and short eased zooms aligned to real cursor actions.
- Use match cuts between character selections.
- Keep the desktop and app UI recognizable.
- Use cursor emphasis only when it clarifies a click or drag.
- Avoid excessive click rings, fake depth, heavy glow, or template transitions.
- Allow the character animation to complete before cutting away from poke and
  sleep states.
- Speed up only dead time between actions; do not speed up the actual product
  behavior when demonstrating responsiveness.
- Keep color treatment neutral so sourced characters retain their original
  colors.
- Use a short title card at the end, not at the beginning.

## Edit Structure by Length

| Section | 10-second teaser | 30-second launch | 60-second demo |
| --- | ---: | ---: | ---: |
| Hook/launch | 1.5 sec | 3 sec | 5 sec |
| Store browse/select | 2 sec | 5 sec | 12 sec |
| Drag/resize | 2 sec | 7 sec | 12 sec |
| Poke/activity/sleep | 2 sec | 8 sec | 18 sec |
| Character montage | 1.5 sec | 4 sec | 8 sec |
| End card | 1 sec | 3 sec | 5 sec |

## Export Deliverables

Export from one approved high-quality master. Use H.264 video with AAC audio
for platform files and retain a ProRes archival master.

| Destination | Canvas | Recommended use |
| --- | --- | --- |
| X landscape | 1920x1080, 16:9 | Primary 10- or 30-second post |
| X square | 1080x1080, 1:1 | Feed-focused teaser with larger text |
| Reddit landscape | 1920x1080, 16:9 | Native upload for product/dev communities |
| TikTok | 1080x1920, 9:16 | 10- or 30-second vertical version |
| Instagram Reels | 1080x1920, 9:16 | Vertical launch cut |
| YouTube Shorts | 1080x1920, 9:16 | Vertical teaser or 30-second cut |
| YouTube full | 1920x1080, 16:9 | 30- or 60-second trailer/demo |

Suggested filenames:

```text
petty-trailer-master-prores.mov
petty-teaser-x-landscape-1920x1080.mp4
petty-teaser-x-square-1080x1080.mp4
petty-launch-reddit-1920x1080.mp4
petty-launch-vertical-1080x1920.mp4
petty-launch-youtube-1920x1080.mp4
petty-demo-youtube-1920x1080.mp4
```

## Vertical Reframe Rules

- Keep the character within the center 60% of the frame.
- Place settings to one side and crop unused desktop space.
- Enlarge overlays rather than adding more text.
- Keep critical content away from top and bottom platform UI.
- Reframe each shot manually; automatic reframing may follow the settings
  window instead of the floating character.
- For store browsing, use a close crop on the grid rather than showing the full
  16:9 desktop.

## Acceptance Checklist

The trailer plan is ready for production when:

- [ ] Every planned feature can be recorded in the current app.
- [ ] The transparent floating character is visible in test capture.
- [ ] The 30-second storyboard fits without accelerating product behavior.
- [ ] All overlays describe visible behavior accurately.
- [ ] The same source takes can support landscape, square, and vertical edits.
- [ ] Music and sound licenses are documented.
- [ ] No private desktop information appears.
- [ ] No generated or simulated product footage is required.
