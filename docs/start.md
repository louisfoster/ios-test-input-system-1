### Mental acrobatics

Today I decided to work on the input system following requiring some kind of input/gesture management for my other projects involving a camera and a tile map. I had figured it out mostly in my head to begin with, and was in a good mood following watching the first season of [Dragula](https://www.youtube.com/watch?v=wK6vYACcr6w), which is probably the most entertaining reality "contestant" show I've seen, and I don't really watch shows, especially reality "contestant" shows. How does this fairly random show relate to 3D interactive software development? Spectacle, audience engagement, creativity, improvisation and passion.

Although, when I started getting into the code I realised I had to put the show on pause for a bit because I couldn't, in this case, do two things at once. I know it might seem silly to think it's possible at all, but I find that having a slight distraction allows me to feel like I didn't spend every moment of my weekend coding and also practicing to identify what tasks are mindless and repetitive and which are complicated and cognitively unexplored.

The first challenge was figuring out, how does some kind of input event relate to n objects? If I want to have one class to let, say, my camera know when to swivel and the same class let my map know it received a tap, but also be able to let my avatar know it received a tap, without rewriting the same code, how is it done? Turns out it was pretty simple.

The first thing to note is there is separation between the interface event and the input event. The interface event could come from anything we are prepared for, say a button, a screen, a controller, whatever. But in the end, they should be configured to provide a similar end goal. So we need some way of decoupling all of the interfaces from a single input handler. This is where we begin to get familiar with the idea of "messaging" and iOS has a built in system called `Notifications` to do so. Standard practice is to extend `Notification.Name` like so:
```swift
extension Notification.Name {

    static let pan = Notification.Name("pan")
    
    static let tap = Notification.Name("tap")
}
```
Now we can to two things with this. The notification naming comes from our intended forms of user input for the software. In this case we know for sure there are two distinct inputs:
- pan, which is some kind of movement indicating a leftwards or rightwards scrolling intent
- tap, which is some kind of action indicating a selection intent

_Side note, for myself_: Perhaps better terminology would be "horizontalScrollItent" instead of pan and "selectionIntent" instead of tap, to cognitively disconnect the idea of a specific interface with the input intent, but this is fine for all intents and purposes (it may change later).

The next step is to wire up the two sides of this notification message, the publisher of input intents and the listener of the intents.


### Yelling through a brick wall

The two sides of the notification wall should be fairly blind to each other's purposes. All they should know is there is an intent they can use to relate to one another. In order to make sure we can be totally decoupled nicely, I want to call the pan and tap intents from both the `SCNView` and also a button interface.


#### Screen Interface

Our scene view will be managed in what we will refer to as a "Screen Interface" where the "idea" of interaction happens organically with the screen's surface (perhaps surface interface would be more appropriate or gesture interface or something...) but basically we are listening to what is called a `UIGestureRecognizer`. These can be all kinds of events that occur upon the screen (swiping, touching, double touching etc.) without being specifically related to a particular event on a UI item.

As this is our primary interface for the project, the gestures were what lended themselves to the naming conventions for the notifications. As such, we are listening for two events:
```swift
UITapGestureRecognizer(target: self, action: #selector(ScreenInterface.handleTap(_:)))
        
UIPanGestureRecognizer(target: self, action: #selector(ScreenInterface.handlePan(_:)))
```
The selectors call the functions and these functions are where we publish a notification, like so:
```swift
NotificationCenter.default.post(name: .pan, object: nil)
```
For now, object field is empty, but here we will need to take data from the event and send it with the message so we can handle it in our input handler later.


#### Button Interface

Similarly, we have buttons to take "actions" which call functions that also call the notifications. For testing purposes we can simply tell the button to provide dummy data that is hard coded, randomly generated or from some kind of data input field. This concept could be adapted for an "automated" interface where the notifications are published by some kind of testing system, so this is why it is good to have all the interfaces abstracted in such a way.

_Side note, for myself_: It may also be useful to provide some kind of template for interfaces so they know what kind of notifications than can/cannot call and the data they should be passing into the notification object.


### The other side of the wall

What we want to be able to do is provide anything in the 3D world with the ability to react to any kind of intent that the user may provide. To do so, I have created a class which is to be extended by anything and upon it's implementation provides the ability to listen to the tap intent or pan intent. For debugging and control purposes, the listeners call a "received" function, which in turn calls the "on<Intent>" function to be overridden by the subclass in order to perform whatever tasks in reaction to the intent.
```swift
NotificationCenter.default.addObserver(self, selector: #selector(Input.tapReceived(notification:)), name: .tap, object: nil)
```

In this case we want to output information to a text field, like whether it was a tap or pan intent and, eventually, the data about the intent. It may have made more sense for the TextDisplay class to decide which events it wants to handle and init the super class with these itself, rather than decide externally and only allow the TD class to be created via a `convenience init`, but hindsight is 20/20.


#### wtf, y broken?

After setting all of this up, I thought the project would run fine. Nothing appeared to be falling apart (apart from my stuffing up the selector/target stuff, which I'm yet to fully wrap my head around) but nothing was happening when I interacted with it. I realised by setting the instances of the classes to empty variables, i.e. `_ = Class()`, in the `MainViewController` I was somehow letting them get cleaned up right after they were instantiated. Everything needs to be allocated to a place in memory so that it can be referenced at any time during the app's life.


### Datas

Because we are taking the lead for the user input from the gesture recognisers, it is the data provided from these that will inform the data model for the input intents. Therefore, the next step is to start playing around to figure out this part and perhaps refactor the project a bit to reflect the notes in this write-up. This data will allow us to plug in the new components to the harness and tilemap to start figuring out some other aspects of those particular projects.


[Home](./)