import nimraylib_now
import random
import std/sequtils
import std/sugar
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
  SimpleSprite* = object
    ## Provides a simple sprite object with texture, color, position
    ## anchor point and rotation
    tex*: Texture2D
    color*: Color
    pos*: Vector2
    anchor*: Vector2
    rot*: float

proc getOrigin*(self: SimpleSprite): Vector2 =
  # Used to get the pivot point of the SimpleSprite
  let xanchor = (float)self.anchor.x
  let yanchor = (float)self.anchor.y
  let texWidth = (float)self.tex.width
  let texHeight = (float)self.tex.height
  (texWidth * xanchor, texHeight * yanchor)

proc getRect*(self: SimpleSprite): Rectangle =
  # Bounding rect for the sprite. This could be used for collision checking
  let origin = self.getOrigin()
  let x = (float)self.pos.x - origin.x
  let y = (float)self.pos.y - origin.y
  (x, y, (float)self.tex.width, (float)self.tex.height)

proc draw*(self: SimpleSprite): void =
  # Draws SimpleSprite taking into account anchors and color
  let sourceRect: Rectangle = (0.0, 0.0, (float)self.tex.width, (float)self.tex.height)
  let destRect: Rectangle = ((float)self.pos.x, (float)self.pos.y, (float)self.tex.width, (float)self.tex.height)
  drawTexturePro(self.tex, sourceRect, destRect, self.getOrigin(), self.rot, self.color)

type
  PixelObject* = object
    ## Provides a rudimentary Pixel Object where each pixel is drawn seperately.
    ## Use sparingly as drawing these are costly.
    ## No rotation is provided at this time.
    pixels*: seq[seq[Color]]
    pixelSize*: int
    pos*: Vector2
    anchor*: Vector2

proc draw*(self: PixelObject): void =
  ## Draws the PixelObject by assembling rects for every Color item in the seq
  ## This is costly. Use these objects sparingly.
  for i in countup(0, self.pixels.len-1, 1):
    for j in countup(0, self.pixels[0].len-1, 1):
      let ox = (float)(self.pixels[0].len * self.pixelSize) * self.anchor.x
      let x = (self.pos.x - ox) + (float)(j * self.pixelSize)
      let oy = (float)(self.pixels.len * self.pixelSize) * self.anchor.y
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

proc intSeqToColorSeq*(intSeq: seq[seq[int]], fillColor: Color = White): seq[seq[Color]] =
  ## Takes an int seq and converts it to color specified
  var colorSeq: seq[seq[Color]]
  for i in countup(0, intSeq.len-1):
    colorSeq.add(intSeq[i].map(x => (if x == 0: Blank else: fillColor)))
  return colorSeq

proc colorSeqToIntSeq*(colorSeq: seq[seq[Color]]): seq[seq[int]] =
  ## Takes an int seq and converts it to a color seq of White
  var intSeq: seq[seq[int]]
  for i in countup(0, colorSeq.len-1):
    intSeq.add(colorSeq[i].map(x => (if x == Blank: 0 else: 1)))
  return intSeq

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

proc getTextureForSeq*(intSeq: seq[seq[int]], pixelSize: int = 2): Texture2D =
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

proc getRandomSeqH*(width: int, height: int, density: int = 2): seq[seq[int]] =
  ## Returns horizontally mirroed random 2d seq used for creating a Texture2D
  ## Density referes to amount of whitespace. Lower the number more solid seq
  ## See proc getRandomTextureH
  var width = width
  var height = height
  if (width mod 2) != 0: width += 1
  if (height mod 2) != 0: height += 1
  let halfWidth = (int)width/2

  var res: seq[seq[int]]

  for i in 0..height-1:
    var row = toSeq(0..halfWidth-1).map(x => (if rand(density) == density: 1 else: 0))
    for j in countdown(row.len-1, 0):
      row.add(row[j])
    res.add(row)

  return res

proc getRandomTextureH*(width: int, height: int, pixelSize: int = 2, density: int = 2): Texture2D =
  getTextureForSeq(getRandomSeqH(width, height, density), pixelSize)

proc getRandomSeqV*(width: int, height: int, density: int = 2): seq[seq[int]] =
  ## Returns vertically mirroed random 2d seq used for creating a Texture2D
  ## Density referes to amount of whitespace. Lower the number more solid seq
  ## See proc getRandomTextureV
  var width = width
  var height = height
  if (width mod 2) != 0: width += 1
  if (height mod 2) != 0: height += 1
  let halfHeight = (int)height/2

  var res: seq[seq[int]]

  for i in 0..halfHeight-1:
    res.add(toSeq(0..width-1).map(x => (if rand(density) == density: 1 else: 0)))

  for i in countdown(halfHeight-1, 0):
    res.add(res[i])

  return res

proc getRandomTextureV*(width: int, height: int, pixelSize: int = 2, density: int = 2): Texture2D =
  getTextureForSeq(getRandomSeqV(width, height, density), pixelSize)

proc getRandomSeq*(width: int, height: int, density: int = 2): seq[seq[int]] =
  ## Returns vertically and horizontally mirroed random 2d seq used for creating a Texture2D
  ## Density referes to amount of whitespace. Lower the number more solid seq
  ## See proc getRandomTexture
  var width = width
  var height = height
  if (width mod 2) != 0: width += 1
  if (height mod 2) != 0: height += 1
  let halfWidth = (int)width/2
  let halfHeight = (int)width/2

  var res: seq[seq[int]]

  for i in 0..halfHeight-1:
    var row = toSeq(0..halfWidth-1).map(x => (if rand(density) == density: 1 else: 0))
    for j in countdown(row.len-1, 0):
      row.add(row[j])
    res.add(row)

  for i in countdown(halfHeight-1, 0):
    res.add(res[i])

  return res

proc getRandomTexture*(width: int, height: int, pixelSize: int = 2, density: int = 2): Texture2D =
  getTextureForSeq(getRandomSeq(width, height, density), pixelSize)