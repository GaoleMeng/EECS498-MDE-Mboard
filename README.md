# M-Board

## Quick start

A basic M-Board app involves two apps to be started, which located in two folder:

- `buttonAddition` - the iPad app that is used as the virtual keyboard.

- `mac-keyboard-server` - the receiver app that runs on Mac to receive input from virtual keyboard

- `autocompletion` - the auto-completion server that runs on Mac to produce predicted words

To use the app, clone the repository and run the following commands. These commands include running the receiver app in the terminal, which is the first thing you need to do in order to use M-Board app:

```bash
# Clone this repository
git clone https://github.com/GaoleMeng/EECS498-MDE-Mboard.git
# Go into the repository
cd EECS498-MDE-Mboard
# run the auto-completion model download script
sh autocompletion-init.sh
```

Open another terminal enter the same root directory
```bash
# Go into the repository
cd EECS498-MDE-Mboard
# Go to the receiver app directory:
cd mac-keyboard-server
# Start the app, you should have node to start it:
npm start
```

This will open up a window with an on/off switch. Set this switch to on by clicking it (not swiping).
You may need to install dependency for the autocompletion server if it shows error:
```bash
pip3 install bottle
```

Next you will start up the iPad app. To do this, complete the following steps:
1. Navigate to the root of `EECS498-MDE-Mboard`
2. Enter `buttonAddition` directory
3. Open `buttonAddition.xcodeproj` with Xcode
4. Click in the box that says "buttonAddition" which is to the right of the Build-and-Run and Stop buttons in the top left of the screen. Once this opens, expand the list labeled "buttonAddition" to get a list of devices that you can choose to run the application on.
5. If you have an iPad, plug it into your computer and select it from the list of devices. Otherwise, just pick an iPad simulator from the list. You will have a better experience of the whole features of M-Board, if you can run that on iPad. Remember to check the bundle indentifier and signing team by clicking the buttonAddition folder in the left column of the screen. You might need to change the bundle identifier and signing team to your own Apple developer account in order to run the app on iPad.
6. Press the Build-and-Run button in the top left corner of the Xcode.
7. On your device or simulator, you should now see a new application. Press on this to open the app.


### Using the application
To begin using the application, you will first be presented with the Configuration screen (0)

0. Configuration Sceen:
- Configure the keyboard to your hand by placing your four fingers on the screen within the outlined area (if on a simulator, you will have to click where you want your fingers to be one by one). Follow the on-screen directions to do this.
- If you are satisfied with the postioning, click confirm. This will bring you to the main typing screen (1). Otherwise, you can click reset to restart this process.
- If your positioning will cause overlapping keys in the later view or is not inside the outlined area, you will get a warning on that and you need to choose a new positioning by moving your four fingers until the app asks you to confirm or reset. Please do not keep your fingers to close to each other.


1. Main typing screen:
- On your computer, set the cursor to where you want to type (Notes, Word, etc.)
- On the iPad, press character keys to type to the computer.
- Swipe up or down on the screen to change the characters on the keys.
- Swipe left on the screen to switch to the number mode screen (2).
- Word prediction boxes along the top of the screen may be pressed to type the word offered in that box. The whole functionality of the word prediction box will be implemented in Beta release.
- Enter key, Space key, Delete key (labeled 'Del'), Caps lock (labeled 'Cap'), can be found on the right side of this view. You can also try them.
- "Configure" button at bottom right (or top right based on your positioning in (0)) brings you back to configure the keyboard if you would like to reconfigure.
- Pressing the blue button on the right with a computer mouse symbol will bring you to the mouse control screen (3).
- The symbols at the bottom of the screen (including a black circle with the label "Swipe") cannot be interracted with. These are navigtional symbols which show you what keys you can get to by swiping in various directions. These will be updated for whatever screen you are on except for the mouse control screen (3) which does not offer navigation-by-swiping.

2. Number mode screen:
- Press number keys to type to the computer.
- Press the "sign" button to switch to number-related signs. This will also present the "Num" button, which can be pressed to switch the keys back to numbers.
- Swipe right on the screen to switch back to the main typing screen (1).
- Access to all keys from the main typing screen (1) that are not character keys or word prediction boxes.

3. Mouse control screen:
- You can use one or multiple fingers to control the mouse.
- One finger for tap, two finger for right click, three finger for dragging, also you can scroll with two fingers.
- Press the "Back" button to go back to whichever screen you navigated here from.


## Note for developer
1. Before submit the code, since everyone has the permission, please leave enough commit information to others.

2. The starter-code folder contain very primitive starter-code for the swift front end.

3. For the subproject like the server for the mac or the middle server, please create a seperate folder.
