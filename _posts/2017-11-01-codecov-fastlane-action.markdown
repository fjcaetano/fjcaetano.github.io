---
layout: post
title: "Codecov Fastlane action"
date: 2017-11-01 18:12:06 -0200
comments: true
categories:
- Fastlane
share: true
published: true
image:
  feature: /assets/images/abstract-5.jpg
tags:
- fastlane ruby codecov coverage tests
github_repo: https://gist.github.com/fjcaetano/04126b3051f6cd6aebe041bb1dfe14e9
---
I recently had to configure [Fastlane]{:target="_blank"} to run in the [ReCaptcha]{:target="_blank"}
project. Since we were already uploading coverage reports to [Codecov]{:target="_blank"},
it would be interesting if we kept using it.

After tweaking a bit with their default command, because [Fastlane]{:target="_blank"}
kept complaining about syntax error, I came up with the following command:

<!-- more -->

``` sh
curl -s https://codecov.io/bash | bash -s -- -J 'ReCaptcha'
```

Hey, since we're running a shell command, why not transform it into a proper
action so everybody can use it, right?  Unfortunately, [Fastlane is not accepting
actions](https://docs.fastlane.tools/plugins/create-plugin/#submitting-the-action-to-the-fastlane-main-repo){:target="_blank"},
also, this action would fall into the "third party service" category and it wouldn't
be accepted anyway.

So let's share it on Github! Since, it's just a single file, I've created a gist
that can be added as a submodule to your [Fastlane]{:target="_blank"} `actions` folder:

{% gist 04126b3051f6cd6aebe041bb1dfe14e9 %}

After cloning the submodule you can try running `fastlane action codecov` for details.

### Arguments:

- `use_xcodeplist`: [Codecov's beta feature](https://docs.codecov.io/blog/beta-xcode-plist-reports){:target="_blank"} (default `false`)
- `project_name`: The project name to be used by the `-J` argument
- `token`: The API token for private repos

Enjoy!

[Fastlane]: https://github.com/fastlane/fastlane
[ReCaptcha]: https://github.com/fjcaetano/ReCaptcha
[Codecov]: https://codecov.io
