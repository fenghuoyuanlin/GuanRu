//
//  LYShareFaceController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/3.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYShareFaceController.h"
// Controllers
#import "LYFaceShareController.h"
// Models

// Views

// Vendors
#import "SGQRCode.h"
#import <QuartzCore/QuartzCore.h>
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
// Categories

// Others

@interface LYShareFaceController ()
//背景图片
@property(nonatomic, strong) UIImageView *backgroundView;
//二维码图片
@property(nonatomic, strong) UIImageView *codeImageView;

@end

@implementation LYShareFaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DCBGColor;
    self.title = @"二维码";
    [self setUpBase];
}

-(void)setUpBase
{
    _backgroundView = [[UIImageView alloc] init];
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.image = _img;
    [self.view addSubview:_backgroundView];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self setupGenerateQRCode];
}

// 生成二维码
- (void)setupGenerateQRCode {
    
    // 1、借助UIImageView显示二维码
    _codeImageView = [[UIImageView alloc] init];
    _codeImageView.userInteractionEnabled = YES;
    CGFloat imageViewW = 120;
    CGFloat imageViewH = imageViewW;
    //    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    //    CGFloat imageViewY = 80;
    [self.view addSubview:_codeImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
    if (_integer == 1 || _integer == 2 || _integer == 3 ||  _integer == 5 || _integer == 8)
    {
        [_codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.centerY.equalTo(self.view.centerY);
            make.size.equalTo(CGSizeMake(ScreenW / 3, ScreenW / 3));
        }];
    }
    else if (_integer == 0 || _integer == 4 || _integer == 6)
    {
        [_codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.centerY.equalTo(self.view.centerY).offset(ScreenH / 8);
            make.size.equalTo(CGSizeMake(ScreenW / 3, ScreenW / 3));
        }];
    }
    else if (_integer == 7)
    {
        [_codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.centerY.equalTo(self.view.centerY).offset(-ScreenH / 12);
            make.size.equalTo(CGSizeMake(ScreenW / 3, ScreenW / 3));
        }];
    }
    
    // 2、将CIImage转换成UIImage，并放大显示
    _codeImageView.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:_urlString imageViewWidth:imageViewW];
    
#pragma mark - - - 模仿支付宝二维码样式（添加用户头像）
    CGFloat scale = 0.22;
    CGFloat borderW = 5;
    UIView *borderView = [[UIView alloc] init];
    CGFloat borderViewW = imageViewW * scale;
    CGFloat borderViewH = imageViewH * scale;
    CGFloat borderViewX = 0.5 * (imageViewW - borderViewW);
    CGFloat borderViewY = 0.5 * (imageViewH - borderViewH);
    borderView.frame = CGRectMake(borderViewX, borderViewY, borderViewW, borderViewH);
    borderView.layer.borderWidth = borderW;
    borderView.layer.borderColor = [UIColor purpleColor].CGColor;
    borderView.layer.cornerRadius = 10;
    borderView.layer.masksToBounds = YES;
    borderView.layer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    
    //[imageView addSubview:borderView];
}


#pragma mark - 点击事件
-(void)tap:(UITapGestureRecognizer *)guesture
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"点击分享" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了保存图片");
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了分享");
        LYFaceShareController *shareVC = [LYFaceShareController new];
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        shareVC.img = image;
        [weakSelf setUpAlterViewControllerWith:shareVC WithDistance:150 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        [DCSpeedy alertMes:@"二维码已经保存到相册中"];
    }else{
        //[Factory alertMes:[NSString stringWithFormat:@"%@", error]];
    }
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma 退出界面
- (void)selfAlterViewback
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
