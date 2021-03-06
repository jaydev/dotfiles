Mac Setup Instructions
========
- Create a new SSH key: https://help.github.com/articles/generating-ssh-keys/
- Homebrew
  * git
  * the_silver_searcher
  * fasd
  * emacs --with-cocoa (then `brew linkapps emacs`)
  * findutils --with-default-names
  * coreutils (follow instructions to use default names)
  * node
  * postgresql
  * python3
  * reattach-to-user-namespace (for prior to OS X Yosemite)
  * redis
  * tmux
  * tree
  * wget
  * curl
  * zsh
- Apps to download
  * Dropbox
  * 1Password
  * Divvy
  * Google Chrome
  * iTerm2
  * Karabiner (formerly KeyRemap4MacBook)
  * Spotify
  * Slack
- System Preferences settings
  * Swap control <--> caps lock and meta <--> option keys
  * Set bottom left and right corners to put the computer to sleep
  * Set screensaver
  * Enable tap with one finger to click (if no Force Touch trackpad)
  * Disable natural scroll direction
  * Turn on FileVault
- Keybindings
  * Enable Emacs keybindings and fast key repeat rate in Karabiner
  * Copy `karabiner/private.xml` to `/Applications/Karabiner.app/Contents/Resources/private.xml`
- iTerm Settings
  * Go to Preferences --> Profiles --> Keys --> change left and right option to send +Esc
  * Install Tomorrow Night Eighties theme from here: https://github.com/chriskempson/tomorrow-theme
- Clone this repo and run setup_env.sh

