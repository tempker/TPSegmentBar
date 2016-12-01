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
#import "TPSegmentBarVC.h"
@interface ViewController ()

/** TPSegmentBar   */
//@property (nonatomic,weak) TPSegmentBar *segmentBar;

/**    */
@property (nonatomic,strong) TPSegmentBarVC *segmentBarVC ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
    CGRect frame = CGRectMake( 0, 50, self.view.width, 30);
    TPSegmentBar *segmentBar = [TPSegmentBar segmentBarWithFrame:frame];
    segmentBar.delegate = self;
    self.segmentBar = segmentBar;
    segmentBar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:segmentBar];
    

    segmentBar.titleItems = @[@"专辑", @"声音",@"精彩推荐", @"下载中", @"体育赛事",@"声音", @"下载中", @"声音", @"下载中"];
     
     */
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentBarVC.view];
    
    [self setUp];
}

-(void)setUp{
    
    NSArray *items = @[@"专辑", @"声音",@"精彩推荐", @"下载中", @"体育赛事", @"下载中", @"体育赛事"];
    
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc5 = [UIViewController new];
    vc5.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc6 = [UIViewController new];
    vc6.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc7 = [UIViewController new];
    vc7.view.backgroundColor = [UIColor grayColor];
    [self.segmentBarVC setUpItems:items addChildController:@[vc1, vc2, vc3, vc4, vc5,vc6,vc7]];
    
    [self.segmentBarVC.segmentBar upDateSegmentBarConfig:^(TPSegmentBarConfig *config) {
        
        config.segmentBarBackColor = [UIColor yellowColor];
        config.itemNormalColor = [UIColor blackColor];
        config.itemSelectColor = [UIColor greenColor];
        config.itemFont = [UIFont systemFontOfSize:18];
        config.indicatorHeight = 5;
        config.indicatorColor = [UIColor redColor];
        config.indicatorExtraW = 0;
        
    }];
    
}

#pragma mark - 懒加载

-(TPSegmentBarVC *)segmentBarVC{
    
    if (!_segmentBarVC) {
        _segmentBarVC = [[TPSegmentBarVC alloc]init];
    }
    return _segmentBarVC;
}

@end
