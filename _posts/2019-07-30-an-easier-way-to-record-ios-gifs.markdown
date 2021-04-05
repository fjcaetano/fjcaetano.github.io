---
layout: post
title: "An easier way to record iOS gifs"
date: 2019-07-30 10:56:44 -0300
comments: true
categories: 
- bash
- ios
share: true
published: true
image:
  feature: /assets/images/abstract-1.jpg 
github_repo: https://github.com/fjcaetano/ios-simulator-gif
---

One of these days, I needed a tool to record gifs from iOS devices to provide a better description
to our PRs here at Work&Co. It wasn't uncommon for us to open PRs with no description at all or with minimum overview of what was being accomplished.

Let me tell you something: design matters at this company! It's hard to create amazing digital
products and even harder to assess its code. We decided we could do better with our PRs.

Recording gifs from iOS devices has never been easy. You can find a bunch of tools online that are
paid or simply don't work. The alternative was to launch QuickTime, record a video and convert it to
gif. That's a lot of work. It's tiresome and time consuming. We we could do better!

![Example GIF](https://github.com/fjcaetano/ios-simulator-gif/raw/master/example.gif?raw=true)


<!-- more -->

## We did better

It turns out that, right now, it's awfully simple to record a gif from your iOS simulator. All you 
need to do is run one simple command:

```sh
$ ios-simulator-gif yolo.gif
```

This will immediately start recording the gif and stop when you press any key. The gif will be saved
to the `yolo.gif`. Need to customize the gif? No problem at all! These are the arguments accepted
by `ios-simulator-gif`:

| Options             | Description               | Default value  |
| ------------------- | ------------------------- | :------------: |
| -r, --rate          | Framerate of the output   |      `6`       |
| -f, --format        | Output format             |     `gif`      |
| -vf, --video-filter | Video filter for `ffmpeg` | `scale=320:-1` |
| -h, --help          | Outputs helper message    |      N/A       |

Need more?? We got you covered fam! Anything you pass after `--` will be sent directly as args to `ffmpeg`!

```sh
$ ios-simulator-gif -r 30 example.gif -- -b 128k
```

You're welcome!

## Installation

Assuming that you have [Homebrew][1] installed, execute the following steps:

1. Use the repository as a "tap" (alternative package repository):

```sh
$ brew tap fjcaetano/ios-simulator-gif https://github.com/fjcaetano/ios-simulator-gif.git
```

2. Install ios-simulator-gif (and dependencies):

```sh
$ brew install fjcaetano/ios-simulator-gif/ios-simulator-gif
```

If you want to install it directly, that's on you. If you can't figure that out, and don't know what you're doing, just install [Homebrew][1] and be happy.

[1]: https://brew.sh/