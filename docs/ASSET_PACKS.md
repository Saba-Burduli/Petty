# Petty Asset Packs

Petty loads bundled character packs from `Petty/Petty/Resources/Characters`.

## Folder Layout

Each character folder needs this structure:

```text
CharacterFolder/
  manifest.json
  ATTRIBUTION.md
  Frames/
    Idle/
      Idle_000.png
    Walk/
      Walk_000.png
    Attack/
      Attack_000.png
    Dead/
      Dead_000.png
```

`manifest.json` tells the app how to list the character and how many frames each animation has.

```json
{
  "id": "example-character",
  "displayName": "Example",
  "tagline": "Short store description",
  "source": "License and author/source",
  "sortOrder": 60,
  "animations": {
    "idle": { "folder": "Idle", "frameCount": 10, "framesPerSecond": 7, "loops": true },
    "walk": { "folder": "Walk", "frameCount": 10, "framesPerSecond": 10, "loops": true },
    "attack": { "folder": "Attack", "frameCount": 8, "framesPerSecond": 14, "loops": true },
    "sleep": { "folder": "Dead", "frameCount": 10, "framesPerSecond": 4, "loops": false }
  }
}
```

The folder name becomes the resource path used by the renderer. Keep IDs stable, because user selection is stored by ID.
