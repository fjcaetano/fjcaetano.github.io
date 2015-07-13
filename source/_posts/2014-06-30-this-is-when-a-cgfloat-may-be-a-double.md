---
layout: post
title: This is when a CGFloat may be a double
date: 2014-06-30 11:00:29.000000000 -03:00
categories:
- Objective-C
tags:
- double
- float
- typecast
status: publish
type: post
published: true
share: true
image:
  feature: /images/computer-data-analytics-blue-background-website-header.jpg
comments: true
---
How would you explain the following code never getting into the `if` clause? Bear in mind I already knew it to be true at least once. I was an absolute true.

``` objc
for (UIView *subview in view.subviews)
{
    CGFloat subviewAlpha = subview.alpha;
    CGFloat myAlpha = 0.15f;
    if (subviewAlpha == myAlpha &&
        [subview isKindOfClass:NSClassFromString(@"_UIPopoverViewBackgroundComponentView")])
    {
        subview.alpha = 0.f;
    }
 }
```

<!-- more -->

Printing the value also proved to be pointless:

``` objc
NSLog(@"%f", subviewAlpha);
// output: 0.150000

NSLog(@"%f", myAlpha);
// output: 0.150000
```

Finally, XCode's debugger shed a dim of light to the real issue. It showed that the true value of `subviewAlpha` is 0.14999999999999999, and as a floating point it's accurate. Meanwhile the value of `myAlpha` was 0.15000000596046448, so logically they are different. But what could be causing this singularity?

Jumping to `CGFloat` definition, we can see that it may be an alias to float or double, depending on the system's architecture (x32 or x64). As I neglected to search, [Apple had it documented](https://developer.apple.com/library/prerelease/ios/documentation/GraphicsImaging/Reference/CGGeometry/index.html#//apple_ref/doc/constant_group/CGFloat_Informational_Macros) and it could have saved me some time (thanks [@gustavocsb](https://twitter.com/gustavocsb/status/482602061352423424), for the link).

[![](/images/Screen-Shot-2014-06-28-at-12.53.35-AM.png)](/images/Screen-Shot-2014-06-28-at-12.53.35-AM.png)

As usual, I solved it the more elegant way I could. "Hey, if `CGFloat` is bipolar, let it tell me how to read it!"

``` objc
for (UIView *subview in view.subviews)
{
    if (subview.alpha == (CGFloat)0.15 &&
        [subview isKindOfClass:NSClassFromString(@"_UIPopoverViewBackgroundComponentView")])
    {
        subview.alpha = 0.f;
    }
 }
```

 Conclusion, always have in mind that typings and comparisons  may not be as obvious as they seem. Be careful and, when in doubt, `typecast` it.
