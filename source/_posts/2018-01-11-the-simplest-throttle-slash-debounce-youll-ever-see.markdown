---
layout: post
title: "The Simplest Throttle/Debounce You'll Ever See"
date: 2018-01-11 11:12:28 -0200
comments: true
categories:
- swift
share: true
published: true
image:
  feature: /images/abstract-8.jpg
github_repo: https://gist.github.com/fjcaetano/ff3e994c4edb4991ab8280f34994beb4
---

One of these days I needed a _debounce_ on Swift to ensure some block of code
would only be executed once in a period of time. _Debounces_ are quite simple so
I implemented a first draft of it.

Not long after that, I also needed a _throttle_ to skip repetitive calls to a
different block of code. Not too different from a _debouce_, but not quite the
same.

<!-- more -->

Bouncing around in the interwebs (pun intended), searching for a simple
implementation for _throttle_, [all][] [I][] [could][] [find][] [was][]
[nonsense][]... and
overcomplicated.

So I created an extension on `DispatchQueue` (where it should be):

{% gist ff3e994c4edb4991ab8280f34994beb4 %}

_TA DAA_ 🎉

<!-- LINKS -->

[all]: https://gist.github.com/AndreyPanov/f3c9ccdf1afc99b07d919c3f119b4d9b
{:target="\_blank"}
[I]: https://github.com/webadnan/swift-debouncer
{:target="\_blank"}
[could]: https://gist.github.com/simme/b78d10f0b29325743a18c905c5512788
{:target="\_blank"}
[find]: https://stackoverflow.com/questions/27116684/how-can-i-debounce-a-method-call
{:target="\_blank"}
[was]: https://gist.github.com/pixelspark/50afabc9ce29412cca7ef6d6323da7de
{:target="\_blank"}
[nonsense]: https://danielemargutti.com/2017/10/19/throttle-in-swift/
{:target="\_blank"}
