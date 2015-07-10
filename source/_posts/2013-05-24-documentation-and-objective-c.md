---
layout: post
title: Documentation and Objective-C (part 1)
date: 2013-05-24 16:18:54.000000000 -03:00
categories:
- Objective-C
tags:
- appledoc
- article
- documentação
- documentation
- good practice
status: publish
type: post
published: true
share: true
comments: true
---

This is an article I originally wrote for the brazilian online magazine
[DevMedia's Mobile Magazine](http://www.devmedia.com.br/aprenda-a-documentar-seus-projetos-em-objective-c-revista-mobile-magazine-48/27964).
This first part is the article's introduction, so seat back and relax. Soon I'll
post the second - and final - part with a tutorial to the Apple like
documentation generator [appledoc](http://gentlebytes.com/appledoc/).

"In the agile programming environment, using methodologies such as SCRUM, Agile
and Lean, we can't always document our sources. After all, pragmatics as we
developers are, why would we lose time if the documentation won't be compiled,
won't do any difference in the code's performance and demands a considerable
slice of our time? But despite all that, the lack of documentation hurts. A lot.

Who's familiarised, knows that in the ultra accelerated rhythm of *startups*,
where everything is at the top of the list, there's not always time to apply
some of the good programming technics that aren't crucial to the sanity and
speed of the code. Oftenly, there's no time to formally test classes and methods
because of the virtually null due time that is given. It's easy to find
developers awake all night in *hackatons* to successfully deliver *that key*
feature that will make "the whole difference". Test? Document? Review? There's
so much to do and so little time!

That's the reality of many young developers who enter this ultra competitive
environment searching for the dream of running their own companies. The
responsibilty of satisfying potential investors, the pressure for deploys and
the client's needs frequently obfuscate technics that improve development and
maintenance experiences, but that are not considered primordial to the
construction of an application. How often didn't I went back to an undocumented
code done less than two months before and thought "*what the flock does this
loop do?*" or "*why, on earth, is this class here and not there?*" Of course,
when those lines of code were written, everything made perfect sense, but the
moment those *ifs* and *fors* went out of the conscious mind, their meaning were
long gone. After all, quoting the chinese saying: "*the ink is better than memory*".

So let us document. It doesn't hurt, doesn't make you fat and isn't illegal.
Actually, documenting is like eating vegetables: no one really likes it, but we
do it hopping that, in the end, it's worth the result. But unlike the vegetables,
it's proved that documenting helps. Contrary to the common thought, the time
spent documenting a day's work is reasonably irrelevant and the benefit in return
is definitely worthy. With practice and experience, no more than 30 minutes can
be lost documenting everything that was made in a whole day. That way, the
developer stays focused in his activity and doesn't deviates doing other stuff
that draws his attention or stand in his way of writing the best possible
algorithm. Therefore, don't wait until the end of the week, when the work pile
up, part of the features were already forgotten and we're all dying to that
ice-cold friday-night-beer. Personally, I recommend documenting in the end of
the day. In my case, it's always the last thing I do before leaving, because
everything is still fresh in memory and the amount of code produced in one day
doesn't compare to what's done in one week. If that's not enough, I realised
that I do a final unconscious revision before the final *commit* when I'm
passing by the code documenting it.

A well documented code is good for everybody. What would be of us without the
independent frameworks, packages and repositories used daily if they weren't
documented, or even had a bad documentation? Even senior programmers, frequently,
return to Apple's documentation to a better understanding of Cocoa's classes.
Whether consulting a less used protocol, or lower level functions to manage
*sockets*, *threads* or *semaphores*. Nobody can remember everything, so don't
try it, you're not an elephant. It's not rare to find developers who use the
documentation as a last resource to understanding some tool. This line of thought
makes sense if we think that we want everything to be as explained as possible
so we don't lose any time trying to interpretate any possible use, when trying
to comprehend some feature. But we must never forget that even when visiting
forums, asking more experienced developers or reading articles in blogs,
EVERYTHING had a documentation as basis. Well, even this article wouldn't exist
if wasn't for [appledoc](http://gentlebytes.com/appledoc/)'s documentation.

Documenting - or at least commenting - source codes is fundamental to the
intelligibility of the code. Implementing these technics with developers that
never done it, oftenly is seen with prejudice and suspicion that are common to
the staunch and stubborn nature of young programmers. I must confess that I
didn't wanted to document when people first told me to. Moreover, because of
it's so unusual syntax, it's interesting to verbalize what's developed in ObjC
to ease it's lecture, specially by more unexperienced programmers.

As time goes by, with the expansion of the *startup*, the pressure and need of
code documentation is felt. Contrary to many programming languages - such as
Java with it's hideous GUI Javadoc - Objective-C doesn't have an "official"
documentation generator. In our *quest* to find a differentiated framework, which
could make us feel as if we were really making difference, we found the excellent
[appledoc](http://gentlebytes.com/appledoc/) that, using code comments *à la*
Javadoc, generates Apple like documentation, with a docset *automagically*
installed in XCode, static HTML sources which can be uploaded to a cloud (*vide* 
[NSStringMask](http://fjcaetano.github.io/NSStringMask/1.1.2/) which uses
[appledoc](http://gentlebytes.com/appledoc/)) and an interface identical to Cocoa's.

Among [appledoc](http://gentlebytes.com/appledoc/))'s already described advantages,
are also the documentation parsing through code comments, wich allow the developer
to consult the documentation without the need of opening a new window, since
everything is in the code. The integration with XCode allows the visualisation of
tooltips with quick access to the documentation by simply holding the *Option*
key and clicking a method or class. Moreover, by "compiling" [appledoc](http://gentlebytes.com/appledoc/))
in your documented project, the library's docset is already imported to your
*Organizer*. Simple or not? But, undoubtedly, [appledoc](http://gentlebytes.com/appledoc/))'s
main advantage is it's interface that's identical to Apple's documentation. I
think it's very unlikely that there's any ObjC developer that has never read
Cocoa's documentation, be the one embedded on XCode or the on in Apples developers
portal. By reusing the known model, it terminates the problem of having to
familiarise to a new layout."

Soon I'll be posting the second part with a tutorial.
