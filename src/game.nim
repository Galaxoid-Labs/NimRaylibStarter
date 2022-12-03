import nimraylib_now
import lib/configs
import lib/extras

var tex: Texture2D
var welcome: cstring = "Hi! Welcome to the nim raylib starter!"

proc start*(): void = 
  ## Do game initialization here
  let texSeq = @[
    @[1, 0, 0, 0, 0, 0, 0, 1],
    @[1, 0, 1, 1, 1, 1, 0, 1],
    @[0, 1, 1, 1, 1, 1, 1, 0],
    @[0, 1, 1, 1, 1, 1, 1, 0],
    @[1, 1, 0, 1, 1, 0, 1, 1],
    @[1, 0, 0, 0, 0, 0, 0, 1],
    @[0, 0, 1, 1, 1, 1, 0, 0],
    @[1, 1, 1, 0, 0, 1, 1, 1],
  ]

  tex = getTextureForSeq(texSeq, 4)

proc update*(dt: cfloat): void = discard
  ## Do game object updates here


proc draw*(): void =
  ## Do drawing here
  ## 
  clearBackground(ClearScreenColor)
  drawTexture(tex, (int)getHalfRenderWidth() - (tex.width / 2), (int)getHalfRenderHeight()  - (tex.height / 2), PicoYellow)
  drawText(welcome, ((int)getHalfRenderWidth()) - ((int)measureText(welcome, 8) / 2), (int)getHalfRenderHeight() + 30, 8, PicoPink)

proc drawUnscaled*(): void = discard 
  ## Important to understand this drawing
  ## doesnt scale with the render target size.
  ## It draws at the normal WindowWidth/WindowHeight * DPI