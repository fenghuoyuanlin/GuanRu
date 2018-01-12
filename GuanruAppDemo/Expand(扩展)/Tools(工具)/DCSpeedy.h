//
//  DCSpeedy.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFOwnerHTTPSessionManager.h"
#import "MBProgressHUD.h"
@interface DCSpeedy : NSObject

/**
 设置按钮的圆角
 
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+(id)dc_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can;


/**
 选取部分数据变色（label）
 
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+(id)dc_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color;


#pragma mark -  根据传入字体大小计算字体宽高
+ (CGSize)dc_calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW ;

/**
 下划线
 
 @param view 下划线
 */
+ (void)dc_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color;

/**
 竖线线
 
 @param view 竖线线
 */
+ (void)dc_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;


/**
 利用贝塞尔曲线设置圆角

 @param control 按钮
 @param size 圆角尺寸
 */
+ (void)dc_setUpBezierPathCircularLayerWith:(id)control :(CGSize)size;


/**
 label首行缩进

 @param label label
 @param emptylen 缩进比
 */
+ (void)dc_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen;


/**
 字符串加星处理

 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)dc_EncryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex;


#pragma mark - 图片转base64编码
+ (NSString *)UIImageToBase64Str:(UIImage *) image;

#pragma mark - base64图片转编码
+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 *  返回一个空的或者有效的字符串
 */
+ (NSString *)validString:(NSString *)string;

/**
 提示框(1.5s后自动消失)
 */
+ (void)alertMes:(NSString *)mes;

//判断字符串全为数字
+ (BOOL)isAllNum:(NSString *)string;

//去掉字符串转double类型时有效数字多余的0
+(NSString *)changeFloat:(NSString *)stringFloat;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

/**
 *  验证身份证号码是否正确的方法（前提必须是18位才能用此方法）
 *
 *  @param IDNumber 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */
+ (BOOL)isCorrect:(NSString *)IDNumber;

//时间戳转化为时间日期
+ (NSString *)timeStampToStr:(NSString *)creaTime;
//获取当前时间的时间戳
+(NSString *)getNowTimeTimestamp;

//网络监测
+ (NSInteger)checkNetwork;
/*****帧动画*****/
+ (MBProgressHUD *)createHUD:(UIView *)view;
+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view;

//登录token(突出安全性)
+ (AFOwnerHTTPSessionManager *)userToken;

@end
