set -g autonotify_terminal_app_name (
  osascript -e '
    global frontApp, frontAppName, windowTitle
    set windowTitle to ""
    tell application "System Events"
        set frontApp to first application process whose frontmost is true
        set frontAppName to name of frontApp
    end tell

    return {frontAppName} '
  )
