import math
import sys
from PIL import Image, ImageChops, ImageDraw, ImageFilter

S = 256
SS = 4
W = S * SS

BG_TOP = (48, 48, 49)
BG_BOT = (25, 25, 26)
BORDER = (16, 16, 17)
GLOW = (46, 38, 22)

SAND_TOP = (244, 228, 192)
SAND_BOT = (206, 182, 138)
SAND_LO = (170, 146, 104)
SAND_HI = (255, 246, 220)
SAND_LINE = (74, 58, 34)

STONE = (128, 128, 130)
STONE_HI = (172, 172, 175)
STONE_LO = (84, 84, 88)
STONE_LINE = (34, 34, 37)

CONCRETE_TOP = (214, 214, 210)
CONCRETE_LEFT = (176, 176, 172)
CONCRETE_RIGHT = (128, 128, 126)
CONCRETE_LINE = (44, 44, 44)

GLASS_TOP = (196, 240, 230)
GLASS_BOT = (112, 190, 184)
GLASS_HI = (240, 255, 250)
GLASS_LINE = (24, 78, 78)


def sc(v):
    return int(round(v * SS))


def poly(pts):
    return [(sc(x), sc(y)) for x, y in pts]


def vgrad(size, top, bottom):
    strip = Image.new("RGB", (1, size[1]))
    px = strip.load()
    for y in range(size[1]):
        t = y / (size[1] - 1)
        px[0, y] = tuple(int(top[i] + (bottom[i] - top[i]) * t) for i in range(3))
    return strip.resize(size, Image.BILINEAR)


def shape_mask(pts):
    mask = Image.new("L", (W, W), 0)
    ImageDraw.Draw(mask).polygon(pts, fill=255)
    return mask


def fill_grad(img, pts, top, bottom):
    mask = shape_mask(pts)
    bb = mask.getbbox()
    grad = Image.new("RGB", img.size, bottom)
    grad.paste(vgrad((bb[2] - bb[0], bb[3] - bb[1]), top, bottom), (bb[0], bb[1]))
    img.paste(grad, (0, 0), mask)


img = vgrad((W, W), BG_TOP, BG_BOT)

glow = Image.new("RGB", (W, W), (0, 0, 0))
ImageDraw.Draw(glow).ellipse([sc(68), sc(40), sc(188), sc(150)], fill=GLOW)
img = ImageChops.add(img, glow.filter(ImageFilter.GaussianBlur(sc(30))))

CX, HALF, BASE, HEIGHT, DEPTH, STEPS = 128, 98, 156, 116, 12, 120
pile = []
for i in range(STEPS + 1):
    u = -1 + 2 * i / STEPS
    pile.append((CX + HALF * u, BASE - HEIGHT * (0.5 + 0.5 * math.cos(math.pi * u)) ** 0.85))
for i in range(1, STEPS):
    a = math.pi * i / STEPS
    pile.append((CX + HALF * math.cos(a), BASE + DEPTH * math.sin(a)))
pile = poly(pile)

fill_grad(img, pile, SAND_TOP, SAND_BOT)
pile_mask = shape_mask(pile)

shade = shape_mask(poly([(130, 30), (148, 80), (140, 124), (156, 180), (240, 180), (240, 30)]))
img.paste(SAND_LO, (0, 0), ImageChops.multiply(shade, pile_mask))

sheen = Image.new("L", (W, W), 0)
ImageDraw.Draw(sheen).ellipse([sc(92), sc(58), sc(122), sc(112)], fill=210)
sheen = sheen.filter(ImageFilter.GaussianBlur(sc(7)))
img.paste(SAND_HI, (0, 0), ImageChops.multiply(sheen, pile_mask))

d = ImageDraw.Draw(img)
for gx, gy, gr, color in (
    (84, 132, 3.2, SAND_LO), (108, 148, 2.8, SAND_LO), (70, 152, 2.6, SAND_LO),
    (124, 122, 2.6, SAND_LO), (100, 104, 2.4, SAND_LO),
    (166, 138, 3.0, SAND_TOP), (184, 154, 2.6, SAND_TOP), (154, 110, 2.4, SAND_TOP),
    (150, 158, 2.8, SAND_TOP),
):
    d.ellipse([sc(gx - gr), sc(gy - gr), sc(gx + gr), sc(gy + gr)], fill=color)
d.line(pile + [pile[0]], fill=SAND_LINE, width=sc(3), joint="curve")

stone = [(34, 236), (28, 212), (50, 192), (80, 196), (94, 218), (82, 238)]
stone_hi = [(28, 212), (50, 192), (80, 196), (60, 210), (38, 214)]
stone_lo = [(80, 196), (94, 218), (82, 238), (60, 210)]
d.polygon(poly(stone), fill=STONE)
d.polygon(poly(stone_hi), fill=STONE_HI)
d.polygon(poly(stone_lo), fill=STONE_LO)
d.polygon(poly(stone), outline=STONE_LINE, width=sc(3))

block_top = [(128, 188), (156, 200), (128, 212), (100, 200)]
block_left = [(100, 200), (128, 212), (128, 240), (100, 228)]
block_right = [(128, 212), (156, 200), (156, 228), (128, 240)]
d.polygon(poly(block_top), fill=CONCRETE_TOP)
d.polygon(poly(block_left), fill=CONCRETE_LEFT)
d.polygon(poly(block_right), fill=CONCRETE_RIGHT)
for face in (block_top, block_left, block_right):
    d.polygon(poly(face), outline=CONCRETE_LINE, width=sc(2))
d.polygon(
    poly([(128, 188), (156, 200), (156, 228), (128, 240), (100, 228), (100, 200)]),
    outline=CONCRETE_LINE, width=sc(3),
)

pane = poly([(174, 198), (222, 188), (222, 232), (174, 242)])
fill_grad(img, pane, GLASS_TOP, GLASS_BOT)
streaks = shape_mask(poly([(182, 236), (204, 194), (212, 192), (190, 234)]))
ImageDraw.Draw(streaks).polygon(poly([(198, 232), (216, 198), (219, 197), (201, 231)]), fill=255)
img.paste(GLASS_HI, (0, 0), ImageChops.multiply(streaks, shape_mask(pane)))
d.polygon(pane, outline=GLASS_LINE, width=sc(3))

d.rectangle([sc(4), sc(4), sc(S - 5), sc(S - 5)], outline=BORDER, width=sc(2))

img.resize((S, S), Image.LANCZOS).save(sys.argv[1], "PNG", optimize=True)
