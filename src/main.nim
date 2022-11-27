import nimraylib_now
import configs
import extras
import game

# IMPORTANT
# You should'nt have to change anything here for the most part
# Write you game logic in game.nim

var needsFullscreenToggle = false
proc getDisplayWidth(): int
proc getDisplayHeight(): int
proc tryToggleFullscreen(): void

when isMainModule:

  setConfigFlags(ConfigFlags.WINDOW_RESIZABLE or ConfigFlags.VSYNC_HINT)
  setTargetFPS(TargetFPS)
  initWindow(InitialWindowWidth, InitialWindowHeight, Title)
  setWindowMinSize(MinimumWindowWidth, MinimumWindowHeight)

  let target = loadRenderTexture(RenderWidth, RenderHeight)
  setTextureFilter(target.texture, TextureFitler)

  initExtras()

  start()

  while not windowShouldClose():

    if isKeyPressed(KeyboardKey.F):
      tryToggleFullscreen()
      
    if needsFullscreenToggle:
      toggleFullscreen()
      needsFullscreenToggle = false

    let scale: float = min(getDisplayWidth() / RenderWidth, getDisplayHeight() / RenderHeight)

    let mouseOffsetX: int = -(int)((getDisplayWidth() - (int)(RenderWidth * scale)) / 2)
    let mouseOffsetY: int = -(int)((getDisplayHeight() - (int)(RenderHeight * scale)) / 2)
    setMouseOffset(mouseOffsetX, mouseOffsetY)
    setMouseScale(1/scale, 1/scale)

    update(getFrameTime())

    beginTextureMode(target)
    draw()
    endTextureMode()

    beginDrawing()
    clearBackground(LetterBoxColor)

    let sourceRect: Rectangle = (0.0, 0.0, target.texture.width.toFloat, -target.texture.height.toFloat)
    let destY: float = (getDisplayWidth().toFloat - (RenderWidth.toFloat * scale)) * 0.5
    let destX: float = (getDisplayHeight().toFloat - (RenderHeight.toFloat * scale)) * 0.5
    let destRect: Rectangle = (destY, destX, RenderWidth.toFloat * scale, RenderHeight.toFloat * scale)
    drawTexturePro(target.texture, sourceRect, destRect, (0.0, 0.0), 0.0, Raywhite)

    when Debug:
      drawFPS(20, 20)

    setMouseOffset(0, 0)
    setMouseScale(1, 1) 
    drawUnscaled()
    endDrawing()

  closeWindow()

proc getDisplayWidth(): int =
  if isWindowFullscreen():
    getMonitorWidth(getCurrentMonitor())
  else:
    getScreenWidth()

proc getDisplayHeight(): int =
  if isWindowFullscreen():
    getMonitorHeight(getCurrentMonitor())
  else:
    getScreenHeight()

proc tryToggleFullscreen(): void =
  if not isWindowFullscreen():
    setWindowSize(getDisplayWidth(), getDisplayHeight())
    needsFullscreenToggle = true
  else:
    needsFullscreenToggle = false
    toggleFullscreen()
    setWindowSize(InitialWindowWidth, InitialWindowHeight)