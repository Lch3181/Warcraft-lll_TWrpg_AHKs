# Twrpg AHK
Make life ~~lazier~~ easier

## TWRPG Loader 2 (Based on Lee's loader but more user friendly)
Lee's old twrpg loader: [Script to load characters](https://www.twrpg.com/viewtopic.php?f=2&t=4845)

![GUI](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/blob/master/Readme_Images/wc3rpgOverlayGUI.png)

![GUI](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/blob/master/Readme_Images/wc3rpgLoaderGUI.png)
![GUI](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/blob/master/Readme_Images/wc3rpgHerosEditorGUI.png)
![GUI](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/blob/master/Readme_Images/wc3rpgInventoryGUI.png)
![GUI](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/blob/master/Readme_Images/wc3rpgSettingsGUI.png)

## How to use:
Loading hero on first time, select the twrpg save folder on the bottom; next, click the add button to add heros, download URL if any, and the loading String if you want; then, click add/update; finally, select the hero you would like to load and click the load button.

Hosting on the first time, type the bot's name, map load command if any, and game name; then click private/public to host. Everything will be saved for the next time when you want to host. Click Delete Bot History to delete the selected bot info.

Inventory, default F2 to enable/disable it. Click the button then click a key on your keyboard to remap that key for inventory. Check box for auto cast/quick cast.

Note: Mouse buttons cannot be detected when assigning a key for inventory/autocast, but user can edit the data.ini file to make mouse button works. I cannot find a way to detect mouse buttons on ahk, let me know if any knows how to do it.

Examples: Common mouse buttons Mbutton = Middle button, XButton1 = Mouse button 3, XButton2 = Mouse button 4. 

Note: Different mouse has different buttons name.

```
Numpad7=$MButton
Numpad8=$XButton1
Numpad4=$Xbutton2
Numpad5=$~4
Numpad1=$~5
```

Auto cast/quick cast meaning: its basically cast that spell on mouse hover without needing to left click.

Default hotkeys:

F8: show/hide wc3 rpg tool

F7: show/hide overlay

Alt+Esc: exit wc3 rpg tool
## Important:
Download URL has to be a direct download link instead of a share link(google if you do not know how to get it from a share link)

## Installation:
[Download](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/releases/tag/v1.0)

Download from release or the link above. Unzip it and run the .exe file in anywhere else. Note: there will be extra files generated after running the .exe file

## Independent scripts(Users need to edit them manually)
![GUI](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/blob/master/Readme_Images/GUI.png)

## Quick Calls
[Download](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/tree/master/Independent/QuickCalls.ahk)

f6: On/Off

Shift+J: DeathFiend

Shift+K: Valtora

Shift+L: Ifrit

J:Sylvanas

K:Succubus

L:Hellhound

DeathFiend

Z: >> Coil <<

X: >> Howl <<

C: >> 30% get ready <<

V: >> PROCCING 20% <<

B: >> DF READY <<



Valtora

Shift+W: >> Top Line <<

Shift+A: >> Left Line <<

Shift+S: >> Bottom Line <<

Shift+D: >> Right Line <<

Z: >> MAGNET DIED <<

X: >> LINK DIED <<

C: >> HAMMER DIED <<

V: 

B:


Ifrit

Shift+W: >> Charging Top <<

Shift+A: >> Charging Left <<

Shift+S: >> Charging Bottom <<

Shift+D: >> Charging Right <<

Z: >> ELS <<

X: >> BOMBS <<

C: >> CLEANSING BOMB <<

V: >> CHARGING <<

B:


Sylvanas

Z: >> 11111 <<

X: >> 22222 <<

C: >> 33333 <<

V: >> 4444444 Arrow <<

B: >> SYL READY <<



Succubus

Z: >> TELEPORTING <<

X: >> WAVE <<

C: 

V: 

B: >> SUCC READY <<


Hellhound

Z: >> CHARGING <<

X: >> ORBS <<

C: >> HH NEEDS HELP <<

V:

B: >> HH READY <<

## Inventory
[Download](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/tree/master/Independent/inventory.ahk)

f2:On/Off

1 = NUMPAD 7

2 = NUMPAD 8

3 = NUMPAD 4

4 = NUMPAD 5

5 = NUMPAD 1

6 = NUMPAD 2

## Quick Cast
[Download](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/tree/master/Independent/QuickCast.ahk)

Automatically left click after clicking spells' hotkeys

f3: On/Off

Q W E R T F

1 = NUMPAD 7

2 = NUMPAD 8

## No Mouse
[Download](https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/tree/master/Independent/NoMouse.ahk)

For laptop users

f4:On/Off

Space bar = right click
