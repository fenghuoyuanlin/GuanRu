//
//  LYQrcodeController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYQrcodeController.h"
// Controllers

// Models

// Views
#import "AppDelegate.h"
#import "LYCodeView.h"
// Vendors
#import "SGQRCode.h"
// Categories

// Others

@interface LYQrcodeController ()
//背景图片
@property(nonatomic, strong) UIImageView *bottomImgView;
//二维码图片
@property(nonatomic, strong) UIImageView *codeImageView;
//上提示语
@property(nonatomic, strong) UILabel *upLabel;
//商店名称
@property(nonatomic, strong) UILabel *storeLabel;
//下提示语
@property(nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) LYCodeView *codeview;//二维码

@end

@implementation LYQrcodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.view.backgroundColor = DCBGColor;
    
    _bottomImgView = [[UIImageView alloc] init];
    _bottomImgView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64);
    _bottomImgView.image = [UIImage imageNamed:@"Image"];
    //    _bottomImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_bottomImgView];
    
    // 生成二维码(Default)
    [self setupGenerateQRCode];
}

// 生成二维码
- (void)setupGenerateQRCode {
    
    // 1、借助UIImageView显示二维码
    _codeImageView = [[UIImageView alloc] init];
    _codeImageView.userInteractionEnabled = YES;
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    //    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    //    CGFloat imageViewY = 80;
    [self.view addSubview:_codeImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_codeImageView addGestureRecognizer:tap];
    
    [_codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.centerY.equalTo(self.view.centerY);
        make.size.equalTo(CGSizeMake(ScreenW / 2, ScreenW / 2));
    }];
    
    // 2、将CIImage转换成UIImage，并放大显示
    _codeImageView.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:_codeStr imageViewWidth:imageViewW];
    
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
    
    
    _upLabel = [[UILabel alloc] init];
    _upLabel.textAlignment = NSTextAlignmentCenter;
    NSString *str = @"请截屏图片，用<font color=\"#ff0000\">支付宝</font>扫码";
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _upLabel.attributedText = attrStr;
    _upLabel.font = PFR18Font;
    [self.view addSubview:_upLabel];
    
    [_upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_codeImageView.top).offset(-15);
        make.centerX.equalTo(self.view.centerX);
    }];
    
    _storeLabel = [[UILabel alloc] init];
    _storeLabel.textAlignment = NSTextAlignmentCenter;
    _storeLabel.text = [NSString stringWithFormat:@"%@的收款码", _storeStr];
    _storeLabel.font = PFR18Font;
    _storeLabel.textColor = RGB(122, 174, 116);
    [self.view addSubview:_storeLabel];
    
    [_storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_upLabel.top).offset(-DCMargin);
        make.centerX.equalTo(self.view.centerX);
    }];
    
    _bottomLabel = [[UILabel alloc] init];
    _bottomLabel.numberOfLines = 0;
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.text = @"为了您的账户安全\n请务必关闭wifi和定位";
    _bottomLabel.font = PFR18Font;
    [self.view addSubview:_bottomLabel];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeImageView.bottom).offset(20);
        make.centerX.equalTo(self.view.centerX);
    }];
}

#pragma mark - 点击事件
-(void)tap:(UITapGestureRecognizer *)recognizer
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _codeview = [[LYCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    _codeview.img = _codeImageView.image;
    _codeview.titleLab.text = [NSString stringWithFormat:@"%@的收款码", _storeStr];
    UITapGestureRecognizer *clipTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCancelActivityAction:)];
    [self.codeview addGestureRecognizer:clipTap];
    [delegate.window addSubview:_codeview];
    _codeview.codeImage.image = _codeImageView.image;
}

//点击取消按钮
- (void)didCancelActivityAction:(UIGestureRecognizer *)tap {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.codeview.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            self.codeview.hidden = YES;
        }
    }];
    //做图片放大的效果
    [UIView beginAnimations:@"Animations_4" context:nil];
    [UIView setAnimationDuration:1];
    self.codeview.transform = CGAffineTransformScale(self.codeview.transform, 3, 3);
    [UIView commitAnimations];
    
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

