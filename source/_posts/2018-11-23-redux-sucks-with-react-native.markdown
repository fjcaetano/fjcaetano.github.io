---
layout: post
title: "Redux sucks with React-Native"
date: 2018-11-23 18:21:27 -0200
comments: true
categories:
- react-native
share: true
published: true
image:
  feature: /images/abstract-12.jpg 
---

Redux is hugely widespread as **the** architecture for React and React-Native projects. Its
decoupled nature combined with immutability ensures a truly functional application, when used
correctly. Yes, that's all true.

Redux starts to sound weird when we try to figure out where actions may be used. Specially when your
project has wrappers and HOCs, which might mean actions definitions may not be where they're
actually used.

<!-- more -->

### An iOS Analogy

An application that uses Redux is like an iOS app whose architecture is heavily based on
communicating with `NSNotifications`: someone you don't know who might be posting notifications that
may be listened by other unknown parties. At any moment a new entity might start listening to posted
notifications and might also start posting them. To be honest, it's too decoupled for my taste, if
that's even possible at all.

It is beautiful in theory. However, for real world applications I haven't seen a project where I
didn't struggle to find dispatchers or listeners at some point.

### It's worse for React-Native

The "JavaScript realm" in React-Native runs in a JS VM in the native context, which are
single-threaded. Yes, this means all of the JS code in a React-Native application runs in a single
thread. There are separate threads for shadowing and UI updates, which still have to run in the main
queue, but not JS code.

This means that each Redux action that is dispatched is listened by every single reducer in a single
thread of your application. Competing with other JS code like your components or data processing.
Yes, you might not think so, but your app does data processing: think about your selectors or
chewing data from your API.

That's not pretty. Or performant. You have to be very mindful of which actions you're dispatching
and where you listen to them. Remember that multiple reducers might read a single action.

### It gets worse if you're using Redux-sagas

Redux-saga is a middleware for Redux that, poorly speaking, allow an action to trigger a function
instead of mutating your global state. A saga might also have a side-effect that dispatches new
actions.

Think about that.

> An action that _dispatches_ new actions.

If that's not the definition of a nightmare, I don't know what is.

Don't get me wrong, Redux and Redux-sagas are beautiful and may be good solutions for web
development, they just don't work for mobile applications. You may be thinking that they do work
because there are multiple cases in the market, but then you're missing the concept of "work": it's
not just a matter of being possible and execution. It's also scaling. **Redux does not scale.**

I've seen applications with over 120 reducers and over 150 routes. Can you imagine how the dispatch
log looks for an app that size? Do you think it's performant? Does the application lag?

I'll leave it to you to induce those answers.

### What then?

I'm yet to find a performant architecture to write function applications in React-Native. If we find
a way to instantiate multiple JS VMs and have them communicating; or if Apple releases a
multi-threaded VM. Both solutions would vastly improve the performance of React-Native apps overall,
whether or not they're using Redux.

In the current state of the art, the best alternative is to keep writing imperative applications for
React-Native projects. Research an architecture that best suits your application and go with it.