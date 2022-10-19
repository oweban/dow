#!/bin/zsh

#####################################################################################################################
# Script for installing a bunch of things rapidly. Note that this should only be put on a wiped laptop, immediately #
# after making the first account and logging into it.                                                               #
#                                                                                                                   #
# Put this file in /Users/Shared, then open Terminal.                                                               #
#                                                                                                                   #
# You can also get this file faster by ignoring moving the file into place, and just doing the curl line below.     #
#                                                                                                                   #
# sudo zsh                                                                                                          #
# cd /Users/Shared                                                                                                  #
#                                                                                                                   #
### OPTIONAL FOR GETTING THIS FAST                                                                                ###
# curl https://raw.githubusercontent.com/oweban/dow/main/macos_installer_script.sh -o ./macos_installer_script.sh   #
### END OPTIONAL                                                                                                  ###
#                                                                                                                   #
# chmod +x ./macos_installer_script.sh                                                                              #
# ./macos_installer_script.sh                                                                                       #
#####################################################################################################################


# Let's get Installomator and make it executable
curl https://raw.githubusercontent.com/Installomator/Installomator/main/Installomator.sh -o /Users/Shared/Installomator.sh
chmod +x /Users/Shared/Installomator.sh

# Now we need to edit DEBUG=1 to DEBUG=0 - search the file for it, and replace it wherever it happens, in case they change the line it's on.
sed -i '' "s/DEBUG\=1/DEBUG\=0/" /Users/Shared/Installomator.sh

# Install Chrome and Drive
/Users/Shared/Installomator.sh googlechromepkg
/Users/Shared/Installomator.sh googledrive

# This is to bypass the Outlook/OneDrive/OneNote bullshit
/Users/Shared/Installomator.sh microsoftautoupdate
/Users/Shared/Installomator.sh microsoftexcel
/Users/Shared/Installomator.sh microsoftword
/Users/Shared/Installomator.sh microsoftpowerpoint

# Get Zoom and TeamViewer, too
/Users/Shared/Installomator.sh zoomclient
/Users/Shared/Installomator.sh teamviewer

# Get Creative Cloud?
# Uncomment the following line if we want this
#/Users/Shared/Installomator.sh adobecreativeclouddesktop

# Let's skip the user-setup part - no more having to choose touchid, screentime, etc.

touch /Library/User\ Template/Non_localized/.skipbuddy

# Let's make the teacher/education account #

dscl . -create /Users/teacher
dscl . -create /Users/teacher UserShell /bin/zsh
dscl . -create /Users/teacher RealName "Teacher"
dscl . -create /Users/teacher UniqueID "502"
dscl . -create /Users/teacher PrimaryGroupID 20
dscl . -create /Users/teacher NFSHomeDirectory /Users/teacher

# Edit the following line to add in the current teacher password.

dscl . -passwd /Users/teacher "password"
dscl . -append /Groups/admin GroupMembership teacher
dscl . -delete /Users/teacher JPEGPhoto
dscl . -create /Users/teacher Picture /Library/User\ Pictures/Fun/Medal.tif


############################################################
############################################################
# MAKE SURE YOU ADD THE TEACHER ACCOUNT TO FILEVAULT USERS #
############################################################
############################################################






######################################################################################
# Below are some things I'm working on, so they're commented out for the time being. #
######################################################################################

# Enable right-click on apple magic mouse etc
#/usr/bin/defaults write <PATH/TO/USER/HOMEFOLDER>/Library/Preferences/com.apple.driver.AppleHIDMouse.plist Button2 -int 2
#
# Show status bar in finder
#/usr/bin/defaults write com.apple.finder ShowStatusBar -bool true
#
# Enable snap-to-grid for desktop icons
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
#
# Disable shadow in screenshots
#defaults write com.apple.screencapture disable-shadow -bool true


# Hide admin account?
# Expanded Save dialog boxes?
