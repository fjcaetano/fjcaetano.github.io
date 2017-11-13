---
layout: post
title: "ReCaptcha Reaches 1.0"
date: 2017-11-13 15:04:44 -0200
comments: true
categories:
- swift
share: true
published: true
image:
  feature: /images/abstract-6.jpg
github_repo: https://github.com/fjcaetano/ReCaptcha
---

With the new Swift 4 support, [ReCaptcha][] has finally reached a stable release!
Now you can safely use Google's [Invisible ReCaptcha][] in your app!

Using the JS API, [ReCaptcha][] tries to validate the challenge automatically and
retrieve a token, however, if the API can't ensure the user is human, a challenge
may be presented.

![Example Gif 2](https://raw.githubusercontent.com/fjcaetano/ReCaptcha/master/example2.gif){: width="315px"}
![Example Gif](https://raw.githubusercontent.com/fjcaetano/ReCaptcha/master/example.gif){: width="315px"}

<!-- more -->

## Setup

Register a new site to use __Invisible reCaptcha__ at the [admin page][]. Make sure
to add correct domain owned by you or your company!

This will return you two keys: a _Site key_ and a _Secret key_. The former is the
public key which will be used in your frontend to start the validation. This is
the key must be used in the app. **DO NOT USE THE SECRET KEY**!

The _Secret key_ is for the validation in the server side of the application!

#### _Warning_ ⚠️

Beware that this library only works for Invisible ReCaptcha keys! Make sure to
check the Invisible reCAPTCHA option when creating your [API Key](https://www.google.com/recaptcha/admin).

#### Installation

You can install [ReCaptcha][] using [CocoaPods][], [Carthage][] or as a submodule.
The library comes with a [RxSwift][] extension.

##### CocoaPods

Add the following to your Podfile:

``` ruby
pod "ReCaptcha", '~> 1.0'
# or
pod "ReCaptcha/RxSwift", '~> 1.0'
```

##### Carthage

``` ruby
github "fjcaetano/ReCaptcha" ~> 1.0
```

If you decide to use the reactive extension, be sure to link both frameworks
`ReCaptcha` and `ReCaptcha_RxSwift` to your project. The latter, simply contains
the reactive extension for the `ReCaptcha` class.

### iOS Setup

Open your project's `Info.plist` file and add two entries:

- **ReCaptchaKey**: The _Site key_ created in the previous step.
- **ReCaptchaDomain**: A valid domain registered with the key in the previous step.

These values may also be sent as parameters to `ReCaptcha()` init. In this case,
the parameters will override the values in the `Info.plist`.

## Code

Before starting the validation, you must call the `configureWebView(_:)` method.
This is for when the webview needs to be presented for the user to complete the
[ReCaptcha][] challenge. If this method is not called, the validation may fail.

``` swift
recaptcha.configureWebView { [weak self] (webview: WKWebView) in
    // Configure webview for presentation
    // Make sure its frame is not CGRect.zero
}
```

This is the moment to add AutoLayout constraints and store a reference to the webview,
which will already have a superview that is provided when starting the validation.

The `configureWebView(_:)` won't necessarily be called. Only if the invisible
validation is not possible.

### Validation

To start the validation, _per se_, you must call the `validate(on:)` method.

``` swift
recaptcha.validate(on: view) { [weak self] (result: Result<String, ReCaptchaError>) in
    print(try? result.dematerialize())
}
```

The `view` given as parameter, must be visible, i.e. be in the active window
hierarchy, its bounds must be valid and it can't be marked as `hidden`. This view
will contain the ReCaptcha webview as a subview.

By default, [ReCaptcha][] won't remove the webview from its superview, so it may
be interesting to have some clean up after the closure is called.

### Error Handling

[ReCaptcha][] may throw you some errors if incorrectly configured or when execution
fails.

- `ReCaptchaError.htmlLoadError`: If by some reason, the library's bundle is
unreachable, the template HTML won't be loaded.
- `ReCaptchaError.apiKeyNotFound`: No API key has been provided to the library.
Either set a `ReCaptchaKey` entry in the app's `Info.plist` or pass it as argument
to `ReCaptcha`'s init.
- `ReCaptchaError.baseURLNotFound`: No domain has been provided to the library.
Either set a `ReCaptchaDomain` entry in the app's `Info.plist` or pass it as
argument to `ReCaptcha`'s init.
- `ReCaptchaError.wrongMessageFormat`: This means the JS context provided an
unexpected message to the API. Shouldn't happen, so, if it does, be sure to
[open an issue][].
- `ReCaptchaError.unexpected(Error)`: 💩 happens ¯\\_(ツ)\_/¯. The only moment this
error could be thrown is if JavaScript sends an error. Shouldn't happen, but if
it does, don't be shy and [open an issue][].

## Firewall bypass

If your firewall is blocking Google's ReCaptcha, or if you're behind the [Great
Firewall of China], you may use an alternate endpoint for the JS API that points
to `https://www.recaptcha.net/recaptcha/api.js`:

``` swift
try ReCaptcha(endpoint: .alternate)
```

The default value for the `endpoint` parameter points the API to `https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit`

## Documentation

The full documentation is available [here](http://fjcaetano.github.io/ReCaptcha){:target="\_blank"}.

[ReCaptcha]: https://github.com/fjcaetano/ReCaptcha
{:target="\_blank"}
[Invisible ReCaptcha]: https://developers.google.com/recaptcha/docs/invisible
{:target="\_blank"}
[admin page]: https://www.google.com/recaptcha/admin
{:target="\_blank"}
[CocoaPods]: https://cocoapods.org/
{:target="\_blank"}
[Carthage]: https://github.com/Carthage/Carthage
{:target="\_blank"}
[RxSwift]: https://github.com/ReactiveX/RxSwift
{:target="\_blank"}
[open an issue]: https://github.com/fjcaetano/ReCaptcha/issues
{:target="\_blank"}
[Great Firewall of China]: https://en.wikipedia.org/wiki/Great_Firewall
{:target="\_blank"}
