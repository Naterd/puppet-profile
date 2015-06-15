#!/bin/bash
# Last modified June 15, 2015 - Burlison

# When performing a search, search the current folder by default
/usr/bin/defaults write com.apple.finder FX/usr/bin/defaultsearchScope -string "SCcf"

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes (icon, list, columns, coverflow): `icnv`, `Nlsv', `clmv`, `Flwv`
/usr/bin/defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Display full POSIX path as Finder window title
/usr/bin/defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Set $HOME as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
/usr/bin/defaults write com.apple.finder NewWindowTarget -string "PfLo"
/usr/bin/defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Empty out the last connected server path
/usr/bin/defaults write com.apple.finder FXConnectToLastURL -string ""

# Finder Toolbar to 10.7 effect
/usr/bin/defaults write com.apple.finder FXToolbarUpgradedToTenSeven -int 1

# Remvoe iDisk from Sidebar
/usr/bin/defaults write com.apple.finder RemoveIDiskFromSidebarOnStartup -bool true

# Show External drives on Desktop
/usr/bin/defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Show local drives on Desktop
/usr/bin/defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# Show mounted server drives on Desktop
/usr/bin/defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# Show removeable media on Desktop
/usr/bin/defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show path bar in Finder 
/usr/bin/defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
/usr/bin/defaults write com.apple.finder ShowStatusBar -bool true

# Disclosed State Devices Sidebar
/usr/bin/defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true

# Disclosed State Places Sidebar
/usr/bin/defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true

# Disclosed State Shared Sidebar
/usr/bin/defaults write com.apple.finder SidebarSharedSectionDisclosedState -bool true

# Restart Dock
/usr/bin/killall Dock