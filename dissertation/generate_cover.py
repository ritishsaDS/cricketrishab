#!/usr/bin/env python3
"""Regenerate the M.Pharm dissertation cover with the DDM College of Pharmacy logo."""
import pymupdf
from PIL import Image
from pathlib import Path

ROOT = Path(__file__).resolve().parent
OUT = ROOT / "mpharm_dissertation_cover.pdf"
HPTU = ROOT / "hptu_logo.jpeg"
DDM = ROOT / "ddm_college_of_pharmacy_logo.jpg"

W, H = 595.2756, 841.8898
C_TITLE = (0x22 / 255, 0x22 / 255, 0x22 / 255)
C_BODY = (0x25 / 255, 0x25 / 255, 0x25 / 255)
C_DOTS = (0x55 / 255, 0x55 / 255, 0x55 / 255)


def center_text(page, y, text, fontsize, color=C_TITLE, bold=False):
    fn = "hebo" if bold else "helv"
    tw = pymupdf.get_text_length(text, fontname=fn, fontsize=fontsize)
    page.insert_text(((W - tw) / 2, y), text, fontname=fn, fontsize=fontsize, color=color)


def main():
    doc = pymupdf.open()
    page = doc.new_page(width=W, height=H)

    # Title
    center_text(page, 64.5, "Formulation, Optimization, and Evaluation of", 13.2, bold=True)
    center_text(page, 81.5, "Canagliflozin Nanosuspension-Loaded", 13.2, bold=True)
    center_text(page, 98.5, "Immediate-Release Pellets", 13.2, bold=True)

    center_text(
        page,
        126.0,
        "A dissertation submitted to Himachal Pradesh Technical University, Hamirpur in the partial",
        11.2,
        color=C_BODY,
    )
    center_text(page, 141.2, "fulfilment of the requirement for the degree of", 11.2, color=C_BODY)

    hptu_size = 150.0
    hptu_x0 = (W - hptu_size) / 2
    page.insert_image(
        pymupdf.Rect(hptu_x0, 158.0, hptu_x0 + hptu_size, 158.0 + hptu_size),
        filename=str(HPTU),
    )

    y = 328.0
    center_text(page, y, "MASTER OF PHARMACY", 11.5, bold=True)
    center_text(page, y + 26, "IN", 11.0)
    center_text(page, y + 49.5, "PHARMACEUTICS", 11.5, bold=True)
    center_text(page, y + 80.5, "Submitted By:", 11.0)
    center_text(page, y + 104.5, "Nishant", 11.5, bold=True)
    center_text(page, y + 126.0, "2512718006", 11.5, bold=True)
    center_text(page, y + 153.5, "2025-2027", 11.5, bold=True)
    center_text(page, y + 183.5, "Under the Supervision of", 11.0)

    page.insert_text((162.0, y + 207.5), "Supervisor", fontname="helv", fontsize=10.5, color=C_TITLE)
    page.insert_text((374.6, y + 207.5), "Co-Supervisor", fontname="helv", fontsize=10.5, color=C_TITLE)

    dots = "........................................"
    for x in (137.0, 358.1):
        page.insert_text((x, 555.0), dots, fontname="helv", fontsize=9.0, color=C_DOTS)
        page.insert_text((x, 570.0), dots, fontname="helv", fontsize=9.0, color=C_DOTS)

    ddm = Image.open(DDM)
    dlw, dlh = ddm.size
    target_w = 300.0
    target_h = target_w * (dlh / dlw)
    logo_y0 = 588.0
    logo_x0 = (W - target_w) / 2
    page.insert_image(
        pymupdf.Rect(logo_x0, logo_y0, logo_x0 + target_w, logo_y0 + target_h),
        filename=str(DDM),
    )

    addr_y = logo_y0 + target_h + 16
    center_text(page, addr_y, "Pharmaceutics", 10.5)
    center_text(
        page,
        addr_y + 22,
        "DDM College of Pharmacy Gondpur Banehra (Upper) Tehsil Ghanari",
        10.5,
        bold=True,
    )

    doc.save(OUT, garbage=4, deflate=True)
    doc.close()
    print(f"Wrote {OUT}")


if __name__ == "__main__":
    main()
