---
layout: post
title: "RxWebSocket"
date: 2016-02-25 15:55:42 -0300
comments: true
categories:
- Swift
tags:
- cocoapods
- opensource
- reactive
- websocket
share: true
comments: true
github_repo: https://github.com/fjcaetano/RxWebSocket
image:
  feature: /images/abstract-2.jpg
---

Recently we had to integrate a chat-like comment feature to our new [Winnin App][]{:target="_blank"}
Our backend team decided to build it using websockets, so when it came to the
app implementation, my first thought was to search for an opensource swift framework
that did confirm to the [Websocket Protocol](http://tools.ietf.org/html/rfc6455){:target="_blank"}.
We decided to go with [Starscream][]{:target="_blank"} since
it seemed simple and reliable enough.

<!-- more -->

In the first drafts of the new app, a decision was made to adopt reactive programming
in the app, more specifically [RxSwift][]{:target="_blank"}. Many sprints later, we've limited our
Rx use to cross-object events and network communications. Not surprisingly, we
wanted to use websockets reactively.

## [RxWebSocket][]{:target="_blank"}

We designed RxWebSocket to be as lightweight as possible, truly, just making an
abstraction layer over [Starscream][]{:target="_blank"} to make it reactive.

All you need is to listen to the `stream` property which is an `Observable<StreamEvent>`.

``` swift
public enum StreamEvent {
    case Connect
    case Disconnect(NSError?)
    case Pong
    case Text(String)
    case Data(NSData)
  }
```

Using an enum as the element type allows us to have every interaction with the
websocket server in one property that is also easily filtered by message type. If
we need to know when the websocket connects, we can simply filter the stream:

``` swift
socket.stream
  .filter {
    switch $0 {
    case .Connect: return true
    default: return false
    }
  }
```

If your websocket messages the client with a JSON object that you need to parse:

``` swift
socket.stream
  .flatMap { event -> Observable<AnyObject> in
    switch event {
    case .Text(let text):
      return Observable.just(try NSJSONSerialization.JSONObjectWithData(text.dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments))
    default: return Observable.empty()
    }
  }
```

We know it's still crude and quite simple, which is our intention, but we'll improve
[RxWebSocket][]{:target="_blank"} with time. Every suggestion, comment, critic, PR,
etcetera is welcome.

You can check an actual implementation in the example project or by running
``` bash
pod try RxWebSocket
```

Enjoy!


[RxWebSocket]: https://github.com/fjcaetano/RxWebSocket
[RxSwift]: https://github.com/ReactiveX/RxSwift
[Winnin App]: https://itunes.apple.com/us/app/winnin-battle-best-videos./id1073178885
[Starscream]: https://github.com/daltoniam/Starscream
