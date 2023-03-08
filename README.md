Any feedbacks or request are welcome, do it quick when I still have passion on this.

this tool works on reforged and eb(run as admin)
unlike wfe, this one simulate the real input of user instead of altering ram for wc3 only

tool auto disable on pressing enter(ingame chat) and re-enable after pressing enter/esc/left click again(finish ingame chat)

unlike wfe it cant detect if ur in lobby or ingame, so better disable it with f2 when ur in lobby

## Loader
click any of ur savefile and then click load  
or in game type -l / -load will load ur selected savefile  
or in game type -ll / -loadlast will load ur last loaded savefile  
after load will save the history of ur last loaded savefile

can drag and drop new save file into ui  
can search/filter out save files in textbox  
right click save file can hide unwanted saves  
right click save file can add loading message to send when loading character in wc3

![Imgur](https://imgur.com/8Y0g9Ef.png)
![Imgur](https://imgur.com/mk01Gnq.png)

## remap keyboard

Original spells are the current wc3 spell hotkeys on ur bot right UI grid

New spells are the one u want to press to send the corresponding hotkey to wc3

Original Inventory hotkeys are  
numpad7 numpad8  
numpad4 numpad5  
numpad1 numpad2

mouse hotkeys u know  
left and right click

**control**  
click on the button box to remove then click any key or key combination on keyboard to register a new one

right click button box to enable/disable quickcast (left click after pressing hotkey)

enable/disable sections on bot right checkboxes

**note**  
hotkey cant be duplicated  
original keys can be any single key, just make sure they match ur wc3, leaving them empty will result new remaped key sending empty key

Mouse buttons cannot be detected when assigning a key for inventory/quick cast, but user can edit the data.ini file to make mouse button works. I cannot find a way to detect mouse buttons on ahk, let me know if any knows how to do it.

Examples: Common mouse buttons Mbutton = Middle button, XButton1 = Mouse button 3, XButton2 = Mouse button 4.

Different mouse has different buttons name.

```
inventoryHK1=$MButton
inventoryHK2=$XButton1
inventoryHK3=$XButton2
inventoryHK4=$4
inventoryHK5=$5
inventoryHK6=$6
```

![Imgur](https://imgur.com/B8Ss8Nl.png)

## Quick message
send message with hotkey

**control**  
click the hotkey button to remove then click any key or key combination on keyboard for the trigger u want

type any message to the textbox of u want

click add to register that quick message

select row then edit on hotkey button or textbox message, then click update

select row then click delete to delete

**note**  
hotkey cant be duplicated from any other
can have more then one message for the same hotkey

![Imgur](https://imgur.com/8dLlDGV.png)

## Host
one click messaging bot

**control**  
just type or select from the combo box

then click the host button or type the hotstrings ingame

**note**  
settings will be saved after hosting

![Imgur](https://imgur.com/lKyUxRN.png)

## Map
really just for lazy me dont want to open download folder and paste map there

**control**  
just drag and drop any map into the UI

**note**  
can drop more than 1

![Imgur](https://imgur.com/LcWvSSY.png)

## Hotkeys

currently is just showing what are the things u can do

hotkeys will be editable later

![Imgur](https://imgur.com/oFrB1my.png)

## Settings

checkboxes to toggle different things

![Imgur](https://imgur.com/nwTbTra.png)
