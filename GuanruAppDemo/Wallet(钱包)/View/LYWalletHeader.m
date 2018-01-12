//
//  LYWalletHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/24.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYWalletHeader.h"
// Controllers

// Models

// Views
#import "LYUIBLButton.h"
// Vendors
#import <UIImageView+WebCache.h>
// Categories
#import "SGEasyButton.h"
// Others

@interface LYWalletHeader ()

@property(nonatomic, strong) LYUIBLButton *facePayBtn;

@property(nonatomic, strong) LYUIBLButton *qrcodePayBtn;

@end

@implementation LYWalletHeader

#pragma mark - initial
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = RGBA(50, 112, 229, 1.0);
    
    _facePayBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_facePayBtn setTitle:@"快速收款" forState:UIControlStateNormal];
    [_facePayBtn setImage:[UIImage imageNamed:@"收款"] forState:UIControlStateNormal];
    _facePayBtn.titleLabel.font = PFR16Font;
    _facePayBtn.adjustsImageWhenHighlighted = NO;
    _facePayBtn.tag = 0;
    [self addSubview:_facePayBtn];
    
    [_facePayBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _qrcodePayBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_qrcodePayBtn setTitle:@"商户入驻" forState:UIControlStateNormal];
    [_qrcodePayBtn setImage:[UIImage imageNamed:@"商户入驻"] forState:UIControlStateNormal];
    _qrcodePayBtn.titleLabel.font = PFR16Font;
    _qrcodePayBtn.adjustsImageWhenHighlighted = NO;
    _qrcodePayBtn.tag = 1;
    [self addSubview:_qrcodePayBtn];
    
    [_qrcodePayBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_facePayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(40);
        make.top.equalTo(20);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    [_qrcodePayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-40);
        make.top.equalTo(20);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
}

#pragma mark - Setter Getter Methods

#pragma mark - 点击事件
-(void)btnClick:(UIButton *)button
{
    if (button.tag == 0)
    {
        !_faceBtnClickBlock  ? : _faceBtnClickBlock();
    }
    else
    {
        !_qrcodeBtnClickBlock  ? : _qrcodeBtnClickBlock();
    }
}

@end
