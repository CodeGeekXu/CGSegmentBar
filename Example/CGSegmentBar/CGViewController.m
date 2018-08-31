//
//  CGViewController.m
//  CGSegmentBar
//
//  Created by CodeGeekXu on 08/31/2018.
//  Copyright (c) 2018 CodeGeekXu. All rights reserved.
//

#import "CGViewController.h"
#import "CGSegmentBar.h"

@interface CGViewController ()

@end

@implementation CGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGSegmentBar *hSegmentBar = [[CGSegmentBar alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 60)];
    hSegmentBar.backgroundColor = [UIColor greenColor];
    hSegmentBar.titles = @[@"中国",@"美国",@"英国",@"法国",@"日本",@"德国",@"意大利",@"德国"];
    hSegmentBar.widthStyle = CGSegmentBarWidthStyleDynamic;
    hSegmentBar.interitemSpacing = 20;
    hSegmentBar.paddingInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [hSegmentBar reload];
    [self.view addSubview:hSegmentBar];
    
    CGSegmentBar *vSegmentBar = [[CGSegmentBar alloc]initWithFrame:CGRectMake(0, 130, 60, 150)];
    vSegmentBar.backgroundColor = [UIColor greenColor];
    vSegmentBar.scrollDiretion = CGSegmentBarScrollDirectionVertical;
    vSegmentBar.titles = @[@"中国",@"美国",@"英国",@"法国",@"日本",@"德国",@"意大利",@"德国"];
    vSegmentBar.widthStyle = CGSegmentBarWidthStyleDynamic;
    vSegmentBar.interitemSpacing = 20;
    vSegmentBar.paddingInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [vSegmentBar reload];
    [self.view addSubview:vSegmentBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
