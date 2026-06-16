#!/usr/bin/env python3
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Petty/Petty/Resources/Characters/Zed/Frames/zed_idle.png"
OUT_DIR = ROOT / "Petty/Petty/Resources/Characters/Zed/Rig"


def alpha_bbox(image: Image.Image) -> tuple[int, int, int, int]:
    bbox = image.getchannel("A").getbbox()
    if bbox is None:
        return (0, 0, image.width, image.height)
    padding = 8
    return (
        max(bbox[0] - padding, 0),
        max(bbox[1] - padding, 0),
        min(bbox[2] + padding, image.width),
        min(bbox[3] + padding, image.height),
    )


def crop_to_alpha(image: Image.Image) -> Image.Image:
    return image.crop(alpha_bbox(image))


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    source = Image.open(SOURCE).convert("RGBA")

    # The generated idle frame is 300x430. These masks deliberately overlap a
    # little at the neck so small rig rotations do not expose holes.
    head_mask = Image.new("L", source.size, 0)
    draw = ImageDraw.Draw(head_mask)
    draw.ellipse((6, 8, 294, 268), fill=255)
    draw.rectangle((42, 0, 262, 126), fill=255)
    head_mask = head_mask.filter(ImageFilter.GaussianBlur(1.0))

    body_mask = source.getchannel("A").copy()
    erase = Image.new("L", source.size, 0)
    erase_draw = ImageDraw.Draw(erase)
    erase_draw.ellipse((10, 0, 290, 250), fill=255)
    erase = erase.filter(ImageFilter.GaussianBlur(2.0))
    body_mask = Image.composite(Image.new("L", source.size, 0), body_mask, erase)

    shadow_mask = Image.new("L", source.size, 0)
    shadow_draw = ImageDraw.Draw(shadow_mask)
    shadow_draw.ellipse((82, 386, 222, 423), fill=95)
    shadow_mask = shadow_mask.filter(ImageFilter.GaussianBlur(8))
    shadow = Image.new("RGBA", source.size, (0, 0, 0, 0))
    shadow.putalpha(shadow_mask)

    head = source.copy()
    head.putalpha(Image.composite(source.getchannel("A"), Image.new("L", source.size, 0), head_mask))

    body = source.copy()
    body.putalpha(body_mask)

    crop_to_alpha(head).save(OUT_DIR / "zed_head.png")
    crop_to_alpha(body).save(OUT_DIR / "zed_body.png")
    crop_to_alpha(shadow).save(OUT_DIR / "zed_shadow.png")


if __name__ == "__main__":
    main()
