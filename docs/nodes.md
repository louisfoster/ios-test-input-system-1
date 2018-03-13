### You spin me right 'round, baby, or you don't, or you spin something else, or I spin really quickly then I reset back to my original position, which is a sure idicator that your function doesn't work and you should just use SO...

I tried to use my incredibly advanced knowledge of linear algebra 😛 to take the gesture of panning and turn that into some kind rotation transformation on the instance of the cube. However, I wasn't really thinking too much about it and falling victim to the "if I just plug in numbers and random equations, I'll eventually get it" mentality. For a moment I thought about trying to draw what I wanted to do and figure out the math involved from that. After looking at my weird drawing of a right-angle / arc / pivot thing, I figured that someone else has probably already tried this. [And they had](https://stackoverflow.com/questions/35194914/how-to-rotate-object-in-a-scene-with-pan-gesture-scenekit), so I just copied their code.

I haven't completely dissected what is going on, but we are basically getting a distance across the screen, getting some angle from that and building a rotation matrix from these values. After the gesture is completed, we preserve this transform in the form of the object's pivot. This final part resets the transform of the object to an identity matrix, so it needs to be positioned at the origin of its parent node otherwise it will appear to jump around. This is fine because this parent node can represent the "physical" aspect of the object, which can be a scene node containing world coordinates and that's it, while the input can be related to the "visual" aspect of an object, which could be a scene node containing the 3D model data.

This was when I starting thinking about when this kind of code needs to occur, because we could send rotation matrices to every observer of the gesture but some things may not necessarily need that information or want to calculate it differently for whatever reason. So, structure yet again became more of a thing.


### Protocols, protocols, protocols, protocols

I'm starting to learn about the protocol oriented style of programming that swift lends itself to. When I began originally putting the input system together, I was thinking I could simply subclass it whereever I needed it. However, this was incredibly naive and revealed to me that I had completely missed a very important aspect of swift. There is this article about [protocols vs. subclassing](https://krakendev.io/blog/subclassing-can-suck-and-heres-why) that I... kind of, sort of, read but didn't get very deep.

So my first attempt at restructuring my code such that I would rely on protocols rather than inheriting a bunch of functionality in each class that needed it allowed me to see where scope really could be isolated and kept in singular instances and what needed to be decoupled.

My first iteration had me create each observer of input events an instance of the `InputIntent` class, registering an observer in every instance and passing it a kind of closure to deal with the events. However, it occured to me that this wasn't really enforcing too much functionality within the object holding this class instance and as a result there would be plenty of assumptions and blind knowledge of what was happening (and supposed to happen).

A colleague then explained protocol extensions to me and I began to see how this kind of "interfacing" could help with this consistency and enforcing of functionality upon objects that are required to have certain capabilities. I am also starting to slowly learn about a common idiom called "Entity-Component-System" and I figured this InputIntent class was beginning to take the shape of a kind of system. Really, it is the only thing that needs to be observing the input events, and then passing these events to where they are needed.


### IDs

Apparently Entities have a kind of ID and a container of components. I'm still trying to grok this concept of how the ID talks to components and vice versa, as well as the communication between systems and entities and components and the order or preferred communciation channels that need to happen. There are books and code examples, but one has only so much time to learn everything.

In order to replace the passing of closures to discrete instances of the `InputIntent` class, I chose to pass upon "registration" of an object to a certain intent, such as the "Selection Intent", this ID to a dictionary along with a function to be called. When the observer event occurs, this now singular `InputIntent` class runs through it's dictionary of functions, passing the data as the argument.

Because each object holds a reference to it's ID and a protocol for each type of intent it subscribes to provides (using protocol extensions) a function to deregister the function, it can also run this function which uses the ID to register the function from the dictionary. So each object now _must_ have an ID, is _given_ the functionality to register and deregister itself, and is _forced_ to at least have the functions called by the `InputIntent` class - which is also referenced by the object.

It's obviously less weighty, but slightly more convoluted, and it does it a good job of enforcing structure but there seems to be a lot of passing back and forth and storing of information that may be easily accessible in other ways.


### Patterns

Naming patterns only got me so far, and knowing a bit more about protocols definitely made me feel wiser. But I feel at a loss with the structure I have. Where do the IDs come from? What manages them? How does an ID relate to a "type" of something, like a monster or character or building, which may all be able to respond to a "Select Intent" but all in their own unique ways? And right now, every single thing would need to be passed a reference to the inputIntent instance, and then pass to that instance a reference back to itself with a function it contains. Considering the level of duplication with only 2 different types of intents, it seems it may also become convoluted as it grows.

Thinking more about this "container of components" concept, and the relevance of an ID, I was wondering more about the data I'm passing around that is necessary in discerning what happens to each observer of the intent. The select intent is basically being passed a list of "nodes", physical spaces that occupy the world, that happen to lie somewhere between the point on the screen and along line drawn into infinity. 

In this ECS idea, I would say I have simply an ID. That ID probably is associated with some kind of list of all components actively associated with that ID. If I wanted something to respond to a "select intent" then I could assume it most definitely would have a physical component, which is the node to be "detected" by the selection, and highly likely to have a visible component, which is a visual prompt for the user to select. All the input intent instance does is listen for the event and receive a collection of nodes that were "hit" and once it does that it needs to pass it to whatever cares about selections. The data itself says nothing about whether anything in that list cares about being selected. The input intent shouldn't really store that data either, because it would simply repeat what should already be known and available -> entities that have a "select intent observer" component.

The list of components available to each entity is available, and if something is listening to select intents, it probably has a physical and visible component. If not, then it probably wants to know something about the data anyway, which can happen for n reasons. We can infer then that by having this component the `InputIntent` instance can simply pass the data onto every entity with that component. This is where I get stuck though.

What controls whether the component is active or not, as in, what removes and adds the component? Say if a map tile is no longer visible, what mechanism should infer the selection component is to be removed? And once the entity has the component, how does the component become aware of what that is supposed to acheive for the entity? How does it know to call x component's function to indicate that it was selected and needs to perform a certain behaviour?


#### Figuring it out

My intial thoughts are, the idea of a component is simply an interface, and when we search for the intent component, we are looking for this protocol. But what we implement for an entity is the composition of the protocol (and other protocols) as it's actual "component". This means that the standard functionality within the protocol can operate, and we can enforce ways to handle the data, but from there we can make calls to other components (including removing them from the entity) associated with that type of object.

For example a "SelectIntentObserverProtocol" maybe implemented by a "MonsterSelectIntentObserverProtocol" which is implmented by the MonsterSelectIntentObserverComponent class. And we could say all monster protocols, or components, should make reference to something unique only to monsters.

Honestly, I'm still a bit confused but I need some sleep anyway... I think I need something more concrete to flesh out these ideas with, so I'm going to start combining this project with the camera harness (for horizontal scroll intents) and the tile map (for select intent) along with a kind of "avatar" object, so that I can begin seeing how to implement it effectively.


[Home](./)