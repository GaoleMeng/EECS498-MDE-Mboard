# M-Board

## Quick start

Note: If you have updated the XCode, do "carthage update" first.

A basic M-Board App involves two Apps to be started, which located in two folder:

- `buttonAddition` - the iPad App that is used as the virtual keyboard.

- `mac-keyboard-server` - the receiver App that runs on Mac to receive input from virtual keyboard

- `autocompletion` - the auto-completion server that runs on Mac to produce predicted words

To use the App, clone the repository and run the following commands in the terminal. These commands include creating a bundle for the server App.

```bash
# Clone this repository
git clone https://github.com/GaoleMeng/EECS498-MDE-Mboard.git
# Go into the repository
cd EECS498-MDE-Mboard
# Create bundle for the server App
cd mac-keyboard-server
sh bundle.sh
```

After these commands, the server App is created under directory `mac-keyboard-server/M-board-darwin-x64/`. Use the Finder to go to `mac-keyboard-server/M-board-darwin-x64/`. Double click M-board(.app) to open the server. This will open up a window with an on/off switch. Set this switch to on by clicking it (not swiping). 

Then open the terminal to run the following commands to download and start the autocompletion model. 

```bash
# Go into the repository
cd EECS498-MDE-Mboard
# Run the auto-completion model download script
# We recommend to host the model using screen
screen -dm sh autocompletion-init.sh
# Listening on http://localhost:8080/
# Hit Ctrl-C to quit.
# ...
```

You may need to install dependency for the autocompletion server if it shows error:
```bash
pip3 install bottle
```

It may take some time to download and start the autocompletion model. Wait until there is a notification from the server App showing that the model has been loaded successfully. 

Next you will start up the iPad app. To do this, complete the following steps:
1. Navigate to the root of `EECS498-MDE-Mboard/buttonAddition`
2. Open `buttonAddition.xcodeproj` with Xcode
3. Click in the box that says "buttonAddition" which is to the right of the Build-and-Run and Stop buttons in the top left of the screen. Once this opens, expand the list labeled "buttonAddition" to get a list of devices that you can choose to run the application on.
4. If you have an iPad, plug it into your computer and select it from the list of devices. Otherwise, just pick an iPad simulator from the list. You will have a better experience of the whole features of M-Board, if you can run that on iPad. Remember to check the bundle identifier and signing team by clicking the buttonAddition folder in the left column of the screen. You might need to change the bundle identifier and signing team to your own Apple developer account in order to run the App on iPad.
5. Press the Build-and-Run button in the top left corner of the Xcode.
6. On your device or simulator, you should now see a new application. Press on this to open the App.

Note that you may have problems that the tutorial figures might not bind to the bundle. If that happens, you need to manually add the figures into the bundle. Click the top buttonAddition on the left column in Xcode. Drag the three figures (first.png, second.png, and third.png) using Finder to the Copy Bundle Resources under Build Phases. Then the three PNG files should appear in the left column. You might need to delete the previous PNG files if their filenames are showed in red color.


### Using the application
If it is your first time to install the App, a tutorial will show up. After the tutorial, click Let's Start to go to a view, which will ask you whether you will use your left hand or right hand to type. 

After you choose the hand, you will then be presented with the Configuration screen (0)

0. Configuration Screen:
- Configure the keyboard to your hand by placing your four fingers on the screen within the outlined area (if on a simulator, you will have to click where you want your fingers to be one by one). Follow the on-screen directions to do this.
- If you are satisfied with the positioning, click confirm. This will bring you to the main typing screen (1). Otherwise, you can click reset to restart this process.
- If your positioning will cause overlapping keys in the later view or is not inside the outlined area, you will get a warning on that and you need to choose a new positioning by moving your four fingers until the app asks you to confirm or reset. Please do not keep your fingers too close to each other.
- If you want to reselect you typing hand, click Reselect button.

1. Main typing screen:
- On your computer, set the cursor to where you want to type (Notes, Word, etc.)
- On the iPad, press character keys to type to the computer.
- Swipe left or right on the screen to change the characters on the keys.
- Swipe up on the screen to switch to the number mode screen (2).
- Word prediction boxes along the top of the screen may be pressed to type the word offered in that box.
- Enter key, Space key, Delete key (labeled 'Del'), Caps lock (labeled 'Cap'), can be found on the right side (if left-handed) or the left side (if right-handed) of this view. You can also try them.
- If left-handed, "Configure" button at bottom right (or top right based on your positioning in (0)) brings you back to configure the keyboard if you would like to reconfigure. If right-handed, "Configure" button will be at bottom left or top left. If you mistakenly click the "Configure" button, there is a "Go Back" button, which allows you to go back to the main typing screen (1).
- Pressing the blue button on the right with a computer mouse symbol will bring you to the mouse control screen (3).
- The symbols at the bottom or top of the screen (including a black circle with the label "Swipe") cannot be interacted with. These are navigational symbols which show you what keys you can get to by swiping in various directions. These will be updated for whatever screen you are on except for the mouse control screen (3) which does not offer navigation-by-swiping.
- You can also go back to see the tutorial by clicking the button with "?" on the top.

2. Number mode screen:
- Press number keys to type to the computer.
- Press the "sign" button to switch to number-related signs. This will also present the "Num" button, which can be pressed to switch the keys back to numbers.
- Swipe down on the screen to switch back to the main typing screen (1).
- Access to all keys from the main typing screen (1) that are not character keys or word prediction boxes.

3. Mouse control screen:
- You can use one or multiple fingers to control the mouse.
- One finger for tap, two finger for right click, three finger for dragging, also you can scroll with two fingers.
- Press the "Back" button to go back to whichever screen you navigated here from.
- Press the other buttons to calibrate the volume or the brightness of the Mac.


## Note for developer
1. Before submit the code, since everyone has the permission, please leave enough commit information to others.

2. The starter-code folder contain very primitive starter-code for the swift front end.

3. For the subproject like the server for the mac or the middle server, please create a separate folder.
