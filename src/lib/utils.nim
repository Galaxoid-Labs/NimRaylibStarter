import nimraylib_now

# Get the unscaled display width
proc getDisplayWidth*(): int =
  var width = getScreenWidth()
  if isWindowFullscreen():
    width = getMonitorWidth(getCurrentMonitor())
  return width * (int)getWindowScaleDPI().x

# Get the unscaled display height
proc getDisplayHeight*(): int =
  var height = getScreenHeight()
  if isWindowFullscreen():
    height = getMonitorHeight(getCurrentMonitor())
  return height * (int)getWindowScaleDPI().y