# FramerJS-Firebase-Demo
Realtime chat app prototype using FramerJS and Firebase<br />
**Demo - <a href="http://share.framerjs.com/yfvlcjc617hh/" target="_blank">here</a>**<br />

![DEMO](http://f.cl.ly/items/1L14123l3w213v1x1G0O/output_c2pjL6.gif)

<br />

## Getting Started
1. Download Sketch (<a href="https://www.sketchapp.com/" target="_blank">here</a>) **Mac Only**<br />
2. Download FramerJS Studio (<a href="http://framerjs.com/" target="_blank">here</a>) **Mac Only**<br />
3. Download Sketch resource file for this demo (<a href="https://www.dropbox.com/s/3nvobcd8oqbdu8z/WID2016_FramerJS_Resources.zip?dl=0" target="_blank">here</a>) <br />
4. (Optional) Clone this project to check the source code<br />

<br />

## Import from Sketch
1. Open the Sketch resource file you downloaded<br />
2. Open a new FramerJS project <br />
3. Press &#8984; + ⇧ + i <br />

![Import from Sketch](http://f.cl.ly/items/1l0U0O0G0S3w3J3D1m3i/4f1965bf-ff8f-4044-8276-4613ba52e938.gif)
<br />

## Input Module for FramerJS (<a href="https://github.com/ajimix" target="_blank">ajimix</a>/<a href="https://github.com/ajimix/Input-Framer" target="_blank">Input-Framer</a>)

> Framer module to easily turn your designs inputs into real inputs.

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

![Home Screen](http://f.cl.ly/items/0M062x3o023o1k321Z1S/dc3088f5-50c7-4835-a7c9-107305e2410d.gif)

<br />

## View Controller for FramerJS (<a href="https://github.com/awt2542" target="_blank">awt2542</a>/<a href="https://github.com/awt2542/ViewController-for-Framer" target="_blank">ViewController-for-Framer</a>)

> The ViewController module for Framer.js helps you create multi step user flows with pre-made transitions like "fade in", "zoom in" and "slide in". It consists of a Framer module and an optional [Sketch plugin](#sketch). Check out the intro article on [Medium](https://uxdesign.cc/create-ui-flows-using-sketch-and-framer-36b6552306b5#.4j5idvu0r).

##### Add it in your Framer Studio project
1. Download the project from <a href="https://github.com/awt2542/ViewController-for-Framer/archive/master.zip" target="_blank">github</a>.
2. Copy ViewController.coffee into modules/ folder.

##### Initialize
```coffeescript
ViewController = require 'ViewController'
Views = new ViewController
    initialView: sketch.homeScreen
```
**Note that this should be initalized before binding text input**

##### TextInput Inside chatroom
```coffeescript
chatInput = new InputModule.Input
		text: ""
		placeholder: "Your message"
		placeholderColor: "#aaa"
		type: "text"
		y: 14
		x: 28
		width: 588
		height: 48
		virtualKeyboard: false
		parent: sketch.chatroomBottomBar

chatInput.style =
	fontFamily: "Helvetica Neue"
	fontWeight: 300
	fontSize: "23px"
	lineHeight: "23px"
	
chatInput.visible = false
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

**The reason for not using <a href="https://github.com/awt2542/ViewController-for-Framer#--autolink" target="_blank">autoLink</a> is that we need to control the display state of inputs**

![chatroom screen](http://f.cl.ly/items/1e3G2t383q183o3d0c2Z/fea2745e-5040-4f8d-a68e-192a0f52112d.gif)

<br />

## Supercharge with FireBase (<a href="https://github.com/marckrenn" target="_blank">marckrenn</a>/<a href="https://github.com/marckrenn/framer-Firebase" target="_blank">framer-Firebase</a>)

> The **Firebase module** allows your Framer prototype to **load**, **save** and **sync** data effortlessly between multiple sessions and devices. 

##### Add it in your Framer Studio project
1. Download the project from <a href="https://github.com/marckrenn/framer-Firebase/archive/master.zip" target="_blank">github</a>.
2. Copy firebase.coffee into modules/ folder.

##### Initialize
```coffeescript
{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "project-8070018445052938302"
	secret: "TWDpxeHTLmcW84DFQY7X2YmI0UKZsmeZESTJDhFY"
	server: "s-usc1c-nss-136.firebaseio.com"
	
sketch.sendBtn.onTap ->
	firebase.post("/messages", {name: nameInput.value, message: chatInput.value, created_at: new Date()}, () -> chatInput.value = "")

```

Please do **NOT** use this demo database for other projects. Your data will be deleted. 

##### Check your message here (For testing)
```coffeescript
response = (messages) ->
    messagesArray = _.toArray(messages)
    print message for key, message of messages

firebase.get("/messages",response,{orderBy: "created_at", limitToFirst: 10})
```

<br />

## Message View with textLayer-for-Framer (<a href="https://github.com/awt2542" target="_blank">awt2542</a>/<a href="https://github.com/awt2542/textLayer-for-Framer" target="_blank">textLayer-for-Framer</a>)

> Framer.js module that simplifies the process of adding text to your prototypes.

##### Add it in your Framer Studio project
1. Download the project from <a href="https://github.com/awt2542/textLayer-for-Framer/archive/master.zip" target="_blank">github</a>.
2. Copy TextLayer.coffee into modules/ folder.

#### Initalize
```coffeescript
{TextLayer} = require 'TextLayer'
```

##### Make message container scrollable
```coffeescript
scroll = ScrollComponent.wrap(sketch.chatroomContent)
scroll.scrollHorizontal = false
scroll.contentInset =
    top: 0
    right: 0
    bottom: 20
    left: 0
```

##### Function to generate view 
```coffeescript
# Common function
getInMessageView = (y, message) ->
	layer = sketch.inMessage.copy()
	
	content = sketch.inMessageContent.convertToTextLayer()
	content.fontFamily = "Helvetica"
	content.fontWeight = 100
	content.autoSize = true
	content.parent = layer
	content.text = message.message || ""
	content.x = 119
	content.y = Align.top
	content.width = 571
	content.color = "#333"
	
	name = sketch.inMessageName.convertToTextLayer()
	name.fontFamily = "Helvetica"
	name.fontWeight = 100
	name.autoSize = true
	name.parent = layer
	name.text = message.name || ""
	name.x = (89 - name.width) / 2
	name.y = Align.bottom()
	name.color = "#999"
	
	layer.x = 30
	layer.y = y
	layer.visible = true
	
	sketch.chatroomContent.addSubLayer(layer)
	return layer
```

##### Change go button eventlistener to listen to changes in "/messages"
```coffeescript
inMessages = []
sketch.goBtn.onClick -> 
	if nameInput.value.length > 0
		for inMessage in inMessages
			inMessage.destroy()
		
		Views.pushInRight(sketch.chatroomScreen)
		chatInput.visible = true
		nameInput.visible = false
		chatroomHeight = 0
		
		addInMessageView = (message) ->
			layer = getInMessageView(chatroomHeight + 60, message)
			chatroomHeight += layer.height + 60
			scroll.scrollToLayer layer
			inMessages.push layer
		
		response = (data, method, path, breadcrumbs) ->
			if data
				if path == "/"
					for key, message of data
						addInMessageView(message)
				else 
					addInMessageView(data)
		
		firebase.onChange("/messages", response)

	sketch.inMessage.visible = false
	sketch.inMessageContent.visible = false
	sketch.inMessageName.visible = false
```
<br />

## Contact
Twitter: <a href="https://twitter.com/silverchung28" target="_blank">@silverchung28</a><br />
Email: charles@eoniq.co

<br />

## Credits
##### @ajimix (<a href="https://github.com/ajimix" target="_blank">ajimix</a>/<a href="https://github.com/ajimix/Input-Framer" target="_blank">Input-Framer</a>)
##### @awt2542 (<a href="https://github.com/awt2542" target="_blank">awt2542</a>/<a href="https://github.com/awt2542/ViewController-for-Framer" target="_blank">ViewController-for-Framer</a>, <a href="https://github.com/awt2542" target="_blank">awt2542</a>/<a href="https://github.com/awt2542/textLayer-for-Framer" target="_blank">textLayer-for-Framer</a>)
##### @marckrenn (<a href="https://github.com/marckrenn" target="_blank">marckrenn</a>/<a href="https://github.com/marckrenn/framer-Firebase" target="_blank">framer-Firebase</a>)
