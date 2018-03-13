## Hi! 👋

After getting to the point with a few of my other components for a 3D interactive thing (world/game/etc.), I have a basic [tile map](https://louisfoster.github.io/ios-test-level-map-1/) and [camera harness](https://louisfoster.github.io/ios-test-camera-harness-1/), where I needed to handle some form of "Input" event that came from various kinds of "Interface" events, I decided to build these elements. I've been pretty inspired over this weekend while building these things (nb. after writing this, the development of these projects may infact extend beyond this initial weekend...) so for this hugely important part to come together is exciting. 

I essentially need to be able to have a decoupled system whereby anything can extend the "input" class, which receives calls from notifications that this input has occurred, and act accordingly. Additionally, I need to manage the various interfaces that may trigger the notifications and pass data on regarding what happened when the event occurred.


### Contents

- [Start](./start) (refers to this [commit](https://github.com/louisfoster/ios-test-input-system-1/tree/fc64db5cd0cd8fca1008a8d188f107c0df81be7f))

- [Datas](./datas) (refers to this [commit](https://github.com/louisfoster/ios-test-input-system-1/tree/7929a0d59d744b4f9362e9b69cd8c6b41c3a3072))

- [Nodes](./nodes) (refers to this [commit](https://github.com/louisfoster/ios-test-input-system-1/tree/d56a38c7d436e6e52d5debdfb7243979e766a60d) and previously [this](https://github.com/louisfoster/ios-test-input-system-1/tree/8d8d2a6805bd41ca514c8b77217de43e84a318f4) and [this](https://github.com/louisfoster/ios-test-input-system-1/tree/22a0ca090b53cfbc75111f96722c10e6cd82d1bb))