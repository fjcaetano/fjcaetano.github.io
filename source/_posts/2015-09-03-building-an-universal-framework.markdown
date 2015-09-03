---
layout: post
title: "Building an Universal Framework"
date: 2015-09-03 17:41:16 -0300
categories:
- Bash
github_repo: https://gist.github.com/fjcaetano/16bc1f84981262f911d7
comments: true
share: true
published: true
image:
  feature: /images/colloseum.jpg
  credit: Flávio Caetano
  creditlink: http://flaviocaetano.vsco.co/media/55b25e346f331e64208b4570
tags:
- xcode framework script bash
---
These days I had to convert the core of an iOS app to a framework that could be shared between projects. It was fairly simple considering the "new" framework products available in Xcode. I managed to build it with the desired public headers, copied it from the "Products" folder to the new project and everything flowed smoothly.

<!-- more -->

Then, in the last "funcional tests" to check that all gears were lubed, I tried running the new project against the iOS Simulator. Not surprisingly, Xcode complained that `symbol(s) not found for architecture x86_64`. Building the framework against the simulator solved it, but, on the other side of the scale, I couldn't run it against the devices anymore. Of course, I would have to build a fat library that supported both architectures.

[After](http://spin.atomicobject.com/2011/12/13/building-a-universal-framework-for-ios/){:target="_blank"} [extensively](http://stackoverflow.com/questions/31575580/ios-universal-framework-with-iphoneos-and-iphonesimulator-architectures){:target="_blank"} [searching](http://stackoverflow.com/questions/27284192/xcode6-creating-fat-static-library-ios-universal-framework){:target="_blank"}, I finally found something worthy on [this Ray Wenderlich article](http://www.raywenderlich.com/41377/creating-a-static-library-in-ios-tutorial){:target="_blank"} (where else?), but it still wasn't quite what I expected. Aside the fact that it's an article from 2013, it's focused on creating an Static Library, and the solution is to create an Aggregate target with a build script. But I could work on that. It was feasible. This is the original script:

``` bash
# define output folder environment variable
UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

# Step 1. Build Device and Simulator versions
xcodebuild -target ImageFilters ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"
xcodebuild -target ImageFilters -configuration ${CONFIGURATION} -sdk iphonesimulator -arch i386 BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Step 2. Create universal binary file using lipo
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/lib${PROJECT_NAME}.a" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/lib${PROJECT_NAME}.a" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/lib${PROJECT_NAME}.a"

# Last touch. copy the header files. Just for convenience
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/include" "${UNIVERSAL_OUTPUTFOLDER}/"
```

First of all, it wouldn't work because I'm using workspaces instead of a `xcodeproj`, partly because of Cocoapods. So using `xcodebuild -target` wouldn't cut. Secondly, I wanted this script to be run when I archive the framework project, so it'd be run with the correct configuration, the correct environment variables, etc, etc. Lastly, the script is actually redundant if you think of running it as I intended. You wouldn't have to build the project again for the SDK `iphoneos`. Archiving the target would already do that, so I would only have to build against the `iphonesimulator` SDK and then combine the executables.

Having in mind that I wanted the universal build to be created when I archived the framework target, I edited my scheme and added the script as a "Run Script" phase in "Post-actions":

[![Run Script in Post-actions](/images/archive_post_action.jpg)](/images/archive_post_action.jpg)

> Don't forget to "Provide build settings from" the blurred framework!

So after fixing `xcodebuild`'s parameters to work with workspaces (and running the correct scheme), now all I had to do was combine (`lipo`) the product of the Archive with the product of the build I just did and, finally, export it to the correct location. This is the final script:

{% gist 16bc1f84981262f911d7 %}

As you can see, on step 3 I move the universal build to the archive product path. So when I export the archive after Xcode's Organizer shows up, the final product already has the universal build:

[![Universal Framework](/images/universal_framework.png)](/images/universal_framework.png)
