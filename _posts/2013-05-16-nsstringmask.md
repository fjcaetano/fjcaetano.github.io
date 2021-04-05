---
layout: post
title: 'NSStringMask: Simplifying masks'
date: 2013-05-16 14:27:10.000000000 -03:00
categories:
- Objective-C
tags:
- cocoapods
- gist
- github
- mask
- objc
- regex
- string
status: publish
type: post
published: true
share: true
comments: true
github_repo: https://github.com/fjcaetano/NSStringMask

---

When developing, we often come across code we've seen hundreds of times that we
just copy and paste from project to project. Sometimes it's so banal that it's
not worth trying to improve, change or even modularize it. Ctrl-C + Ctrl-V may
be the cheapest and fastest solution, ergo, the best.

This is the kind of situation we see when masks must be applied to *text fields*
such as Social Security Numbers (SSN), Telephones, Zip Codes, and so on. Those
awful few dozens of lines we copy from one `textField:shouldChangeCharactersInRange:replacementString:`
to the other. It never changes because it works. There's no need to improve it.
It's always the same. But I've got tired of it. That nasty code that, in a well
structured class, can be as a mole in a beautiful woman's face.

A few days ago I got some spare time and I started working on something I though
could come handy. So how do you simplify and generalise this problem that every
developer has to face at least once? Easy! *Regex*! Wait.. You sure it's easy? I'll
tell you, it wasn't easy, but we're talking about patterns in varying occasions
and, as I visualised it, *regex* is the best, simplest and most "approachable"
solution. I mean, everybody knows a little bit of *regex*.

While modelling, I wanted to make it as simple and as clean as possible, therefore,
for now, there are only two classes, and only one method you'll really use, but
you can read the [complete documentation](http://fjcaetano.github.io/NSStringMask/).
From now on, I'll present a superficial approach to introduce this small library.

Fork the [Github Repo](https://github.com/fjcaetano/NSStringMask)!

## NSStringMask

The NSStringMask is the main class responsible for applying your masks to the
NSStrings. Among it's methods the only noteworthy is
[`[NSStringMask maskString:withPattern:placeholder:]`](http://fjcaetano.github.io/NSStringMask/Classes/NSStringMask.html#//api/name/maskString:withPattern:placeholder:).

It formats the given `string` based on the `pattern` you provide, filling the
voids with the `placeholder`. It automatically creates an instance of
NSRegularExpression with the option `CaseInsensitive`, so if you need a different
option, you may use the alternate method which expects a *regex* instead of `pattern`.

There's also an alternative method that receives no `placeholder` (same as `nil`),
in this case, when the given `string` is shorter than expected, instead of
applying the mask, the method will return a cleaned *string* having only the
valid characters based on [`validCharactersForString:`](http://fjcaetano.github.io/NSStringMask/Classes/NSStringMask.html#//api/name/validCharactersForString:).

### Important Note

Doesn't matter if providing a `pattern` or an instance of *regex*, the regular
expression **must** have capturing groups (parentheses). This is because the
class understands that everything that is not within parentheses is part of the
mask and must be interpreted as literal characters!

Suppose you're formatting a SSN, whose *regex* pattern is `\d{3}-\d{2}-\d{3}`.
If you provide that *regex*/pattern, nothing will be formatted because the class
will think that `\d{3}` is part of the mask, and not 3 numbers that should go there.

The correct usage is: `(\d{3})-(\d{2})-(\d{3})`

{% highlight objc %}
// RIGHT:
NSString *result = [NSStringMask maskString:@"12345678" withPattern:@"(\d{3})-(\d{2})-(\d{3})"];
// result = @"123-45-678"

// WRONG:
NSString *result = [NSStringMask maskString:@"12345678" withPattern:@"\d{3}-\d{2}-\d{3}"];
// result = nil
{% endhighlight %}

**Obs**: If Xcode is showing a *warning* about unknown escape sequences, try
adding double slashes (`\\d`)

## UITextFieldMask

This is a subclass of UITextField, so you can set your *nibs* to use this class
and automatically apply masks to your *text fields*.

Obviously, you must provide a mask to transform your *strings*, and it's
recommended that you do so when initialising your *view* or *view controller*.
So you should set the text field's mask inside `viewDidLoad` or `awakeFromNib`.

Suppose you have a *view* with an *outlet* to an UITextFieldMask named `textFieldMask`:


{% highlight objc %}
- (void)awakeFromNib
{
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\d+)"];

    textFieldMask.mask = mask;
    textFieldMask.delegate = self;
}
{% endhighlight %}

A question for you: what does that mask accepts?

## Installation

You can install it from [Cocoa Pods](http://cocoadocs.org/docsets/NSStringMask),
or clone the project from the [Github Repo](https://github.com/fjcaetano/NSStringMask)
and copy the files in the folder `Classes`.

### Helpful stuff

I've also created [this gist](https://gist.github.com/fjcaetano/5600452) with
some common patterns. Feel free to improve it!

{% gist 5600452 %}
