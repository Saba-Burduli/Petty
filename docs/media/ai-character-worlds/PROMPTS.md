# AI Character World Prompts

Generated with the built-in ImageGen tool from Petty's existing character
frames as visual references.

## Graveyard Intern

- Preserve the teal spotted skin, large white eyes, red-brown hair, torn red
  shirt, blue shorts, and oversized red-white sneakers.
- Place the character in a moonlit abandoned city with wet streets, vegetation,
  fog, and distant emergency lighting.
- Show awake, excited, and sleepy emotional states.
- Render the title `GRAVEYARD INTERN` and labels
  `AWAKE  •  EXCITED  •  SLEEPY`.

## Storm Trooper

- Create an original retro-futuristic orbital patrol companion with white
  segmented armor, a graphite undersuit, a narrow black visor, and friendly
  toy-like proportions.
- Place the character in an orbital-station corridor with windows, vapor,
  red warning accents, and a distant planet.
- Show alert, patrol, action, and resting states.
- Add the local Petty display name `STORM TROOPER` and labels
  `ALERT  •  PATROL  •  REST` during deterministic post-processing.

## Cyberpunk Ninja

- Preserve the deep navy angular hood, obscured face, dark red visor, compact
  silhouette, and vivid magenta energy trail.
- Place the character on a rain-soaked neon megacity rooftop with steam,
  reflective surfaces, cables, trains, and layered skyline depth.
- Show focus, dash, strike, and rest states.
- Render the title `CYBERPUNK NINJA` and labels
  `FOCUS  •  DASH  •  REST`.

## Motion Treatment

Each character has a distinct environmental motion treatment:

- Tux: snowfall and aurora-like light breathing.
- Surge: wind and horizontal speed streaks.
- Redcap Runner: drifting rooftop steam.
- Graveyard Intern: rainfall and moody light variation.
- Cyberpunk Ninja: neon rain and a moving magenta light sweep.
- Shadowbyte Kunoichi: drifting cherry petals.
- Ironkeep Sentinel: rain and forge embers.
- Relic Scout: pulsing fireflies and warm relic light.
- Storm Trooper: red alarm pulses, vapor, and the real Petty sprite frames.

The renderer also applies restrained camera drift and depth movement. It uses
the real Storm Trooper pixel frames because ImageGen would not produce a
faithful transformation of that supplied character.
