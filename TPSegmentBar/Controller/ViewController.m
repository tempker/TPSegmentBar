//
//  ViewController.m
//  TPSegmentBar
//
//  Created by WPF on 16/11/30.
//  Copyright © 2016年 WPF. All rights reserved.
//

#import "ViewController.h"
#import "TPSegmentBar.h"
#import "UIView+Cateory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CGRect frame = CGRectMake( 0, 20, self.view.width, 30);
    TPSegmentBar *segmentBar = [TPSegmentBar segmentBarWithFrame:frame];
    
    segmentBar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:segmentBar];
    

    segmentBar.titleItems = @[@"专辑", @"声音",@"精彩推荐", @"下载中", @"体育赛事",@"声音", @"下载中", @"声音", @"下载中"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
