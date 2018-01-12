//
//  LYCustomSegmentView.h
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/10/16.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCustomSegmentView : UIView

- (instancetype)initWithItemTitles:(NSArray *)itemTitles;

/**
 *  从0开始
 */
@property (nonatomic, copy) void(^LYCustomSegmentViewBtnClickHandle)(LYCustomSegmentView *segment, NSString *currentTitle, NSInteger currentIndex);

- (void)clickDefault;

/**
 intrinsicContentSize
 */
@property(nonatomic, assign) CGSize intrinsicContentSize;

@end
