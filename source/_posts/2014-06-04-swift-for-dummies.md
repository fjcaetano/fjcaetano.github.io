---
layout: post
title: Swift for Dummies
date: 2014-06-04 13:57:21.000000000 -03:00
categories:
- Swift
tags:
- apple
- ios
- swift
- wwdc
- wwdc14
status: publish
type: post
published: true
share: true
comments: true
image:
  feature: /images/wwdc14-home-branding_2x.png
---

At WWDC 14, Apple introduced its new programming language: Swift. Nobody knows
for sure what will happen to Objective-C, but one can only guess it won't be
around for long. My guess is that Apple will be accepting ObjC apps up till iOS
10, but that is just my guest.

<!-- more -->

By attending to the WWDC I had the opportunity of directly contacting Apple's
engineers and insights most of people couldn't, so in the next posts I'll cover
the basics of Swift.

It doesn't matter if you're new to iOS or an experienced programmer. Now, we're
all in the same boat. We all have to learn Swift from scratch, so forget
everything you know about Objective-C and get ready to learn this brand new
language. By the way, its potential is overwhelming.

## The basics

As far as I could tell, Swift borrows concepts from Python, Javascript and even
Java. It's syntax also resembles these languages very much.

You can forget about pointers for now, most of what we'll be using in Swift is
passed through references. No more asterisk (woohoo \o/).

Swift plays with the concepts of variables and constants. There's no type
definition to neither of those just the declares var, for variables, and `let`
for constants. As you may have figured out, constants can't be altered. We'll
cover when to use it in a few steps.

{% highlight swift %}
var foo = "this is getting good"

let x = 42
{% endhighlight %}

Yep, there are no semi-colons at the end of statements.

Switches are extremely powerful. `Cases` can be variables, strings, even a range
 of numbers. Also, cases don't automatically fall through the next condition, so
  there's no need to `break`.

{% highlight swift %}
switch myvar {
    case 4:
        // do something

    case someOtherVar:
        // this is getting wild

    case "string":
        // holy cow!

    case 1..4:
        // ok, this is awesome
    default:
        // something unimplemented
}
{% endhighlight %}

There's also no need for surrounding parenthesis when working with conditions,
unless it's a complex condition, as usual. Switches in Swift (yep, try saying
that three times) are exhaustive. That means that you must either supply `cases`
for every possible condition or a `default` to handle everything else.
XCode will error at compile time if you don't.

The final topic of this post is how you'll print output to the console. It's as
simple as calling `println()` (it's a function) and you're done.
Formatting strings is also awsome:

{% highlight swift %}
var name = "Flavio"

println("Hello \(name)!")
// Hello Flavio!
{% endhighlight %}

This is enough to get started and get familiar with Swift. Go ahead, poke it
around, but don't try to get fancy just yet. I'll be covering more in the next
few days.
