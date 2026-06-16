#!/usr/bin/env python3
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Petty/Petty/Resources/Characters/Zed/zed-zombie-spritesheet-source.png"
OUT_DIR = ROOT / "Petty/Petty/Resources/Characters/Zed/Frames"

FRAME_NAMES = [
    "zed_idle.png",
    "zed_active.png",
    "zed_bored.png",
    "zed_poked.png",
    "zed_drag_slow.png",
    "zed_drag_fast.png",
]


def remove_green_background(image: Image.Image) -> Image.Image:
    rgba = image.convert("RGBA")
    pixels = rgba.load()

    for y in range(rgba.height):
        for x in range(rgba.width):
            red, green, blue, alpha = pixels[x, y]
            is_green_screen = green > 150 and red < 90 and blue < 90
            if is_green_screen:
                pixels[x, y] = (red, green, blue, 0)
            elif alpha > 0 and green > red * 1.35 and green > blue * 1.35:
                # Softly despill edge pixels that picked up the chroma background.
                pixels[x, y] = (red, min(green, max(red, blue) + 25), blue, alpha)

    return rgba


def trim(image: Image.Image) -> Image.Image:
    alpha = image.getchannel("A")
    box = alpha.getbbox()
    if box is None:
        return image

    padding = 18
    left = max(box[0] - padding, 0)
    top = max(box[1] - padding, 0)
    right = min(box[2] + padding, image.width)
    bottom = min(box[3] + padding, image.height)
    return image.crop((left, top, right, bottom))


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    source = Image.open(SOURCE)
    frame_width = source.width // len(FRAME_NAMES)

    for index, name in enumerate(FRAME_NAMES):
        left = index * frame_width
        right = source.width if index == len(FRAME_NAMES) - 1 else (index + 1) * frame_width
        frame = source.crop((left, 0, right, source.height))
        transparent = trim(remove_green_background(frame))
        transparent.save(OUT_DIR / name)


if __name__ == "__main__":
    main()
