---
layout: post
title: "Protip: UIViewControllerAnimatedTransitioning + snapshots"
date: 2017-12-05 18:06:12 -0200
comments: true
categories:
- swift
share: true
published: true
image:
  feature: /images/abstract-7.jpg
---

When creating custom animations for view controller transitions, it is recommended
to use snapshots of the views being animated. However, UIKit doesn't always make
things crystal clear.

If you find yourself with broken autolayout or views incorrectly configured after
enabling your transition, try **creating the snapshots after adding your view to
`containerView`**.

<!-- more -->

```swift
func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromVC = transitionContext.viewController(forKey: .from),
        let toVC = transitionContext.viewController(forKey: .to),
        let fromAnimatedView = fromVC.animatedView.snapshotView(afterScreenUpdates: true),
        let toAnimatedView = toVC.animatedView.snapshotView(afterScreenUpdates: true) else {
        return transitionContext.completeTransition(false)
    }

    let containerView = transitionContext.containerView

    [fromAnimatedView, toAnimatedView].forEach(containerView.addSubview(_:))

    // Now you got yourself broken views. Hooray!
    ...
}
```

The code above might not work. Your `toVC`'s view might end up completely broken
and your snapshots may have the wrong frame and contents. To fix it, simply move
the snapshots creation to after adding your destination view controller's view to
`transitionContext.containerView`.

If you just try it after your `toVC` has ended initializing its views (i.e. after
`viewDidLoad` has been called) it won't work, even if you force the view to be
loaded. You truly need to create your snapshots after the `containerView`.

```swift
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to) else {
              return transitionContext.completeTransition(false)
      }

      let containerView = transitionContext.containerView
      containerView.addSubview(toVC.view)

      guard let fromAnimatedView = fromVC.animatedView.snapshotView(afterScreenUpdates: true),
          let toAnimatedView = toVC.animatedView.snapshotView(afterScreenUpdates: true) else {
              return transitionContext.completeTransition(true) // toVC.view was already added to the container
      }

      ...
  }
```

Boom! Done. Now it works 🎉
