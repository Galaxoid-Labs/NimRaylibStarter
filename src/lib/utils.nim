import nimraylib_now

# Get the unscaled display width
proc getDisplayWidth*(): int =
  if isWindowFullscreen():
    getMonitorWidth(getCurrentMonitor())
  else:
    getScreenWidth()

# Get the unscaled display height
proc getDisplayHeight*(): int =
  if isWindowFullscreen():
    getMonitorHeight(getCurrentMonitor())
  else:
    getScreenHeight()