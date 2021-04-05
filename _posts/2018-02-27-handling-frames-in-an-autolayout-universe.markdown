---
layout: post
title: "Handling Frames In An AutoLayout Universe"
date: 2018-02-27 15:20:08 -0300
comments: true
categories:
- Swift
share: true
published: true
image:
  feature: /assets/images/abstract-10.jpg
---

As frameworks improves, as our knowledge of it, we should leave [our prejudices][]
in the past. It is without question that AutoLayout has become much beloved and
necessary as it moves forward. Its API has improved so drastically as to discard
the need for third-party libraries.

However, as far as AutoLayout has progressed, it may still be simpler to handle
frames in some cases. But how to join both worlds without colliding them and
throwing a bunch of warnings in your console? Or worst: in your IB…

<!-- more -->

## Customize `layoutSubviews`

Depending on the simplicity of what you want to achieve, implementing your own
version of `layoutSubviews` without relying on the SDK can be simple and effective:

```swift
override func layoutSubviews() {
    _ = subviews.reduce(0) { (x, view) -> CGFloat in
        let size = view.intrinsicContentSize
        view.frame = CGRect(
            origin: CGPoint(x: x, y: 0),
            size: size)
        return view.frame.maxX + Constants.spacing
    }
}
```

## Adopting `intrinsicContentSize`

As you may have noticed in the example above, by overriding `intrinsicContentSize`
you can have a view that defines its own size without depending on constraints
or content.

```swift
override var intrinsicContentSize: CGSize {
    return isExpanded ? Constants.expandedSize : Constants.regularSize
}
```

Btw, it's animatable 💖

[our prejudices]: /post/autolayout-is-hell-on-earth/
{:target="\_blank"}
