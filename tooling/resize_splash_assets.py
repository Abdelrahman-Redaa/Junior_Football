#!/usr/bin/env python3
"""Build native splash assets with a smaller logo and attached branding."""

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "assets" / "images"
FONTS = ROOT / "assets" / "fonts"

SOURCE = ASSETS / "splash_android_12.png"
PORTRAIT_OUT = ASSETS / "splash_ios_android_11.png"
ANDROID_12_OUT = ASSETS / "splash_android_12.png"

GREEN = (31, 157, 69)
INK = (28, 28, 30)
MUTED = (86, 86, 92)
WHITE = (255, 255, 255)


def _content_bbox(img: Image.Image, threshold: int = 245):
    rgb = img.convert("RGB")
    pixels = rgb.load()
    w, h = rgb.size
    min_x, min_y = w, h
    max_x, max_y = 0, 0
    found = False

    for y in range(h):
        for x in range(w):
            r, g, b = pixels[x, y]
            if r < threshold or g < threshold or b < threshold:
                found = True
                min_x = min(min_x, x)
                min_y = min(min_y, y)
                max_x = max(max_x, x)
                max_y = max(max_y, y)

    if not found:
        return (0, 0, w, h)
    return (min_x, min_y, max_x + 1, max_y + 1)


def _extract_logo() -> Image.Image:
    img = Image.open(SOURCE).convert("RGBA")
    # The source contains logo + text. The top part is the mark only.
    logo_area = img.crop((0, 0, img.width, int(img.height * 0.68)))
    cropped = logo_area.crop(_content_bbox(logo_area))
    return cropped


def _fit(image: Image.Image, max_w: int, max_h: int) -> Image.Image:
    scale = min(max_w / image.width, max_h / image.height)
    size = (int(image.width * scale), int(image.height * scale))
    return image.resize(size, Image.Resampling.LANCZOS)


def _font(name: str, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(str(FONTS / name), size)


def _center_text(draw: ImageDraw.ImageDraw, text: str, font: ImageFont.FreeTypeFont, y: int, color):
    bbox = draw.textbbox((0, 0), text, font=font)
    x = (draw.im.size[0] - (bbox[2] - bbox[0])) // 2
    draw.text((x, y), text, font=font, fill=color)
    return y + (bbox[3] - bbox[1])


def build_android_12_icon(logo: Image.Image):
    canvas = Image.new("RGBA", (1152, 1152), (255, 255, 255, 0))
    fitted = _fit(logo, 330, 330)
    x = (canvas.width - fitted.width) // 2
    y = 310
    canvas.alpha_composite(fitted, (x, y))

    draw = ImageDraw.Draw(canvas)
    text_y = y + fitted.height + 34
    text_y = _center_text(
        draw,
        "Junior Football",
        _font("Nunito-SemiBold.ttf", 72),
        text_y,
        INK,
    )
    text_y += 20
    _center_text(
        draw,
        "Analyze, Train, get scouted",
        _font("Nunito-Medium.ttf", 40),
        text_y,
        MUTED,
    )
    canvas.save(ANDROID_12_OUT, optimize=True)


def build_portrait(logo: Image.Image):
    canvas = Image.new("RGB", (1179, 2556), WHITE)
    fitted = _fit(logo, 300, 300)
    block_h = fitted.height + 22 + 78 + 12 + 42
    start_y = (canvas.height - block_h) // 2 - 25
    x = (canvas.width - fitted.width) // 2
    canvas.paste(fitted.convert("RGB"), (x, start_y), fitted)

    draw = ImageDraw.Draw(canvas)
    y = start_y + fitted.height + 22
    y = _center_text(draw, "Junior Football", _font("Nunito-SemiBold.ttf", 70), y, INK)
    y += 12
    _center_text(draw, "Analyze, Train, get scouted", _font("Nunito-Medium.ttf", 38), y, MUTED)
    canvas.save(PORTRAIT_OUT, optimize=True)


if __name__ == "__main__":
    logo = _extract_logo()
    build_android_12_icon(logo)
    build_portrait(logo)
    print("Rebuilt native splash assets.")
