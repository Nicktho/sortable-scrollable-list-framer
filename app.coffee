bg = new BackgroundLayer
	backgroundColor: "white"
	
	
items = [
	"one"
	"two"
	"three"
	"four"
	"five"
	"six"
	"seven"
	"eight"
	"nine"
	"ten"
	"one"
	"two"
	"three"
	"four"
	"five"
	"six"
	"seven"
	"eight"
	"nine"
	"ten"
]

swapping = false
swapItems = {
	a: {}
	b: {}
}

GUTTER = 10

container = new Layer
	width: 500
	height: 400
	backgroundColor: "rgba(0,0,0,0)"

container.centerX()
container.centerY()

list = new Layer
	width: 500
	height: items.length * (50 + GUTTER)
	backgroundColor: "rgba(0,0,0,0)"
	superLayer: container
	
list.centerX()

container.scroll = true

listItem = (text, index) ->
	item = new Layer
		y: index * (50 + GUTTER)
		width: 500
		height: 50
		backgroundColor: 'gray'
		shadowColor: "rgba(0, 0, 0, 0.2)"
		superLayer: list
		
	item.centerX()
	
	item.index = index
	
	item.html = "#{text}"
	
	item.states.add
		selected: 
			width: 600
			x: bg.midX - 300
			shadowY: 5
			shadowBlur: 20
			shadowColor: "rgba(0, 0, 0, 0.22)"
	
	item.states.animationOptions = 
		curve: "ease"
		time: 0.15
	
	item.swap = (y) ->
		item.animate
			properties:
				y: y
			time: 0.5
	
	item.on Events.Click, ->
		if swapping
			item.states.next()
			item.swap(swapItems.a.y)
			items[swapItems.a.index].item.swap(item.y)
			items[swapItems.a.index].item.states.next()
			swapping = false
			Utils.delay 0.5, ->
				item.states.next()
		else
			item.states.next()
			swapping = true
			swapItems.a.y = item.y
			swapItems.a.index = index
		
		
	return item

items = items.map (item, index) ->
	{pos: index, item: 	listItem(item, index)}

