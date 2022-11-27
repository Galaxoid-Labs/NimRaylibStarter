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

const picoColors = [PicoDarkBlue, PicoDarkPurple, PicoDarkGreen, PicoDarkBrown, PicoDarkGray, PicoLightGray,
  PicoWhite, PicoRed, PicoOrange, PicoYellow, PicoGreen, PicoBlue, PicoLavender, PicoPink, PicoPeach, PicoBlack
]

proc initExtras*(): void =
  randomize()

proc randomPicoColor*(): Color =
  picoColors[rand(0 .. 15)]

proc randomPositionInRenderBounds*(): Vector2 =
  (rand(0.0 .. (float)RenderWidth), rand(0.0 .. (float)RenderHeight))