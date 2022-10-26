#!/bin/zsh

#####################################################################################################################
# Script for installing a bunch of things rapidly. Note that this should only be put on a wiped laptop, immediately #
# after making the first account and logging into it (which makes the 501 account).                                 #
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
# That said - if we're going to edit this to add in the right passwords, then use vi or nano                        #
# Only GUI editors to use would be Sublime/Textmate etc - NO TEXTEDIT.                                              #
#                                                                                                                   #
# chmod +x ./macos_installer_script.sh                                                                              #
# ./macos_installer_script.sh                                                                                       #
#####################################################################################################################


# Let's get Installomator and make it executable #
curl https://raw.githubusercontent.com/Installomator/Installomator/main/Installomator.sh -o /Users/Shared/Installomator.sh
cd /Users/Shared
chmod +x ./Installomator.sh

# Now we need to edit Installomator.sh to switch to DEBUG=0 and NOTIFY=silent #
sed -i '' "s/DEBUG\=1/DEBUG\=0/" ./Installomator.sh
sed -i '' "s/NOTIFY\=success/NOTIFY\=silent/" ./Installomator.sh

# Install Chrome and Drive #
./Installomator.sh googlechromepkg
./Installomator.sh googledrive

# This is to bypass the Outlook/OneDrive/OneNote part of the Office install that we really don't want #
./Installomator.sh microsoftautoupdate
./Installomator.sh microsoftexcel
./Installomator.sh microsoftword
./Installomator.sh microsoftpowerpoint

# Get Zoom and TeamViewer, too #
./Installomator.sh zoomclient
./Installomator.sh teamviewer

# Get Creative Cloud? #
# Uncomment the following line if we want this #
#./Installomator.sh adobecreativeclouddesktop

# Let's skip the user-setup part - no more having to choose touchid, screentime, etc.

touch /Library/User\ Template/Non_localized/.skipbuddy

# Let's make the teacher/education account #

dscl . -create /Users/teacher
dscl . -create /Users/teacher UserShell /bin/zsh
dscl . -create /Users/teacher RealName "Teacher"
dscl . -create /Users/teacher UniqueID "502"
dscl . -create /Users/teacher PrimaryGroupID 20
dscl . -create /Users/teacher NFSHomeDirectory /Users/teacher
# Edit the following line to add in the current teacher password. #
dscl . -passwd /Users/teacher "password"
dscl . -append /Groups/admin GroupMembership teacher

# Could also be done as a one-liner with (noting teacher and admin passwords need to be changed in the line below):
# sysadminctl -addUser teacher -fullName "Teacher" -UID "502" -GID "20" -shell /bin/zsh -password password -home /Users/teacher -admin -adminUser admin -adminPassword password

# Add to other groups I've noted on other admin accounts
dscl . -append /Groups/_appserverusr GroupMembership teacher
dscl . -append /Groups/_appserveradm GroupMembership teacher

# This is needed so the user can do updates etc! Edit the dashes after -password and -adminPassword to automate it.
sysadminctl -secureTokenOn teacher -password - -adminUser admin -adminPassword -

# This needs work - for now, manually select the Medal image in System Preferences/Users & Groups #
#dscl . -delete /Users/teacher JPEGPhoto
#dscl . -create /Users/teacher Picture /Library/User\ Pictures/Fun/Medal.tif

# Install Rosetta on M1
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

# Cleaning up time
sleep 5
rm -rf /Users/Shared/*.*


############################################################
# Things to do when that's all done
#
# Set Zoom and TeamViewer to have Screen Recording and Accessibility permissions. May need to add Zoom in manually for Accessibility.
# Login to Teacher account
# Set teacher's login image to the medal. Will work on scripting it properly.
# Add teacher to FileVault users.
# Update macOS if it's not done.
# 
# This space left blank for other things.
#
############################################################











#####################################################################################################
# Below are some other bits and pieces I'm working on, so they're commented out for the time being. #
# Mostly per-user though? Annoying.
#####################################################################################################

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
# Expanded Save and Print dialog boxes?
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# defaults write -g PMPrintingExpandedStateForPrint -bool true

# Worth looking at https://github.com/aethys256/notes/blob/master/setup/macos-defaults.md
