//
//  LYRateItemCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRateItemCell.h"
// Controllers

// Models
#import "LYRateItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYRateItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation LYRateItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//对这个cell的真实有效部分进行设置
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= DCMargin;
    frame.origin.y += DCMargin;
    
    frame.origin.x += DCMargin;
    frame.size.width -=  2 * DCMargin;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter Getter Methods
-(void)setRateItem:(LYRateItem *)rateItem
{
    _rateItem = rateItem;
    _brandLabel.text = rateItem.brand;
    _rateLabel.text = rateItem.rate;
    _accountLabel.text = rateItem.account;
    _amountLabel.text = rateItem.amount;
    _imgView.image = [UIImage imageNamed:rateItem.img];
}


@end
