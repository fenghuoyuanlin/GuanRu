//
//  LYGuidePageController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/7.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYGuidePageController.h"
#import "AppDelegate.h"

@interface LYGuidePageController ()<UIScrollViewDelegate>

@property(copy, nonatomic) UIPageControl *pageControl;//小白点。
@property(copy, nonatomic) UIScrollView  * scrollview;//广告栏
@property (assign, nonatomic) int conuts;//几张引导页

@end

@implementation LYGuidePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    _conuts = 3;
    //几张引导页
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.pageControl];
    [self guideImage];//引导页图片
}
/**
 *  引导页图片
 */
- (void)guideImage
{
    NSArray *arr = @[@"引导页1",@"引导页2",@"引导页3"];
    for (int i = 0; i< _conuts;i++) {
        UIImageView * image=[[UIImageView alloc]init];
        CGFloat imageW = self.scrollview.frame.size.width;
        CGFloat imageH = self.scrollview.frame.size.height;
        CGFloat imageY = 0;
        image.userInteractionEnabled=YES;
        
        image.image = [UIImage imageNamed:arr[i]];
        CGFloat imageX = i * imageW;
        image.frame = CGRectMake(imageX, imageY, imageW, imageH);
        CGFloat contentW = _conuts * imageW;
        self.scrollview.contentSize = CGSizeMake(contentW, 0);
        [self.scrollview addSubview:image];
        if (i == _conuts - 1) {//最后一张的点击跳转
            UITapGestureRecognizer * singleRecognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];//手势
            singleRecognizer.numberOfTapsRequired = 1;
            [image addGestureRecognizer:singleRecognizer];
        }
    }
}
#pragma mark -scrollview的懒加载
-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.delegate = self;
        _scrollview.bounces = NO;
        _scrollview.pagingEnabled = YES;
    }
    return _scrollview;
}
#pragma mark -pageControl的懒加载
//-(UIPageControl *)pageControl
//{
//    if (!_pageControl) {
//        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.frame.size.height-50, 100,20)];
//        _pageControl.currentPage = 0;
//        _pageControl.numberOfPages = 4;
//        _pageControl.enabled = NO;
//        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        [_pageControl addTarget:self action:@selector(nextImage:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _pageControl;
//}

/**
 *  下一页
 */
- (void)nextImage:(UIPageControl *)sender
{
    self.pageControl.currentPage = (self.pageControl.currentPage + 1) % self.conuts;
    CGFloat x = self.pageControl.currentPage * self.scrollview.frame.size.width;
    [self.scrollview setContentOffset:CGPointMake(x, 0) animated:YES];
}
/**
 *  滚动视图并最终停下
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}
/**
 *  引导页跳主页
 */
- (void)click:(UIGestureRecognizer *)tap
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app qieHuan];
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
