---
layout: post
title: Autolayout Is Hell on Earth
date: 2013-09-12 11:24:56.000000000 -03:00
categories:
- Objective-C
tags:
- autolayout
- constraint
- frame
- ios7
- lag
- layoutifneeded
- profiler
- scroll
- scrollview
- sucks
status: publish
type: post
published: true
share: true
comments: true
---

I believe that every iOS developer is already aware of Apple's new directive
forbidding any *apps* using *frame* to be submitted to the Appstore when the new
iOS 7 goes public. That means that ALL new *app* will have be developed using
this tool created by the son of a devil called *autolayout*.

Anyone that has already used *autolayout* knows that margin, width, height and
other properties are calculated in runtime, therefore, they consume sometimes
unnecessary CPU time. For some inescrutable reason, Apple decided to create this
new concept from scratch to ease working with different sized screens, while
they could easily reuse existing CSS concepts like *margin*, *padding*, among
others. In addition to being extremely confusing (a `UIView's` margin
*constraints* are in its *superview*), having a pitiful syntax 
`(“V:|-(-5)-[view1]-(>=10)-[view2]-(912837)-|”)`, *autolayout* also makes
 everything slow.

**Protip:** if you're configuring your *coinstraints* via code, **never** forget
seting `self.translatesAutoresizingMaskIntoConstraints = NO` in your view. It
took me a couple of coffee cups to realise this was the reason why my 
*constraints* weren't being executing along with `[self layoutIfNeeded]`.

I recently had to work with a `UICollectionView` and the scroll was getting
really laggy. Anytime a new cell was loaded, the framerate dropped. After
spending a few hours trying to find the root of the problem with a couple of
friends (we even considered the problem being the SDK's `dequeue` thanks to 
*Profiler*) some inspired insight hit us and we decided to disable *autolayout*
on the `UICollectionViewCell's` xib and everything flowed like a beautiful
stream under the morning sunlight of tropical woods. So let us analise what
happened: Apple created a new concept, from the grounds, that theoretically
would solve all problems when working with screens of different sizes, but this
devilish concept is composed of runtime calculated values that ruin the *app's*
smoothness. Yep, it gets hard to work happily...

This view that is the `UICollectionView's` cell will not have *autolayout*.
Nobody knows what will happen when we submit the *app* to the Appstore and we
sincerely hope that Apple doesn't mind this view that, although is not
explicitly using *frames*, also is not configured to accept *autolayout*.

I'm yet to find an iOS developer that has nothing to complain about this weird
invention, but, as usual, Apple's "this is what we want, so deal with it" policy
doesn't give us any alternatives. Instead of easing developers' work, they're
making our daily lives every more difficult while <del>Android scores another
point</del> Apple is walking backwards.
