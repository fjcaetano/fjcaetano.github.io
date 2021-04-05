---
layout: post
title: The Best XCode Tip No One Ever Gave You
date: 2013-04-03 15:25:36.000000000 -03:00
categories:
- Objective-C
tags:
- breakpoint
- xcode
status: publish
type: post
published: true
share: true
comments: true
---

Tired of having to find out where an exception occurred, that was only captured
in the *main()*? Now I'm going to show you the best Xcode tip that no one talks
about. Don't ask me why.

These are the very few steps that will save your life and make your day better.

## Creating an "Exception Breakpoint"

The first thing to do is to access the Breakpoint Navigator, which is the little
breakpoint marker on the top of your Project Navigator. If you didn't know, the
Breakpoint Navigator show all your breakpoints in your project, where you can
easily manage them. (Click on the image to see it bigger)

[![best-xcode-hint-1](/assets/images/best-xcode-hint-1.png)](/assets/images/best-xcode-hint-1.png)

Now that you're in the Breakpoint Navigator, click on the little "+" button on
the bottom left of the screen. A little dialog window will show up and choose the
"Add Exception Breakpoint…" option.

[![best-xcode-hint-3](/assets/images/best-xcode-hint-3.png)](/assets/images/best-xcode-hint-3.png)

Then, the Xcode will ask you some information about the breakpoint you're creating:

[![best-xcode-hint-4](/assets/images/best-xcode-hint-4.png)](/assets/images/best-xcode-hint-4.png)

- Exception: There are three options: "All" to get all types of exceptions; "C++" to get only C++ exceptions; and "Objective-C" to get only ObjC exceptions. I like to leave it as "All".
- Break: Leave it as "On Throw". This way, the execution will stop when your code throws an exception and not when it catches, which is the default on *main()*.
- Action: You can set some action to be performed when the breakpoint is reached like run an Apple Script, shell command and others. I've never used it.
- Options: if you check this option, your code won't stop when the breakpoint hits, making it useless. So leave it unchecked.

Congratulations! You've successfully created an Exception Breakpoint that will
stop whenever something odd happens! Let's try it out!

As an example I've created an empty array and tried to access the object at index
0, which doesn't exists. This is what happened:

[![best-xcode-hint-5](/assets/images/best-xcode-hint-5.png)](/assets/images/best-xcode-hint-5.png)

Whoa! The Xcode stopped precisely where the problem was! Quite awesome, huh? But,
sometimes, it's not that easy to visualise what the problem really is, so if
that's happening to you, just hit "*play*", and the code will keep executing as
if your breakpoint doesn't exists. What happens now, is the *main()* catching
whatever exceptions that may happen.

So you can look at the console to see what the problem was:

[![best-xcode-hint-6](/assets/images/best-xcode-hint-6.png)](/assets/images/best-xcode-hint-6.png)

> "-[__NSArrayI objectAtIndex:]: index 0 beyond bounds for empty array"

Ta daa! I know it's not perfect. It won't get any *signals* (SIGABRT, SIGTRAP),
*flags* or *bad access* kinds of witchcraft, but I think it's super helpful and
I think you guys should know.
