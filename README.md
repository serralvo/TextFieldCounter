# TextFieldCounter
    UITextField character counter with lovable UX 💖. No math skills required 🙃.

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Build Status][build-status-image]][build-status-url]
![CocoaPods][pod-version-image]

## Features

- [x] Set max length of UITextField.
- [x] A beautiful and animated label about the limits. Show it by ascending or descending way.
- [x] Haptic Feedback (iOS 10+).
- [x] Easy setup with @IBInspectable.

![TextFieldCounter][demo-image]

## Requirements

- iOS 8.0+
- Xcode 8.0
- ARC

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
2. Congratulations 🚀 

## Usage example

#### By Inspector

1. Set the class and configure the options.

![Inspector][inspector-image]

#### Programmatically

```swift
import TextFieldCounter

let frame = CGRect(x: 20, y: 80, width: 320, height: 30)
let textField = TextFieldCounter(frame: frame, limit: 20, animate: true, ascending: true, counterColor: .black, limitColor: .red)

view.addSubview(textField)
```

##### Use Delegate

Set `counterDelegate` and enjoy it 🚀:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    textField.counterDelegate = self
}

func didReachMaxLength(textField: TextFieldCounter) {
    print("didReachMaxLength")
}

```

## Next Steps

- Add `UIAppearance` support
- Add More tests
- Add Carthage support

## Contribute

We would ❤️ to see your contribution! To contribute to **TextFieldCounter**, check the ``LICENSE`` file for more info.

## License

Distributed under the MIT license. See ``LICENSE`` for more information.

## About

Created by Fabricio Serralvo – [serralvo.co](https://serralvo.co)

Special thanks 👍 to [@ciceroduarte](https://github.com/ciceroduarte) and [@rogerluan](https://github.com/rogerluan)

[swift-image]:https://img.shields.io/badge/swift-4.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[build-status-image]: https://api.travis-ci.org/serralvo/TextFieldCounter.svg
[pod-version-image]: https://img.shields.io/cocoapods/v/TextFieldCounter.svg
[build-status-url]: https://travis-ci.org/serralvo/TextFieldCounter
[inspector-image]:https://github.com/serralvo/TextFieldCounter/blob/master/Images/inspector.png
[demo-image]:https://github.com/serralvo/TextFieldCounter/blob/master/Images/demo.gif
