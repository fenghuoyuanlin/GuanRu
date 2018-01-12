//
//  LYPaymentDetailController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYPaymentDetailController.h"
// Controllers
#import "LYGatheringController.h"
#import "LYWithDrawController.h"
// Models

// Views
#import "LYCustomSegmentView.h"
#import "SGPagingView.h"
// Vendors

// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface LYPaymentDetailController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>

//收款
@property(nonatomic, strong) LYGatheringController *gatherViewController;
//提现
@property(nonatomic, strong) LYWithDrawController *withdrawViewController;

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

#define kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]

@implementation LYPaymentDetailController

#pragma mark - LoadLazy
-(LYGatheringController *)gatherViewController
{
    if (!_gatherViewController)
    {
        _gatherViewController = [[LYGatheringController alloc] init];
    }
    return _gatherViewController;
}

-(LYWithDrawController *)withdrawViewController
{
    if (!_withdrawViewController)
    {
        _withdrawViewController = [[LYWithDrawController alloc] init];
    }
    return _withdrawViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
//    LYCustomSegmentView *segment = [[LYCustomSegmentView alloc] initWithItemTitles:@[@"收款记录", @"提现记录"]];
//    self.navigationItem.titleView = segment;
//    segment.frame = CGRectMake(0, 0, 150, 35);
//    __weak typeof(self) weakSelf = self;
//    segment.LYCustomSegmentViewBtnClickHandle = ^(LYCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
//        [weakSelf changeChildVcWithCurrentIndex:currentIndex];
//    };
//    [segment clickDefault];
    
    self.title = @"账单";
    [self setupPageView];
}

- (void)changeChildVcWithCurrentIndex:(NSInteger)currentIndex {
    
    BOOL isHot = (currentIndex == 0);
    
    if (isHot) { // 热门
        [self addChildVc:self.gatherViewController];
        [self removeChildVc:self.withdrawViewController];
    } else { // 订阅
        [self addChildVc:self.withdrawViewController];
        [self removeChildVc:self.gatherViewController];
    }
}

- (void)setupPageView {
//    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
//    CGFloat pageTitleViewY = 0;
//    if (statusHeight == 20.0) {
//        pageTitleViewY = 64;
//    } else {
//        //iphonex的状态栏的高度
//        pageTitleViewY = 88;
//    }
    
    NSArray *titleArr = @[@"收益记录", @"提现记录"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorScrollStyle = SGIndicatorScrollStyleHalf;
    configure.titleFont = [UIFont systemFontOfSize:18];
    configure.indicatorColor = RGB(30, 139, 241);
    configure.titleSelectedColor = RGB(30, 139, 241);
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_pageTitleView resetTitleWithIndex:1 newTitle:@"等待已结束"];
//    });
    
    LYGatheringController *oneVC = [[LYGatheringController alloc] init];
    oneVC.height = ScreenH - 44 - 64;
    LYWithDrawController *twoVC = [[LYWithDrawController alloc] init];
    twoVC.height = ScreenH - 44 - 64;
//    ChildVCThree *threeVC = [[ChildVCThree alloc] init];
//    ChildVCFour *fourVC = [[ChildVCFour alloc] init];
    NSArray *childArr = @[oneVC, twoVC];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
