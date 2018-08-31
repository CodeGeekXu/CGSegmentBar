//
//  CGViewController.m
//  CGSegmentBar
//
//  Created by CodeGeekXu on 08/31/2018.
//  Copyright (c) 2018 CodeGeekXu. All rights reserved.
//

#import "CGViewController.h"
#import <CGSegmentBar/CGSegmentBar.h>

@interface CGViewController ()

@end

@implementation CGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    CGSegmentBar *fixedSegmentBar = [[CGSegmentBar alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), 40)];
    fixedSegmentBar.titles = @[@"Apple",@"Orange",@"Pear",@"Banana"];
    fixedSegmentBar.widthStyle = CGSegmentBarWidthStyleFixed;
    fixedSegmentBar.interitemSpacing = 30;
    fixedSegmentBar.paddingInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    fixedSegmentBar.indicatorHeight = 2;
    fixedSegmentBar.indicatorColor = [UIColor blueColor];
    [fixedSegmentBar reload];
    fixedSegmentBar.didSelectItemBlock = ^(NSUInteger index) {
        
    };
    [self.view addSubview:fixedSegmentBar];

    CGSegmentBar *dynamicSegmentBar = [[CGSegmentBar alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 40)];
    dynamicSegmentBar.titles = @[@"America",@"China",@"Japan",@"Germany",@"France",@"Italy",@"Spain",@"India"];
    dynamicSegmentBar.widthStyle = CGSegmentBarWidthStyleDynamic;
    dynamicSegmentBar.interitemSpacing = 30;
    dynamicSegmentBar.paddingInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    dynamicSegmentBar.indicatorHeight = 2;
    dynamicSegmentBar.indicatorColor = [UIColor blueColor];
    dynamicSegmentBar.selectedIndex = 2;
    [dynamicSegmentBar reload];
    dynamicSegmentBar.didSelectItemBlock = ^(NSUInteger index) {
        
    };
    [self.view addSubview:dynamicSegmentBar];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
