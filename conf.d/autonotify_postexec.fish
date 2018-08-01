function autonotify_postexec -e fish_postexec
  set -l cmd_stats $status (printf "%02d:%02d:%02d\n" (math $CMD_DURATION / 1000 / 60 / 60) (math $CMD_DURATION / 1000 / 60) (math $CMD_DURATION"/ 1000 % 6"))
  set current_app_name (
		osascript -e '
			global frontApp, frontAppName, windowTitle
			set windowTitle to ""
			tell application "System Events"
					set frontApp to first application process whose frontmost is true
					set frontAppName to name of frontApp
			end tell

			return {frontAppName} '
		)
  if [ $current_app_name != $autonotify_terminal_app_name ]
    echo 'display notification "exited with code '$cmd_stats[1]' after '$cmd_stats[2]'" with title "'$argv[1]' has completed"' | osascript
  end
end
