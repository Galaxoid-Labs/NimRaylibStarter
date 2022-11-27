import nimraylib_now

# All consts below are required as they are used in main.nim 
# Edit them suit your needs
const
  Debug* = true
  InitialWindowWidth* = 1280
  InitialWindowHeight* = 720
  RenderWidth* = 320 # Chose your render width resolution here. Usually windowWith / 2 or 4, etc
  RenderHeight* = 180 # Chose your render height resolution here. Usually windowHeight / 2 or 4, etc
  MinimumWindowWidth* = 320
  MinimumWindowHeight* = 180
  TargetFPS* = 60
  TextureFitler* = TextureFilter.POINT
  Title* = "Raylib Nim Starter"
  LetterBoxColor* = Black
  ClearScreenColor* = (16, 16, 16, 255)