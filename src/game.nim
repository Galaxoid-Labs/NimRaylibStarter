import nimraylib_now

# All consts below are required as they are used in main.nim 
# Edit them suit your needs
const
  debug* = true
  flags* = ConfigFlags.WINDOW_RESIZABLE or ConfigFlags.VSYNC_HINT
  windowWidth* = 1280
  windowHeight* = 720
  renderWidth* = 320 # Chose your render width resolution here. Usually windowWith / 2 or 4, etc
  renderHeight* = 180 # Chose your render height resolution here. Usually windowHeight / 2 or 4, etc
  minWindowWidth* = 320
  minWindowHeight* = 180
  targetFPS* = 60
  textureFitler* = TextureFilter.POINT
  title* = "Raylib Nim Starter"
  letterBoxColor* = Black
  clearScreenColor* = Darkgray

# Do game initialization here
proc start*(): void = discard

# Do game object updates here
proc update*(dt: cfloat): void = discard

# Do drawing here
proc draw*(): void =
  clearBackground(clearScreenColor)

# This function will draw using raygui. Important to understand this drawing
# doesnt scale with the render target size. It draws at the normal windowWidth/windowHeight
proc drawGUI*(): void = discard