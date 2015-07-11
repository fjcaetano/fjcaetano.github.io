---
layout: post
title: 'Protip: Unregistering a UICollectionView header/footer'
date: 2014-05-16 16:33:52.000000000 -03:00
categories:
- Objective-C
tags:
- class
- register
- supplementary
- uicollectionview
- unregister
- view
status: publish
type: post
published: true
meta:
share: true
comments: true
image:
  feature: /images/computer-keyboard-stones-on-grass-background-header.jpg
---

You can unregister a UICollectionView supplementary view by re-registering it
with `nil` class as stated in [Apple's docs](https://developer.apple.com/library/ios/documentation/uikit/reference/UICollectionView_class/Reference/Reference.html#//apple_ref/doc/uid/TP40012177-CH1-SW10).
(Remember to use the same `reuseIdentifier`).

{% highlight objc %}
[self.collectionView registerClass:nil
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:kHEADER_IDENTIFIER];
{% endhighlight %}

<!-- more -->

But don't forget to overwrite the [`[UICollectionViewDelegateFlowLayout collectionView:layout:referenceSizeForHeaderInSection:]`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewDelegateFlowLayout_protocol/Reference/Reference.html#//apple_ref/occ/intfm/UICollectionViewDelegateFlowLayout/collectionView:layout:referenceSizeForHeaderInSection:)

{% highlight objc %}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
{% endhighlight %}

Header or footer, depending on your need.
