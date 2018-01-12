//
//  LYCodeView.m
//  HengShuaTest
//
//  Created by 刘园 on 2017/12/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYCodeView.h"
#import "SubmitBtn.h"
#import <QuartzCore/QuartzCore.h>
@implementation LYCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        [self creatView];
    }
    return self;
}
/**
 布局
 */
- (void)creatView{
    
    [self addSubview:self.backView];
    [self addSubview:self.titleLab];
    [self addSubview:self.codeImage];
    [self addSubview:self.saveBtn];
    
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(620*m6Scale, 750*m6Scale));
    }];
    //标题
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.top).offset(60*m6Scale);
        make.centerX.equalTo(_backView.centerX);
    }];
    //二维码图片
    [_codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.centerX);
        make.centerY.equalTo(_backView.centerY).offset(30*m6Scale);
        make.size.equalTo(CGSizeMake(500*m6Scale, 500*m6Scale));
    }];
    //按钮
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.bottom).offset(50*m6Scale);
        make.centerX.equalTo(_backView.centerX);
        make.size.equalTo(CGSizeMake(600*m6Scale, 90*m6Scale));
    }];
    //需要保存到本地的图片
    
}
/**
 我的二维码
 */
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
//        _titleLab.text = _title;
        _titleLab.font = [UIFont systemFontOfSize:36*m6Scale];
    }
    return _titleLab;
}
/**
 背景
 */
- (UIView *)backView{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"二维码背景"]];
    }
    return _backView;
}
/**
 二维码
 */
- (UIImageView *)codeImage{
    if (!_codeImage) {
        _codeImage = [[UIImageView alloc]init];
    }
    return _codeImage;
}
/**
 保存到本地
 */
- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [SubmitBtn buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存到手机" forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 45*m6Scale;
        [_saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

-(void)setImg:(UIImage *)img{
    _img = img;
}
/**
 保存到本地
 */
- (void)saveBtn:(UIButton *)sender{
    //将图片保存到本地
//    UIImageWriteToSavedPhotosAlbum(_img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    //屏幕截图(UIView转为图像存储到本地)
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
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

@end
