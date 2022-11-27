import nimraylib_now
import lib/configs
import lib/extras

# Do game initialization here
proc start*(): void = discard

# Do game object updates here
proc update*(dt: cfloat): void = discard

# Do drawing here
proc draw*(): void =
  clearBackground(ClearScreenColor)

# Important to understand this drawing
# doesnt scale with the render target size.
# It draws at the normal WindowWidth/WindowHeight
proc drawUnscaled*(): void = discard