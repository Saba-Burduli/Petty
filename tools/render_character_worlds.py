#!/usr/bin/env python3

import math
import random
import subprocess
from pathlib import Path

from PIL import Image, ImageDraw, ImageEnhance, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
MEDIA = ROOT / "docs/media/ai-character-worlds"
LIVE = MEDIA / "live"
FPS = 24
DURATION = 4
SIZE = (1280, 720)


WORLDS = [
    ("tux", "tux-ai.png", "snow"),
    ("surge", "surge-ai.png", "speed"),
    ("redcap-runner", "redcap-runner-ai.png", "steam"),
    ("graveyard-intern", "graveyard-intern-ai.png", "rain"),
    ("cyberpunk-ninja", "cyberpunk-ninja-ai.png", "neon-rain"),
    ("shadowbyte-kunoichi", "shadowbyte-kunoichi-ai.png", "petals"),
    ("ironkeep-sentinel", "ironkeep-sentinel-ai.png", "rain-embers"),
    ("relic-scout", "relic-scout-ai.png", "fireflies"),
    ("storm-trooper", "storm-trooper-ai.png", "alarm"),
]


def cover_crop(image, frame):
    phase = frame / (FPS * DURATION)
    zoom = 1.025 + 0.018 * math.sin(phase * math.tau)
    width = int(SIZE[0] * zoom)
    height = int(SIZE[1] * zoom)
    fitted = image.resize((width, height), Image.Resampling.LANCZOS)
    x = int((width - SIZE[0]) / 2 + 8 * math.sin(phase * math.tau))
    y = int((height - SIZE[1]) / 2 + 5 * math.cos(phase * math.tau))
    return fitted.crop((x, y, x + SIZE[0], y + SIZE[1]))


def particle_seed(name):
    return sum(ord(char) for char in name) * 97


def draw_particles(image, frame_number, world, mode):
    overlay = Image.new("RGBA", SIZE)
    draw = ImageDraw.Draw(overlay)
    progress = frame_number / (FPS * DURATION)
    rng = random.Random(particle_seed(world))

    if mode in {"rain", "neon-rain", "rain-embers"}:
        color = (110, 190, 255, 100) if mode != "neon-rain" else (245, 60, 230, 115)
        for _ in range(80):
            x0 = rng.randrange(-100, SIZE[0] + 100)
            y0 = rng.randrange(-SIZE[1], SIZE[1])
            speed = rng.randrange(650, 1050)
            x = (x0 - progress * 190) % (SIZE[0] + 200) - 100
            y = (y0 + progress * speed) % (SIZE[1] + 100) - 50
            draw.line((x, y, x - 10, y + 32), fill=color, width=2)

    if mode == "snow":
        for _ in range(75):
            x0 = rng.randrange(SIZE[0])
            y0 = rng.randrange(SIZE[1])
            radius = rng.randrange(1, 5)
            x = (x0 + math.sin(progress * math.tau + y0) * 18) % SIZE[0]
            y = (y0 + progress * rng.randrange(90, 230)) % SIZE[1]
            draw.ellipse((x, y, x + radius, y + radius), fill=(225, 250, 255, 175))

    if mode == "petals":
        for _ in range(45):
            x0 = rng.randrange(SIZE[0])
            y0 = rng.randrange(SIZE[1])
            x = (x0 + progress * rng.randrange(90, 240)) % SIZE[0]
            y = (y0 + progress * rng.randrange(130, 300)) % SIZE[1]
            draw.ellipse((x, y, x + 8, y + 4), fill=(255, 125, 170, 170))

    if mode in {"speed", "steam"}:
        for _ in range(28):
            y = rng.randrange(220, 690)
            offset = (progress * rng.randrange(500, 1000) + rng.randrange(SIZE[0])) % SIZE[0]
            if mode == "speed":
                draw.line(
                    (SIZE[0] - offset, y, SIZE[0] - offset + rng.randrange(40, 130), y),
                    fill=(130, 235, 255, 125),
                    width=3,
                )
            else:
                x = rng.randrange(SIZE[0])
                vapor = Image.new("RGBA", SIZE)
                vd = ImageDraw.Draw(vapor)
                vd.ellipse(
                    (x - 80, y - 20 - progress * 80, x + 80, y + 35 - progress * 80),
                    fill=(245, 245, 255, 15),
                )
                overlay = Image.alpha_composite(
                    overlay, vapor.filter(ImageFilter.GaussianBlur(22))
                )
                draw = ImageDraw.Draw(overlay)

    if mode in {"fireflies", "rain-embers", "alarm"}:
        count = 38 if mode == "fireflies" else 24
        for _ in range(count):
            x = rng.randrange(SIZE[0])
            y = rng.randrange(180, SIZE[1])
            pulse = (math.sin(progress * math.tau * rng.uniform(1, 3) + x) + 1) / 2
            if mode == "fireflies":
                color = (255, 210, 70, int(55 + pulse * 180))
            else:
                color = (255, 70, 30, int(45 + pulse * 155))
            radius = rng.randrange(2, 6)
            draw.ellipse((x, y, x + radius, y + radius), fill=color)

    if mode == "alarm":
        alpha = int(18 + 40 * ((math.sin(progress * math.tau * 2) + 1) / 2))
        draw.rectangle((0, 0, SIZE[0], SIZE[1]), fill=(255, 18, 18, alpha))

    if mode == "neon-rain":
        sweep_x = int((progress * 1.4 % 1.0) * (SIZE[0] + 500) - 300)
        draw.polygon(
            [(sweep_x, 0), (sweep_x + 180, 0), (sweep_x - 120, SIZE[1]), (sweep_x - 300, SIZE[1])],
            fill=(245, 35, 230, 28),
        )

    return Image.alpha_composite(image.convert("RGBA"), overlay).convert("RGB")


def render_world(name, source, mode):
    image = Image.open(MEDIA / source).convert("RGB")
    scale = max(SIZE[0] / image.width, SIZE[1] / image.height)
    image = image.resize(
        (int(image.width * scale * 1.05), int(image.height * scale * 1.05)),
        Image.Resampling.LANCZOS,
    )
    output = LIVE / f"{name}-live.mp4"
    command = [
        "ffmpeg", "-y", "-loglevel", "error",
        "-f", "rawvideo", "-pix_fmt", "rgb24",
        "-s", f"{SIZE[0]}x{SIZE[1]}", "-r", str(FPS), "-i", "-",
        "-an", "-c:v", "libx264", "-preset", "medium", "-crf", "18",
        "-pix_fmt", "yuv420p", str(output),
    ]
    process = subprocess.Popen(command, stdin=subprocess.PIPE)
    for frame_number in range(FPS * DURATION):
        frame = cover_crop(image, frame_number)
        pulse = 0.985 + 0.025 * math.sin(frame_number / FPS * math.pi)
        frame = ImageEnhance.Brightness(frame).enhance(pulse)
        frame = draw_particles(frame, frame_number, name, mode)
        process.stdin.write(frame.tobytes())
    process.stdin.close()
    if process.wait() != 0:
        raise RuntimeError(f"ffmpeg failed for {name}")
    return output


def combine(outputs):
    concat = LIVE / "concat.txt"
    concat.write_text("".join(f"file '{path.resolve()}'\n" for path in outputs))
    combined = MEDIA / "petty-all-character-worlds-live.mp4"
    subprocess.run(
        [
            "ffmpeg", "-y", "-loglevel", "error", "-f", "concat", "-safe", "0",
            "-i", str(concat), "-c", "copy", str(combined),
        ],
        check=True,
    )
    gif = MEDIA / "petty-all-character-worlds-live.gif"
    subprocess.run(
        [
            "ffmpeg", "-y", "-loglevel", "error", "-i", str(combined),
            "-vf",
            "fps=6,scale=640:-1:flags=lanczos,split[s0][s1];"
            "[s0]palettegen=max_colors=96:stats_mode=diff[p];"
            "[s1][p]paletteuse=dither=bayer:bayer_scale=4:diff_mode=rectangle",
            "-loop", "0", str(gif),
        ],
        check=True,
    )
    concat.unlink()


def main():
    LIVE.mkdir(parents=True, exist_ok=True)
    outputs = [render_world(*world) for world in WORLDS]
    combine(outputs)


if __name__ == "__main__":
    main()
