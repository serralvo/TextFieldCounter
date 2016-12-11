# TextFieldCounter
    UITextField character counter with lovable UX ❤️. No math skills is required.

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

## Features

- [x] Set max length of UITextField
- [x] A beautiful and animated label about the limits
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

#### Manually
1. Download and drop ```TextFieldCounter.swift``` in your project.  
2. Congratulations!  

## Usage example

#### By Inspector

1. Set the class and configure the options
[inspector-image]

#### Programmatically

```swift
import TextFieldCounter

let frame = CGRect(x: 20, y: 80, width: 320, height: 30)
let textField = TextFieldCounter(frame: frame, limit: 30, shouldAnimate: true, colorOfCounterLabel: UIColor.darkGray, colorOfLimitLabel: UIColor.orange)

self.view.addSubview(textField)
```

## Contribute

We would ❤️ for you to contribute to **TextFieldCounter**, check the ``LICENSE`` file for more info.

## License

Distributed under the MIT license. See ``LICENSE`` for more information.

## About

Fabrício Serralvo – [serralvo.co](https://serralvo.co) – fabricio.serralvo@gmail.com

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[inspector-image]:https://github.com/serralvo/TextFieldCounter/blob/master/Images/inspector.png?raw=true
