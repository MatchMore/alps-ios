# Introduction

This repository contains a working demo application of the Matchmore ALPS service.

# Usage

## Installation

### 1. Clone this repository locally: 

```
git clone https://github.com/MatchMore/alps-ios
```

### 2. Create an Application on the portal

To be able to run this project, you need to have a valid Matchmore Application key. Don't worry, this is a simple process. 

Log in your [Matchmore](http://dev.matchmore.com/) account (or [register](http://dev.matchmore.com/account/register)) and [create a new Application](http://dev.matchmore.com/account/apps/). 

Once created, your Application will be granted an *api-key*, please copy it.

### 3. Set your API Key

Open the workspace `demo.xcworkspace` in [xcode](https://developer.apple.com/xcode/), navigate to the `demo/AppDelegate.swift` file and edit the *APIKEY* constant with the value you have just copied.

After the edit, it should look like this:

```
let APIKEY = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
```

### 4. You are good to go! 

You may now compile and run the xcode project, enjoy!

## Matchmore iOS SDK

The Matchmore [alps-io-sdk](https://github.com/MatchMore/alps-ios-sdk) is already included in this demo project in the `Pods/` directory.


