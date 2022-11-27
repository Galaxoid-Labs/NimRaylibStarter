import nimraylib_now
import configs
import extras

var c: Color
var p: Vector2

# Do game initialization here
proc start*(): void = 
  c = randomPicoColor()
  p = randomPositionInRenderBounds()

# Do game object updates here
proc update*(dt: cfloat): void = discard

# Do drawing here
proc draw*(): void =
  clearBackground(ClearScreenColor)
  
# Important to understand this drawing
# doesnt scale with the render target size. It draws at the normal windowWidth/windowHeight
proc drawUnscaled*(): void = discard