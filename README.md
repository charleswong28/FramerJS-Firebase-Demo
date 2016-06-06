# FramerJS-Firebase-Demo
Realtime chat app prototype using FramerJS and Firebase<br />
**Demo - <a href="http://share.framerjs.com/yfvlcjc617hh/" target="_blank">here</a>**<br />

## Get Started
1. Download Sketch (<a href="https://www.sketchapp.com/" target="_blank">here</a>) **Mac Only**<br />
2. Download FramerJS Studio (<a href="http://framerjs.com/" target="_blank">here</a>) **Mac Only**<br />
3. Download Sketch resource file for this demo (<a href="https://www.dropbox.com/s/3nvobcd8oqbdu8z/WID2016_FramerJS_Resources.zip?dl=0" target="_blank">here</a>) <br />
4. (Optional) Clone this project to check the source code<br />

## Import from Sketch3
1. Open the Sketch resource file you downloaded<br />
2. Open a new FramerJS project <br />
3. Press &#8984; + ⇧ + i <br />
**TODO: GIF HERE**<br />

## Input Module for FramerJS (<a href="https://github.com/ajimix" target="_blank">ajimix</a>/<a href="https://github.com/ajimix/Input-Framer" target="_blank">Input-Framer</a>)
Framer module to easily turn your designs inputs into real inputs.

##### Add it in your Framer Studio project
1. Download the project from <a href="https://github.com/ajimix/Input-Framer/archive/master.zip" target="_blank">github</a>.
2. Copy input.coffee and keyboard.png into modules/ folder.

##### Text input for name 
```coffeescript
InputModule = require "input"

# Textbox init 
nameInput = new InputModule.Input
		text: ""
		placeholder: "Your name"
		placeholderColor: "#aaa"
		type: "text"
		y: 750
		x: 150
		width: 450
		height: 60
		virtualKeyboard: false
		parent: sketch.home_screen

nameInput.style =
	color: "#fff"
	fontFamily: "Helvetica Neue"
	fontWeight: 200
	fontSize: "42px"
	lineHeight: "42px"
```

##### Initialize Go Button
```coffeescript
sketch.goBtn.opacity = 0.5
nameInput.on "keyup", ->
	sketch.goBtn.opacity = if @value.length > 0 then 1 else 0.5
```

**TODO: GIF HERE**<br />

## View Controller for FramerJS (<a href="https://github.com/awt2542" target="_blank">awt2542</a>/<a href="https://github.com/awt2542/ViewController-for-Framer" target="_blank">ViewController-for-Framer</a>)

The ViewController module for Framer.js helps you create multi step user flows with pre-made transitions like "fade in", "zoom in" and "slide in". It consists of a Framer module and an optional [Sketch plugin](#sketch). Check out the intro article on [Medium](https://uxdesign.cc/create-ui-flows-using-sketch-and-framer-36b6552306b5#.4j5idvu0r).

##### Add it in your Framer Studio project
1. Download the project from <a href="https://github.com/awt2542/ViewController-for-Framer/archive/master.zip" target="_blank">github</a>.
2. Copy ViewController.coffee into modules/ folder.

##### Initialize
```coffeescript
ViewController = require 'ViewController'
Views = new ViewController
    initialView: sketch.homeScreen
```

##### Go button eventlistener
```coffeescript
sketch.goBtn.onTap -> 
	if nameInput.value.length > 0
		Views.pushInRight(sketch.chatroomScreen)
		chatInput.visible = true
		nameInput.visible = false
```
##### Back button eventlistener
```coffeescript
sketch.chatScreenBackButton.onTap ->
	chatInput.visible = false
	nameInput.visible = true
	Views.back()
	
```

** The reason for not using <a href="https://github.com/awt2542/ViewController-for-Framer#--autolink" target="_blank">autoLink</a> is that we need to control the display state of inputs 

**TODO: GIF HERE**<br />

## Supercharge with FireBase (<a href="https://github.com/marckrenn" target="_blank">marckrenn</a>/<a href="https://github.com/marckrenn/framer-Firebase" target="_blank">framer-Firebase</a>)

The **Firebase module** allows your Framer prototype to **load**, **save** and **sync** data effortlessly between multiple sessions and devices. 

##### Add it in your Framer Studio project
1. Download the project from <a href="https://github.com/marckrenn/framer-Firebase/archive/master.zip" target="_blank">github</a>.
2. Copy firebase.coffee into modules/ folder.

##### Initialize
```coffeescript
firebase = new Firebase
	projectID: "project-8070018445052938302"
	secret: "TWDpxeHTLmcW84DFQY7X2YmI0UKZsmeZESTJDhFY"
	server: "s-usc1c-nss-136.firebaseio.com"
	
sketch.sendBtn.onTap ->
	firebase.post("/messages", {name: nameInput.value, message: chatInput.value}, () -> chatInput.value = "")

```

Please do **NOT** use this demo database for other projects. Your data will be deleted. 

##### Check your message here 
**TODO: Check this**
```coffeescript
response = (messages) ->
    messagesArray = _.toArray(messages)
    print message for message in messages

firebase.get("/messages",response,{limitToFirst: 10})
```

## TODO: Make message container scrollable

## TODO: Message View with textLayer-for-Framer
https://github.com/awt2542/textLayer-for-Framer
