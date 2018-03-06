---
layout: post
title: "Declarations From Extensions Cannot Be Overridden. Are You Sure?"
date: 2016-12-05 13:46:08 -0200
comments: true
categories:
- Swift
share: true
published: true
tags:
- swift extensions objective-c dispatch
image:
  feature: /images/abstract-4.jpg
---

If you found this post, it's likely that you have already encountered the following compile error:

> error: declarations from extensions cannot be overridden yet
>
> P.S. (I love the "yet" part)

It sucks, but it makes sense that you can't override stuff from extensions. Or can you? It turns out, you can. *It's a bit hacky though*. You have been warned.

![Proceed with Caution](/images/extension-overriding/proceed_with_caution.jpg)

<!-- more -->

### Why you shouldn't

Extensions, as the name already says, are supposed to extend/add/include methods to an existing implementation, making them one of the most beautiful things about Objective-C, and now Swift, since you can add code to a class or framework you do not own. Therefore, it makes sense that you're not supposed to "replace" code in extensions, conceptually speaking. That's why the compiler complains when you try to do it.

But there is an exception. Objective-C is a very dynamic language. While Swift attempts to statically dispatch most of its messages, Objective-C dynamically select which implementation to call at run time. So if we exploit our bridge between Objective-C and Swift, we can make the latter a bit more dynamic. Like this:

``` swift
class Spaceship: NSObject { }

extension Spaceship {
    @objc func travel(to destination: SpaceTimeLocation) {
        // TODO: move across universe till we eventualy get there, if we ever do...
    }
}


class TeleportMachine: Spaceship {
    override func travel(to destination: SpaceTimeLocation) {
        location = destination // yup, that easy
        ...
        renderUniverse() // lolwut?
    }
}
```
There you go. We have successfully drilled a wormhole through Swift's fabric, all the way to Objective-C's dynamic dispatch. There are limitations to this, of course. This is possible because our `Spaceship` class is a subclass of NSObject. Make it a root class, and our universe falls apart.

Unfortunately, if you try and make `travel(to:)` generic, you'll be using a Swift-only feature, which means you're not exploiting the ObjC bridge.

So go ahead and do all the things you shouldn't, though you can, even if it's a bit *hacky*.

### Update

On Swift 3 you need to define your method as ObjC compliant using `@objc`.
(Thanks [@bgondim][])

[@bgondim]: https://twitter.com/bgondim
{:target="\_blank"}
