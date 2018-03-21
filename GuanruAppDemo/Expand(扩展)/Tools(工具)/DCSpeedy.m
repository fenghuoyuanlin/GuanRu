//
//  DCSpeedy.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCSpeedy.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@implementation DCSpeedy

+(id)dc_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can
{
    CALayer *icon_layer=[anyControl layer];
    [icon_layer setCornerRadius:radius];
    [icon_layer setBorderWidth:width];
    [icon_layer setBorderColor:[borderColor CGColor]];
    [icon_layer setMasksToBounds:can];
    
    return anyControl;
}

+(id)dc_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color
{
    if (label.text.length == 0) {
        return 0;
    }
    int i;
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:label.text];
    for (i = 0; i < label.text.length; i ++) {
        NSString *a = [label.text substringWithRange:NSMakeRange(i, 1)];
        NSArray *number = arrray;
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributeString;
    return label;
}


#pragma mark -  根据传入字体大小计算字体宽高
+ (CGSize)dc_calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW {
    
    CGFloat textMaxW = maxW;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:textFont]} context:nil].size;
    
    return textSize;
}

#pragma mark - 下划线
+ (void)dc_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color
{
    UIView *cellAcrossPartingLine = [[UIView alloc] init];
    cellAcrossPartingLine.backgroundColor = color;
    [view addSubview:cellAcrossPartingLine];
    
    [cellAcrossPartingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(view);
        make.bottom.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(view.dc_width, 1));
        
    }];
    
}
#pragma mark - 竖线
+ (void)dc_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;
{
    if (ratio == 0) { // 默认1
        ratio = 1;
    }
    UIView *cellLongLine = [[UIView alloc] init];
    cellLongLine.backgroundColor = color;
    [view addSubview:cellLongLine];
    
    [cellLongLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(view);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(1, view.dc_height * ratio));
        
    }];
}
#pragma mark - 首行缩进
+ (void)dc_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen
{
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    
    label.attributedText = attrText;
}

#pragma mark - 给Button设置圆角
+ (void)dc_setUpBezierPathCircularLayerWith:(UIButton *)control :(CGSize)size
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:control.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft |UIRectCornerTopRight cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = control.bounds;
    maskLayer.path = maskPath.CGPath;
    control.layer.mask = maskLayer;
}

#pragma mark - 字符串加星处理
+ (NSString *)dc_EncryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex
{
    if (findex <= 0) {
        findex = 2;
    }else if (findex + 1 > content.length) {
        findex --;
    }
    return [NSString stringWithFormat:@"%@***%@",[content substringToIndex:findex],[content substringFromIndex:content.length - 1]];
}

+(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

#pragma mark - base64图片转编码
+(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
{
    NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:_encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

#pragma mark - 判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark - 返回一个空的或者有效的字符串
+ (NSString *)validString:(NSString *)string {
    
    if ([self isBlankString:string]) {
        return  kEmptyStr;
    } else {
        return string;
    }
}

/**
 提示框(1.5s后自动消失)
 */
+ (void)alertMes:(NSString *)mes{
    
    if ([DCSpeedy isBlankString:mes])
    {
        NSLog(@"数据消息为空");
    }
    else
    {
        UIView *view;
        if (view == nil) view = [UIApplication sharedApplication].delegate.window;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.contentColor = [UIColor grayColor];
        hud.label.text = mes;
        hud.label.numberOfLines = 0;
        hud.mode = MBProgressHUDModeText;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1.5];
    }
    
    
}

/*****帧动画*****/
+ (MBProgressHUD *)createHUD:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (view == nil) view = window;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    
    HUD.label.font = [UIFont systemFontOfSize:12];
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    
    HUD.animationType = MBProgressHUDAnimationZoom;
    
    HUD.removeFromSuperViewOnHide = YES;
    //    [HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    return HUD;
}

+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view
{
    MBProgressHUD *HUD = [DCSpeedy createHUD:view];
    HUD.contentColor = [UIColor clearColor];
    HUD.label.text = text;
    HUD.square = YES;
    HUD.label.textColor = [UIColor grayColor];
    HUD.label.font = [UIFont systemFontOfSize:8];
    HUD.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@0001",imageName]];
    UIImageView *animateGifView = [[UIImageView alloc]initWithImage:image];
    
    NSMutableArray *gifArray = [NSMutableArray array];
    for (int i = 1; i <= imageCounts; i ++) {
        UIImage *images = [UIImage imageNamed:[NSString stringWithFormat:@"%@000%zd", imageName, i]];
        [gifArray addObject:images];
    }
    
    [animateGifView setAnimationImages:gifArray];
    [animateGifView setAnimationDuration:0.5];
    [animateGifView setAnimationRepeatCount:0];
    [animateGifView startAnimating];
    
    HUD.customView = animateGifView;
    
    return HUD;
}

//正则法判断字符串全为数字
//  判断字符串是否全部为数字
+ (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i = 0; i < string.length; i++) {
        c = [string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

//去掉字符串转double类型时有效数字多余的0
+(NSString *)changeFloat:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = (int)(length - 1);
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}
//判断手机号码格式是否正确 
+ (BOOL)valiMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[345678][0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//返回YES或NO表示该身份证号码是否符合国家标准
+ (BOOL)isCorrect:(NSString *)IDNumber
{
    
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i <18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @"2"];
    // 余数数组
    NSArray *remainderArray = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i <17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    return [str isEqualToString:string];
}

//时间戳转化为时间日期
+ (NSString *)timeStampToStr:(NSString *)creaTime
{
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[creaTime doubleValue]];
    NSString *strDate = [stampFormatter stringFromDate:stampDate2];
    return strDate;
}

//获取当前时间的时间戳
+(NSString *)getNowTimeTimestamp
{
    NSDate *senddate = [NSDate date];
    
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    
    return date2;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//网络监测
+ (NSInteger)checkNetwork
{
    NSInteger state = 0;
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
        state = 1;
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        state = 2;
    } else { // 没有网络
        NSLog(@"没有网络");
        state = 0;
    }
    return state;
}

//登录token
+ (AFOwnerHTTPSessionManager *)userToken
{
    AFOwnerHTTPSessionManager *sharedClient = [AFOwnerHTTPSessionManager shareManager];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"type %@",[user objectForKey:@"userToken"]];
    NSLog(@"%@", str);
    [sharedClient.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    return sharedClient;
    
}

+ (void)ChangeColorString:(NSString *)str andLabel:(UILabel *)label andColor:(UIColor *)color{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text];
    [string addAttribute:NSForegroundColorAttributeName value:color range:[label.text rangeOfString:str]];
    label.attributedText = string;
}

@end
