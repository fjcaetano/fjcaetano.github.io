---
layout: post
title: "Using native and non-native animations together"
date: 2019-11-11 17:36:36 -0300
comments: true
categories: 
  - React-Native
  - Animations
share: true
published: true
image:
  feature: /assets/images/abstract-5.jpg
---

React-Native animations has some limitations on what can be done using the native driver and what
can only be executed in the Javascript realm. Animating colors is an example of property you can
only animate using the JS interpreter, which is super slow and will probably affect your
performance. If you try and hang a few `interpolates` in that `Animated.Value`, you'll have a bad
time trying to have fluid and seemless animations.

If only there was a way of using one `Animated.Value` to drive another `Animated.Value`...

![thinking gif](https://media.giphy.com/media/2H67VmB5UEBmU/giphy.gif)

> 💡 What if you use a native animation's listener to drive a non-native animation?

<!-- more -->

Yes, that's possible. No, using a listener doesn't automatically make your animation non-native.
This means you'll need multiple `Animated.Values` (if that wasn't clear yet):

```js
const nativeAnim = new Animated.Value(0); // 1
const jsAnim = new Animated.Value(0);

// component did mount
useEffect(() => {
  // this is the trick: drive the non-native animation by adding a listener to the native animation
  const nativeListener = nativeAnim.addListener(Animated.event([{ value: jsAnim }])); // 3
  return () => {
    nativeAnim.removeListener(nativeListener);
  };
}, []);

// backgroundColor can only be animated using a non-native animation
const bgColorStyle = jsAnim.interpolate({ // 4
  inputRange: [0, 100],
  outputRange: ['red', 'black'],
});

// using the native driver still works
const positionStyle = {
  transform: [{
    translateX: this.nativeAnim.interpolate({
      inputRange: [0, 2],
      outputRange: [0, 1],
    }),
  }],
};

...

<ScrollView
  onScroll={
    Animated.event([{
      nativeEvent: {
        contentOffset: { x: nativeAnim }, // 2
      },
    }, { useNativeDriver: true }])
  } // 🎉
/>
```

Let's recap what's up there:

1. We defined `nativeAnim` and `jsAnim`, which are `Animated.Value`.
2. This value is driven by a **native** `Animated.event` triggered by a ScrollView's offset.
3. We added a listener to `nativeAnim` to drive a second `Animated.Value`, by using a non-native
`Animated.event`.
4. The non-native animation (`jsAnim`) is then used to animate a `backgroundColor`, which is a style
property that can only be animated by non-native animations.

That truly works, check it out:

<div data-snack-id="Sk-4eLvir" data-snack-platform="ios" data-snack-preview="true" data-snack-theme="light" style="overflow:hidden;background:#fafafa;border:1px solid rgba(0,0,0,.08);border-radius:4px;height:505px;width:100%"></div>
<script async src="https://snack.expo.io/embed.js"></script>