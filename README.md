# Alps-ios-demo

Alps-ios-demo is a working application taking advantage of the [Matchmore](http://dev.matchmore.com/) ALPS service. 

## Installation

### 1. Install the project locally: 

#### First, clone the git repo

```
git clone https://github.com/MatchMore/alps-ios
```

#### Second, install the pods

Go to the folder where you have just cloned the repo and install the [CocoaPods](http://cocoapods.org) dependecies with the command:

```
pod install
```

### 2. Generate an API Key

To be able to run this project, you need to have a valid [Matchmore](http://dev.matchmore.com/) API key. Don't worry, this is a simple process. 

In [Matchmore](http://dev.matchmore.com/), one API Key is provided per registered Application. So [visit your account to create a new Application](http://dev.matchmore.com/account/apps/) (it is free!). 

Once created, your Application will be granted an **api-key**, please copy it.

### 3. Set your API Key

Open the project workspace `demo.xcworkspace` in [xcode](https://developer.apple.com/xcode/), navigate to the `demo/AppDelegate.swift` file and edit the **APIKEY** constant with the value you have just copied.

After the edit, it should look like this:

```
let APIKEY = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
```

### 4. You are good to go! 

You may now compile and run the project, enjoy!

## Matchmore iOS SDK

This sample project is powered by Matchmore [alps-io-sdk](https://github.com/MatchMore/alps-ios-sdk).

Visit us: [Matchmore](http://dev.matchmore.com/)
