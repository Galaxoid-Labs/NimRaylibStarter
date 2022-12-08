import nimraylib_now

# Get the unscaled display width
proc getDisplayWidth*(withDPI: bool = true): int =
  var width = getScreenWidth()
  if isWindowFullscreen():
    width = getMonitorWidth(getCurrentMonitor())
  if withDPI:
    return width * (int)getWindowScaleDPI().x
  return width

# Get the unscaled display height
proc getDisplayHeight*(withDPI: bool = true): int =
  var height = getScreenHeight()
  if isWindowFullscreen():
    height = getMonitorHeight(getCurrentMonitor())
  if withDPI:
    return height * (int)getWindowScaleDPI().y
  return height
