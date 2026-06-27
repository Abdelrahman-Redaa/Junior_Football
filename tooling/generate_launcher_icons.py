#!/usr/bin/env python3
"""Generate Android and iOS launcher icons from the Junior Football mark."""

from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "assets" / "images"
ANDROID_RES = ROOT / "android" / "app" / "src" / "main" / "res"
IOS_APPICON = ROOT / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"

SOURCE = ASSETS / "splash_android_12.png"
GREEN = (31, 157, 69, 255)
WHITE = (255, 255, 255, 255)


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


def _extract_mark() -> Image.Image:
    img = Image.open(SOURCE).convert("RGBA")
    # The Android 12 splash contains mark + text. Keep only the top mark.
    mark_area = img.crop((0, 0, img.width, int(img.height * 0.58)))
    return mark_area.crop(_content_bbox(mark_area))


def _make_icon(mark: Image.Image, size: int) -> Image.Image:
    canvas = Image.new("RGBA", (size, size), WHITE)
    draw = ImageDraw.Draw(canvas)
    margin = max(2, int(size * 0.045))
    draw.rounded_rectangle(
        (margin, margin, size - margin, size - margin),
        radius=int(size * 0.22),
        outline=GREEN,
        width=max(1, int(size * 0.035)),
        fill=WHITE,
    )

    max_mark = int(size * 0.68)
    scale = min(max_mark / mark.width, max_mark / mark.height)
    resized = mark.resize(
        (int(mark.width * scale), int(mark.height * scale)),
        Image.Resampling.LANCZOS,
    )
    x = (size - resized.width) // 2
    y = (size - resized.height) // 2
    canvas.alpha_composite(resized, (x, y))
    return canvas.convert("RGB")


def _save(path: Path, image: Image.Image):
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path, optimize=True)


def build_android(mark: Image.Image):
    sizes = {
        "mipmap-mdpi": 48,
        "mipmap-hdpi": 72,
        "mipmap-xhdpi": 96,
        "mipmap-xxhdpi": 144,
        "mipmap-xxxhdpi": 192,
    }
    for folder, size in sizes.items():
        _save(ANDROID_RES / folder / "ic_launcher.png", _make_icon(mark, size))


def build_ios(mark: Image.Image):
    sizes = {
        "Icon-App-20x20@1x.png": 20,
        "Icon-App-20x20@2x.png": 40,
        "Icon-App-20x20@3x.png": 60,
        "Icon-App-29x29@1x.png": 29,
        "Icon-App-29x29@2x.png": 58,
        "Icon-App-29x29@3x.png": 87,
        "Icon-App-40x40@1x.png": 40,
        "Icon-App-40x40@2x.png": 80,
        "Icon-App-40x40@3x.png": 120,
        "Icon-App-60x60@2x.png": 120,
        "Icon-App-60x60@3x.png": 180,
        "Icon-App-76x76@1x.png": 76,
        "Icon-App-76x76@2x.png": 152,
        "Icon-App-83.5x83.5@2x.png": 167,
        "Icon-App-1024x1024@1x.png": 1024,
    }
    for filename, size in sizes.items():
        _save(IOS_APPICON / filename, _make_icon(mark, size))


if __name__ == "__main__":
    mark = _extract_mark()
    build_android(mark)
    build_ios(mark)
    print("Generated launcher icons.")
