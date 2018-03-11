### What do I wanna know?

That's the question I ask when I first try to structure how my classes interact. Some "thing" has a role in the overall app, and that "thing" I will visualise has some kind of form. What makes this form, and what does it do in order to justify this form? In the case of the input intent, I could assume that we want to know something about locations or distances.

I refactored the code a bit following my revelations in the previous write-up (writing down what I did in this format is one of my ways of tracking whether or not my code isn't just logical but makes sense to my brain when I look back over it). The generic name "Input" that had obscure references to the gestures was renamed to InputIntent and it's events had become abstract ideas of the "intent" an action is supposed to have behind it. The Intefaces named appropriately and the construction of the classes altered to fit their purpose.


#### Making datas

After this refactoring I needed to somehow shoehorn the data I had access to from the gestures into the structure I had created, in order to fit my original scoped out model. The tap needed to get a point and run a hit test, providing the final function with this data. The pan needed to pass a "distance" value and a direction.

The hit test, [info here](https://developer.apple.com/documentation/scenekit/scnscenerenderer/1522929-hittest), provides me with an array of these data structures called `SCNHitTestResult`, which is basically a ray that finds everything under the point (under meaning if you drew a line from the point on the camera and infinitely through the world). There are some options you can pass to this but for now I'll take it as it is. I would likely only ever fetch the first hit object in the scene, as an object would simply like to know if it was the one intended to be selected. But at different angles, and various human thumb sizes, the idea of a "selection area" can vary, so we can run tests on this data to find out what may in fact be the item intended to be selected...

The distance is a percentage of the screen width that was traversed by the user's gesture. To be honest, I'm not entirely sure this is the correct way to go about putting this event together, but in the next iteration I intend to put my ideas into action with a visual model to experiment upon before implementing it in other projects. The direction is a "rightwards" checker the dictates whether the movement was left to right or right to left, as the "distance" value is absolute. Again, I'm trying to deal moreso in positive values rather than negative.

In order to enforce this structuring of the intent, I included this struct for reference:
```swift
struct HorizontalScrollIntentData {
    
    var distance: CGFloat
    var rightwards: Bool
}
```


#### Visualising Datas

The label then finally came into value, when i was then able to output this data into it. However, how this in fact translates into the 3D world is yet to be tested. The next step is to take this data and use it to affect some node in the scene.


[Home](./)