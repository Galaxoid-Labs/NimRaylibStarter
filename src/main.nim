import nimraylib_now
import game

# IMPORTANT
# You should'nt have to change anything here for the most part
# Write you game logic in game.nim

when isMainModule:

  setConfigFlags(flags)
  setTargetFPS(targetFPS)
  initWindow(windowWidth, windowHeight, title)
  setWindowMinSize(minWindowWidth, minWindowHeight)

  let target = loadRenderTexture(renderWidth, renderHeight)
  setTextureFilter(target.texture, textureFitler)

  start()

  while not windowShouldClose():

    if isKeyPressed(KeyboardKey.F):
      toggleFullscreen()

    update(getFrameTime())

    beginTextureMode(target)
    draw()
    endTextureMode()

    beginDrawing()
    clearBackground(letterBoxColor)

    let scale: float = min(getScreenWidth() / renderWidth, getScreenHeight() / renderHeight)
    let sourceRect: Rectangle = (0.0, 0.0, target.texture.width.toFloat, -target.texture.height.toFloat)
    let destY: float = (getScreenWidth().toFloat - (renderWidth.toFloat * scale)) * 0.5
    let destX: float = (getScreenHeight().toFloat - (renderHeight.toFloat * scale)) * 0.5
    let destRect: Rectangle = (destY, destX, renderWidth.toFloat * scale, renderHeight.toFloat * scale)
    drawTexturePro(target.texture, sourceRect, destRect, (0.0, 0.0), 0.0, Raywhite)

    when debug:
      drawFPS(20, 20)
    
    drawGUI()
    endDrawing()

  closeWindow()