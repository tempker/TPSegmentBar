//
//  TPSegmentBarVC.m
//  TPSegmentBar
//
//  Created by WPF on 16/11/30.
//  Copyright © 2016年 Tempker. All rights reserved.
//

#import "TPSegmentBarVC.h"
#import "UIView+Cateory.h"
@interface TPSegmentBarVC ()<TPSegmentBarDelegate,UIScrollViewDelegate>

/** scrollView   */
@property (nonatomic,strong) UIScrollView *contentView;

@end

@implementation TPSegmentBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.segmentBar.superview == self.view) {
        
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count *self.view.width , 0);
        
        self.segmentBar.frame = CGRectMake(0, 60, self.view.width, 35);
        
        CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
        self.contentView.frame = contentFrame;
    }
    
    return;
}

#pragma mark - layout
//-(void)viewWillLayoutSubviews{
//    
//    [super viewWillLayoutSubviews];
//    
//    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count *self.view.width , 0);
//    
//    self.segmentBar.frame = CGRectMake(0, 60, self.view.width, 35);
//    
//    CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
//    CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
//    self.contentView.frame = contentFrame;
//    
//}



#pragma mark - ff

-(void)showControllerWithInde:(NSInteger)index{
    
    UIViewController *vc = self.childViewControllers[index];
    
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    
    [self.contentView addSubview: vc.view];
    
    CGFloat scrollViewX = index * self.contentView.width;
    
    [self.contentView setContentOffset: CGPointMake(scrollViewX, 0)  animated:YES];
}


-(void)setUpItems:(NSArray <NSString *>*)itemArray addChildController:(NSArray<UIViewController *>*)childVCs{
    
    NSAssert(itemArray.count != 0 || itemArray.count == childVCs.count, @"个数不匹配");
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];

    self.segmentBar.titleItems = itemArray;
    
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentSize = CGSizeMake(itemArray.count *self.view.width, 0);
    
    self.segmentBar.selectIndex = 0;
}


#pragma mark - delegate

-(void)segmentBar:(TPSegmentBar *)SegmentBar DidselectIndexFrom:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    
    [self showControllerWithInde:toIndex];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算最后的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    self.segmentBar.selectIndex = index;
    
}

#pragma mark - 懒加载
-(TPSegmentBar *)segmentBar{
    
    if (!_segmentBar) {
        _segmentBar = [TPSegmentBar segmentBarWithFrame:CGRectZero];
    }
    _segmentBar.backgroundColor = [UIColor yellowColor];
    _segmentBar.delegate = self;
    [self.view addSubview:_segmentBar];
    return _segmentBar;
}

-(UIScrollView *)contentView{
    
    if (!_contentView) {
        _contentView = [[UIScrollView alloc]init];
        _contentView.delegate = self;
        _contentView.pagingEnabled = YES;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}






@end
