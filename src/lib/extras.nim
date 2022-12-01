import nimraylib_now
import random
import configs

const
  PicoDarkBlue*: Color = (29, 43, 83, 255)
  PicoDarkPurple*: Color = (126, 37, 83, 255)
  PicoDarkGreen*: Color = (0, 135, 81, 255)
  PicoDarkBrown*: Color = (171, 82, 54, 255)
  PicoDarkGray*: Color = (95, 87, 79, 255) 
  PicoLightGray*: Color = (194, 195, 199, 255)
  PicoWhite*: Color = (255, 241, 232, 255)
  PicoRed*: Color = (255, 0, 77, 255)
  PicoOrange*: Color = (255, 163, 0, 255)
  PicoYellow*: Color = (255, 236, 39, 255)
  PicoGreen*: Color = (0, 228, 54, 255)
  PicoBlue*: Color = (41, 173, 255, 255)
  PicoLavender*: Color = (131, 118, 156, 255)
  PicoPink*: Color = (255, 119, 168, 255)
  PicoPeach*: Color = (255, 204, 170, 255)
  PicoBlack*: Color = (16, 16, 16, 255)

const picoColors = [PicoDarkBlue, PicoDarkPurple, PicoDarkGreen, PicoDarkBrown, 
                    PicoDarkGray, PicoLightGray, PicoWhite, PicoRed, PicoOrange, 
                    PicoYellow, PicoGreen, PicoBlue, PicoLavender, PicoPink, PicoPeach, PicoBlack
]

type
  PixelObject* = object
    pixels*: seq[seq[Color]]
    pixelSize*: int
    pos*: Vector2
    origin*: Vector2

proc draw*(self: PixelObject): void =
  for i in countup(0, self.pixels.len-1, 1):
    for j in countup(0, self.pixels[0].len-1, 1):
      let ox = (float)(self.pixels[0].len * self.pixelSize) * self.origin.x
      let x = (self.pos.x - ox) + (float)(j * self.pixelSize)
      let oy = (float)(self.pixels.len * self.pixelSize) * self.origin.y
      let y = (self.pos.y - oy) + (float)(i * self.pixelSize)
      let color = self.pixels[i][j]
      drawRectangle((cint)x, (cint)y, self.pixelSize, self.pixelSize, color)

proc initExtras*(): void =
  randomize()

proc getRandomPicoColor*(): Color =
  ## Returns a random color from the Pico Pallete
  picoColors[rand(0 .. 15)]

proc getRandomVectorInRenderBounds*(): Vector2 =
  ## Returns a random Vector2 within bounds of the scaled
  ## rendering rect
  (rand(0.0 .. (float)RenderWidth), rand(0.0 .. (float)RenderHeight))

proc getTextureForSeq*(colorSeq: seq[seq[Color]], pixelSize: int): Texture2D =
  ## Takes a 2d seq of Color and returns a Texture2d
  ## pixelSize determines the size of each color in the seq
  var image: Image = genImageColor(colorSeq[0].len * pixelSize, colorSeq.len * pixelSize, Blank)
  var imagePtr = image.addr

  for i in countup(0, colorSeq.len-1, 1):
    for j in countup(0, colorSeq[0].len-1, 1):
      let x = j * pixelSize
      let y = i * pixelSize
      let color = colorSeq[i][j]
      imageDrawRectangle(imagePtr, x, y, pixelSize, pixelSize, color)

  let texture = loadTextureFromImage(image)
  unloadImage(image)
  texture

proc getTextureForSeq*(intSeq: seq[seq[int]], pixelSize: int): Texture2D =
  ## Takes a 2d seq of int (0 or 1) and returns a White Texture2d
  ## pixelSize determines the size of each color in the seq
  var image: Image = genImageColor(intSeq[0].len * pixelSize, intSeq.len * pixelSize, Blank)
  var imagePtr = image.addr

  for i in countup(0, intSeq.len-1, 1):
    for j in countup(0, intSeq[0].len-1, 1):
      let x = j * pixelSize
      let y = i * pixelSize
      let color = (if intSeq[i][j] == 0: Blank else: White)
      imageDrawRectangle(imagePtr, x, y, pixelSize, pixelSize, color)

  let texture = loadTextureFromImage(image)
  unloadImage(image)
  texture
