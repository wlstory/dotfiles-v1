#!/bin/bash

# Configure Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Configure Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Configure Passwords
defaults write com.apple.keychainaccess ShowKeychainStatusInMenuBar -bool true


# Configure Internet Accounts
defaults write com.apple.systempreferences EnableBundles -bool true

# Configure Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 36

# Remove apps from the dock
dock_apps_to_remove=(
    "/Applications/Maps.app"
    "/Applications/Calendar.app"
    "/Applications/Contacts.app"
    "/Applications/Notes.app"
    "/Applications/Freeform.app"
)
for app_to_remove in "${dock_apps_to_remove[@]}"; do
    if [ -d "$app_to_remove" ]; then
        defaults write com.apple.dock persistent-apps -array-remove "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app_to_remove</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    fi
done

# Restart Dock
killall Dock

# Add apps to the dock
dock_apps_to_add=(
    "/Applications/Fantastical.app"
    "/Applications/Evernote.app"
    "/Applications/Google Chrome.app"
    "/Applications/Microsoft Edge.app"
    "/Applications/Microsoft Excel.app"
    "/Applications/Microsoft PowerPoint.app"
    "/Applications/Microsoft Word.app"
    "/Applications/Microsoft Teams.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/Spotify.app"
)
for app_to_add in "${dock_apps_to_add[@]}"; do
    if [ -d "$app_to_add" ]; then
        defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app_to_add</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    fi
done

# Restart Dock
killall Dock

# Add Applications folder to the dock
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>"

# Restart Dock
killall Dock

# Hot Corners - https://dev.to/darrinndeal/setting-mac-hot-corners-in-the-terminal-3de
echo "♨️  Setting Hot Corners"
defaults write com.apple.dock wvous-tl-corner -int 3 # Top Right    - Show Application Windows
defaults write com.apple.dock wvous-tr-corner -int 2 # Top Right    - Mission Control
defaults write com.apple.dock wvous-bl-corner -int 4 # Bottom Left  - Desktop
defaults write com.apple.dock wvous-br-corner -int 5 # Bottom Right - Start Screen Saver

# Restart Finder and Dock
killall Finder
killall Dock
