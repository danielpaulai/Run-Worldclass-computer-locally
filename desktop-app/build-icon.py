#!/usr/bin/env python3
"""
Generate the Purely Personal app icon at all sizes needed by electron-builder.

Produces:
  desktop-app/build/icon.png          (1024x1024 — used by electron-builder as source)
  desktop-app/build/icon.icns         (macOS)
  desktop-app/build/icon.ico          (Windows)

Design:
  Rounded cream square with a stylized lowercase "pp" in serif italic,
  in Purely Personal coral (#c15f3c). The lowercase 'pp' matches the
  in-app brand mark so the icon and window stay visually coherent.

Usage:
    python3 build-icon.py
"""
import os
import shutil
import subprocess
import sys
from pathlib import Path

try:
    from PIL import Image, ImageDraw, ImageFont
except ImportError:
    sys.exit("Pillow is required:  pip3 install --user pillow")

HERE = Path(__file__).parent.resolve()
BUILD_DIR = HERE / "build"
BUILD_DIR.mkdir(exist_ok=True)

CORAL = (193, 95, 60, 255)       # --coral
CORAL_DARK = (138, 61, 33, 255)  # --coral-deep
CREAM = (250, 247, 242, 255)     # --cream
INK = (26, 26, 26, 255)          # --ink

# Try a clean serif; fall back sensibly if missing
CANDIDATE_FONTS = [
    "/System/Library/Fonts/Supplemental/Charter.ttc",
    "/System/Library/Fonts/Times.ttc",
    "/System/Library/Fonts/Supplemental/Georgia.ttf",
    "/System/Library/Fonts/Supplemental/Palatino.ttc",
]

def find_font(size):
    for p in CANDIDATE_FONTS:
        if os.path.exists(p):
            try:
                return ImageFont.truetype(p, size)
            except Exception:
                continue
    return ImageFont.load_default()


def make_icon(size: int) -> Image.Image:
    """Render a single icon at the given square size."""
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    # Rounded square background — coral, rounded ~20%
    corner = int(size * 0.22)
    d.rounded_rectangle([(0, 0), (size - 1, size - 1)], radius=corner, fill=CORAL)

    # Very subtle top highlight to give the flat fill some depth
    highlight = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    hd = ImageDraw.Draw(highlight)
    hd.rounded_rectangle(
        [(0, 0), (size - 1, int(size * 0.5))],
        radius=corner,
        fill=(255, 255, 255, 22),
    )
    img = Image.alpha_composite(img, highlight)
    d = ImageDraw.Draw(img)

    # The "pp" mark, italic serif, cream on coral
    # Font size roughly 62% of icon size — fills nicely
    text = "pp"
    font_size = int(size * 0.62)
    font = find_font(font_size)

    # Measure text bounding box to center precisely (anchor="mm" requires Pillow 9+)
    try:
        d.text(
            (size / 2, size / 2 + size * 0.02),
            text,
            fill=CREAM,
            font=font,
            anchor="mm",
        )
    except TypeError:
        # Older Pillow fallback — measure and position manually
        bbox = d.textbbox((0, 0), text, font=font)
        tw = bbox[2] - bbox[0]
        th = bbox[3] - bbox[1]
        d.text(
            ((size - tw) / 2 - bbox[0], (size - th) / 2 - bbox[1] + size * 0.02),
            text,
            fill=CREAM,
            font=font,
        )

    return img


def main():
    # ---- Mac: generate iconset then use iconutil to build .icns ----
    iconset = BUILD_DIR / "icon.iconset"
    if iconset.exists():
        shutil.rmtree(iconset)
    iconset.mkdir()

    # Required sizes for macOS iconset (with @2x retina variants)
    pairs = [
        (16, 1), (16, 2),
        (32, 1), (32, 2),
        (128, 1), (128, 2),
        (256, 1), (256, 2),
        (512, 1), (512, 2),
    ]

    for base, scale in pairs:
        real = base * scale
        img = make_icon(real)
        name = f"icon_{base}x{base}{'@2x' if scale == 2 else ''}.png"
        img.save(iconset / name, "PNG")

    # 1024 master (used as electron-builder source if .icns fails on other OS)
    master_png = BUILD_DIR / "icon.png"
    make_icon(1024).save(master_png, "PNG")

    # Build the .icns
    icns = BUILD_DIR / "icon.icns"
    if icns.exists():
        icns.unlink()
    result = subprocess.run(
        ["iconutil", "-c", "icns", str(iconset), "-o", str(icns)],
        capture_output=True, text=True,
    )
    if result.returncode != 0:
        sys.exit(f"iconutil failed: {result.stderr}")

    # ---- Windows .ico: multi-size bundle via Pillow ----
    ico_path = BUILD_DIR / "icon.ico"
    ico_sizes = [16, 32, 48, 64, 128, 256]
    imgs = [make_icon(s) for s in ico_sizes]
    imgs[-1].save(
        ico_path,
        format="ICO",
        sizes=[(s, s) for s in ico_sizes],
        append_images=imgs[:-1],
    )

    print(f"Wrote:")
    print(f"  {master_png}          ({master_png.stat().st_size // 1024} KB)")
    print(f"  {icns}         ({icns.stat().st_size // 1024} KB)")
    print(f"  {ico_path}          ({ico_path.stat().st_size // 1024} KB)")
    print("\nNext: rebuild the app and electron-builder will pick these up automatically.")


if __name__ == "__main__":
    main()
