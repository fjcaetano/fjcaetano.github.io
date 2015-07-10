---
layout: post
title: Cocoapod Badges
date: 2013-06-03 16:15:45.000000000 -03:00
categories:
- Objective-C
tags:
- badge
- cocoapod
- code climate
- django
- gemnasium
- github
- objc
- pypi
- pypip
- shield
- travis ci
status: publish
type: post
published: true
share: true
comments: true
github_repo: https://github.com/fjcaetano/cocoapod-badges
---

In any kind of environment, visual marks ease and enhance the comprehension of
information. Countless researches studied the best way to display data, which
colors induce what emotions, the association of geometric shapes with pre-formed
concepts. The fact is that a sign or plaque draws much more attention than plain
text. After all, an image is worth a thousand words, therefore, an image sends a
much more significant message than some written words.

That's one of the reasons many development tools have featured *badges* (or 
*shields)* to inform the status of an application/framework/library/*etcetera*.
It's the case of [Travis CI](http://about.travis-ci.org/docs/user/status-images/), 
[Code Climate](https://codeclimate.com/changelog/510d4fde56b102523a0004bf), 
[Gemnasium](http://blog.tech-angels.com/post/43141047457/gemnasium-v3-aka-gemnasium),
among others, all following [olivierlacan/shields`](https://github.com/olivierlacan/shields)
trend, available Github.

I'm an iOS developer and previously have worked with Python/Django (though I
still fool around) and I've always found very interesting this creative way of
sharing the state of a service dynamically, but sadly, there were no solution to
Python nor iOS featuring *badges* (except for Travis CI for tests). But,
recently, appeared - out of nowhere - [pypip's](https://pypip.in/) *shields* for
Python packages that allows the visualisation of the latest available version of
a package on [pypi](http://pypi.python.org) or how many downloads some *release
*had*.* When I came aware if it I resented for taking so long for solution so
simple and effective to come up (or at least for **I** to discover it)... but it
got over the top when I found out... or better, **did not found out** a similar
solution for [Cocoapods](http://cocoapods.org).

I'm one of those who doesn't miss a chance to solve a problem and endeavour an
opportunity. That's how the [Cocoapod Badges](http://fjcaetano.github.io/cocoapod-badges/) 
project started. Since Cocoapods doesn't provide an API, any info on the number
of *users/downloads*, nor any kind of useful data, it proved to be a challenge,
and all I could use had to be what was at hand: the latest version of a *pod*.
But even though, mistaken are those who thought it easy. As mentioned, there's
no API!

# Cocoapod Badges ![NSStringMask 1.1.2](https://cocoapod-badges.herokuapp.com/v/NSStringMask/badge.png)

Digging through Cocoapod's and [Cocoadocs'](http://cocoadocs.org) websites, I
tried, first, to use the [documents.jsonp](http://cocoadocs.org/documents.jsonp) 
file that I found in the *source* of the *pod*'s documentation website, however,
I soon gave up for realising that its update frequency is too high (above one
hour). At last, I had to content with the unfortunate `/search?q=` requested
when searching for a *pod* in Cocoapod's main page. At first, it looked like an
excellent solution since it returned a `json` object with some info, until I
realised that inside the object was a string with some `html` code and only
inside that code was the *pod*'s latest version. "*God dammit!*" Now I have to
run a request on a "pseudo-*webservice*" and parse it with `XPATH` to get the
latest version!

Super easy! But, as my mother would on a brazilian saying: "*few shit is
silliness*". The damned "API" doesn't return the requested *pod*, but anything
with the searched string. To get something more useful, I figured that 
`/search?q=name:POD_NAME` searches only in the *pod*'s name and not in its
description, what significantly reduces the results, specially when dealing with
popular *pods* such as [AFNetworking](http://afnetworking.github.io/AFNetworking/index.html).

After all that suffering, I finally got the information I wanted, but then, how
do I show it in an image? Olivier Lacan's repo, that enabled all the existing 
*badges,* provides, beyond the *.png* to existing services, `.SVG` vectorial
files that render `xml` data to images. So, accidentally, I double-clicked the 
`.SVG` file and the holy Google Chrome opened it as an image! Finally good news!
As the information about the version is in plain text inside the `xml`, all I
had to do was to set the `mimetype` so Django could provide the file as an image.

1 [Heroku](http://heroku.com) *dyno* later and the service is available fulltime
(depending on Cocoapods website) through the images' url:

> `http://cocoapod-badges.herokuapp.com/v/$PODNAME/badge.png`

All you have to do is replace the `$PODNAME` with the name of the pod you want.
Simple and easy, isn't it? Use it at will! And suport the Github repo!
