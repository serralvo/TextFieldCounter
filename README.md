# TextFieldCounter
    > UITextField character counter with lovable UX ❤️. No math skills is required.

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

## Features

- [x] Set max length of UITextField
- [x] Show a beautiful label about the limits
- [x] Easy setup with @IBInspectable

## Requirements

- iOS 8.0+
- Xcode 7.3

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `TextFieldCounter` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'TextFieldCounter'
```

To get the full benefits import `TextFieldCounter` wherever you import UIKit

``` swift
import UIKit
import TextFieldCounter
```
#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/YourLibrary.framework` to an iOS project.

```
github "serralvo/TextFieldCounter"
```
#### Manually
1. Download and drop ```TextFieldCounter.swift``` in your project.  
2. Congratulations!  

## Usage example

```swift
import EZSwiftExtensions
ez.detectScreenShot { () -> () in
    print("User took a screen shot")
}
```

## Contribute

We would love for you to contribute to **TextFieldCounter**, check the ``LICENSE`` file for more info.

## Meta

Fabrício Serralvo – [serralvo.co](https://serralvo.co) – fabricio.serralvo@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/serralvo](https://github.com/serralvo)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
