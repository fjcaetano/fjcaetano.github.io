---
layout: post
title: Cocoapods and resource_bundles
date: 2014-04-15 17:12:13.000000000 -03:00
categories:
- Objective-C
tags:
- cocoapods pod
status: publish
type: post
published: true
share: true
comments: true
image:
  feature: /images/curacao-island-in-caribbean-sea-header.jpg
---

Anyone that have recently developed any pods for Cocoapods know that resources
should be gathered using the [`resource_bundles`](http://guides.cocoapods.org/syntax/podspec.html#resource_bundles)
option. What is quite hard to figure out is how, exactly, to access those
resources once they're set up in the `bundle`. It seems obvious now that I got
it working, but I struggle a lot since there wasn't anything in Stackoverflow or
anywhere else that provided the answer I came up with.

After setting up the `resource_bundles`, Cocoapods copies the resources found in
a "resources" folder within the Pods project, but none of them are added in the
target's "Copy bundle resources". For that reason, I couldn't access any of the
Pod's images or *xibs* in my project. Every time XCode threw me this error:

> 'Terminating app due to uncaught exception 'NSInternalInconsistencyException',
> reason: 'Could not load NIB in bundle:<{PATH_TO_APP}> (loaded)' with name
> '{VIEW_CONTROLLER_NAME}'

The obvious solution that wasn't listed anywhere is using the Cocoapods
generated bundle (which the folder actually doesn't exist) as a `NSBundle`:

{% highlight objc %}
NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"MyBundle" ofType:@"bundle"];

NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];

MyViewController *viewController = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:bundle];

[self.navigationController pushViewController:viewController animated:YES];
{% endhighlight %}

Yes, it's that simple, that obvious, though it's not listed anywhere. I believe
to be prudent and convenient to write about it in order to help anyone who
encounter themselves in the same situation as I did.
