---
layout: post
title: You Shouldn't Use Git Blame to Blame on People
date: 2014-07-23 17:22:57.000000000 -03:00
categories:
- git
tags:
- blame
- changelog
- git
- xcode
type: post
published: true
share: true
comments: true
image:
  feature: /images/computer-keyboard-stones-on-grass-background-header.jpg
---

Have you ever used `git-blame` to blame on people? I have and I was wrong more often than I was right. When I wasn't the one blaming others, the fingers almost always pointed at me when something went wrong. The problem with "default" `git-blame` and Xcode's blame view is that it only shows the last person that committed the lines in question and, not necessarily, wrote them.

<!-- more -->

Here where I work we have some code guidelines that not always are followed. Annoying as I am, usually I'm the one who fixes what is not according. Therefore, my name comes up in Xcode's blame view more  often than others.

If you really need to find out whoever wrote that dreadful condition that crashes your app, use the `git-blame` command line with the "-n" option. It'll show the name of the person that first introduced that line and, quite probably, wrote it.

Or maybe, even better, get the changelog and the names of who touched a specific line of code with `git-log` "-L" option:

[![git-log -L](/images/Screen-Shot-2014-07-23-at-5.31.32-PM.png)](/images/Screen-Shot-2014-07-23-at-5.31.32-PM.png)

Thanks to: [http://stackoverflow.com/questions/8435343/retrieve-the-commit-log-for-a-specific-line-in-a-file](http://stackoverflow.com/questions/8435343/retrieve-the-commit-log-for-a-specific-line-in-a-file)
