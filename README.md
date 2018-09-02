# CGSegmentBar

[![CI Status](https://img.shields.io/travis/CodeGeekXu/CGSegmentBar.svg?style=flat)](https://travis-ci.org/CodeGeekXu/CGSegmentBar)
[![Version](https://img.shields.io/cocoapods/v/CGSegmentBar.svg?style=flat)](https://cocoapods.org/pods/CGSegmentBar)
[![License](https://img.shields.io/cocoapods/l/CGSegmentBar.svg?style=flat)](https://cocoapods.org/pods/CGSegmentBar)
[![Platform](https://img.shields.io/cocoapods/p/CGSegmentBar.svg?style=flat)](https://cocoapods.org/pods/CGSegmentBar)

## CGSegmentBar
A view like UISegmentedControl,you can customize your style.

## Installation

CGSegmentBar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CGSegmentBar'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

```objective-c
    CGSegmentBar *dynamicSegmentBar = [[CGSegmentBar alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 40)];
    dynamicSegmentBar.titles = @[@"America",@"China",@"Japan",@"Germany",@"France",@"Italy",@"Spain",@"India"];
    dynamicSegmentBar.widthStyle = CGSegmentBarWidthStyleDynamic;
    dynamicSegmentBar.interitemSpacing = 30;
    dynamicSegmentBar.paddingInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    dynamicSegmentBar.indicatorHeight = 2;
    dynamicSegmentBar.indicatorColor = [UIColor blueColor];
    [dynamicSegmentBar reload];
    dynamicSegmentBar.didSelectItemBlock = ^(NSUInteger index) {
        
    };
    [self.view addSubview:dynamicSegmentBar];
    
    [dynamicSegmentBar setSelectedIndex:2 animated:YES];
```

## Author

CodeGeekXu, codegeekxu@gmail.com

## License

CGSegmentBar is available under the MIT license. See the LICENSE file for more info.
