//
//  LYMoreItemCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/24.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMoreItemCell.h"
// Controllers

// Models
#import "LYMoreItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface LYMoreItemCell ()
//imageView
@property(nonatomic, strong) UIImageView *gridImageView;
//label
@property(nonatomic, strong) UILabel *gridLabel;

@end

@implementation LYMoreItemCell

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
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
    
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR13Font;
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2 * DCMargin);
        if (iphone5) {
            make.size.equalTo(CGSizeMake(40, 40));
        }
        else
        {
            make.size.equalTo(CGSizeMake(50, 50));
        }
        make.centerX.equalTo(self.centerX);
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(_gridImageView.bottom).offset(5);
    }];
}

#pragma mark - Setter Getter Methods
-(void)setGridItem:(LYMoreItem *)gridItem
{
    _gridItem = gridItem;
    _gridLabel.text = gridItem.gridTitle;
    _gridImageView.image = [UIImage imageNamed:gridItem.iconImage];
    
}
@end
