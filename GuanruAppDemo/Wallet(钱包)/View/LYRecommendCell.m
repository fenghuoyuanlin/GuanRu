//
//  LYRecommendCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/24.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRecommendCell.h"
// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface LYRecommendCell ()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic, strong) UILabel *infoLabel;

@property(nonatomic ,strong) UILabel *desLabel;

@property(nonatomic, strong) UIImageView *infoImgView;

@end


@implementation LYRecommendCell

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
    self.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"商户入驻";
    [self addSubview:_titleLabel];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"钱袋"];
    [self addSubview:_imgView];
    
    _infoLabel = [[UILabel alloc] init];
    if (iphone5)
    {
        _infoLabel.font = PFR14Font;
    }
    _infoLabel.textColor = RGB(248, 54, 19);
    _infoLabel.text = @"推码代理，赚钱给你";
    [self addSubview:_infoLabel];
    
    _desLabel = [[UILabel alloc] init];
    _desLabel.textColor = RGB(156, 156, 156);
    _desLabel.text = @"推广下级代理，赚钱一步到位";
    if (iphone5)
    {
        _desLabel.font = PFR14Font;
    }
    [self addSubview:_desLabel];
    
    _infoImgView = [[UIImageView alloc] init];
    _infoImgView.image = [UIImage imageNamed:@"立即加入"];
    [self addSubview:_infoImgView];

}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(DCMargin);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(DCMargin);
        make.left.equalTo(40);
        if (iphone5)
        {
            make.size.equalTo(CGSizeMake(70, 70));
        }
        else
        {
            make.size.equalTo(CGSizeMake(100, 100));
        }
    }];
    
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imgView.centerY);
        make.left.equalTo(_imgView.right).offset(15);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_desLabel.top).offset(-DCMargin);
        make.left.equalTo(_desLabel.left);
    }];
    
    [_infoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_infoLabel.left);
        make.top.equalTo(_desLabel.bottom).offset(DCMargin);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    
}

#pragma mark - Setter Getter Methods
-(void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = imgUrl;
    
}

@end
