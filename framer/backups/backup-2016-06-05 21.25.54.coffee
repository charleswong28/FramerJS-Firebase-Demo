# Import file "wids2016"
sketch = Framer.Importer.load("imported/wids2016@1x")

# Init require
{Firebase} = require "firebase"
{TextLayer} = require 'TextLayer'
InputModule = require "input"
ViewController = require 'ViewController'
Views = new ViewController
    initialView: sketch.homeScreen

firebase = new Firebase
	projectID: "project-8070018445052938302"
	secret: "TWDpxeHTLmcW84DFQY7X2YmI0UKZsmeZESTJDhFY"
	server: "s-usc1c-nss-136.firebaseio.com"
	debug: true

# Common function
getInMessageView = (y, message) ->
	layer = sketch.inMessage.copy()
	
	content = sketch.inMessageContent.convertToTextLayer()
	content.fontFamily = "Helvetica"
	content.fontWeight = 100
	content.autoSize = true
	content.parent = layer
	content.x = Align.right
	content.y = Align.center(-10)
	content.color = "#333"
	content.text = message.message || ""
	
	name = sketch.inMessageName.convertToTextLayer()
	name.fontFamily = "Helvetica"
	name.fontWeight = 100
	name.autoSize = true
	name.parent = layer
	name.x = 
	name.y = Align.bottom()
	name.color = "#999"
	name.text = message.name || ""
	
	layer.x = 30
	layer.y = y
	layer.visible = true
	
	sketch.chatroomContent.addSubLayer(layer)
	return layer

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

# Init go button
sketch.goBtn.opacity = 0.5
nameInput.on "keyup", ->
	sketch.goBtn.opacity = if @value.length > 0 then 1 else 0.5

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
			inMessages.push layer
		
		response = (data, method, path, breadcrumbs) ->
			print data, method, path, breadcrumbs
			if data
				if path == "/"
					for key, message of data
						addInMessageView(message)
				else 
					addInMessageView(data)
		
		firebase.onChange("/messages", response)

chatInput = new InputModule.Input
		text: ""
		placeholder: "Your message"
		placeholderColor: "#aaa"
		type: "text"
		y: 14
		x: 28
		width: 600
		height: 48
		virtualKeyboard: false
		parent: sketch.chatroomBottomBar

chatInput.style =
	fontFamily: "Helvetica Neue"
	fontWeight: 300
	fontSize: "23px"
	lineHeight: "23px"

sketch.sendBtn.onTap ->
	firebase.post("/messages", {name: nameInput.value, message: chatInput.value}, () -> chatInput.value = "")
	
sketch.chatScreenBackButton.onTap ->
	chatInput.visible = false
	nameInput.visible = true
	Views.back()
	
sketch.inMessage.visible = false
chatInput.visible = false
sketch.inMessageContent.visible = false
sketch.inMessageName.visible = false

scroll = ScrollComponent.wrap(sketch.chatroomContent)
scroll.scrollHorizontal = false
