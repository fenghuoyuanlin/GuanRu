//
//  API.h
//  GuanruAppDemo
//

//  Created by 刘园 on 2017/11/29.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#ifndef API_h
#define API_h
//服务器
//#define Localhost @"http://api.047104086014.gaofangh.com/"
//测试服
//#define Localhost @"http://192.188.88.177:8081/"  //本地一
//#define Localhost @"http://192.168.1.11/"//本地一
#define Localhost @"http://www.1shouyin.com/"//本地二

/** 登录界面接口 */
//登录
#define LoginAccount @"api/Agent/Login"
//获取秘钥
#define GetSecretKey @"api/Agent/GetSecretKey"

/** 注册界面接口 */
//注册
#define RegisterAccount @"/mobile/account/accountPage"

//获取验证码
#define RegisterCode @"api/Agent/GetVerificationCode"

//忘记密码
#define ForgetPassWord @"api/Agent/ForgetPassWord"
//修改密码
#define UpdatePwd @"api/Agent/UpdatePwd"
//更改手机号
#define UpdatePhon @"api/Agent/UpdatePhone"
//更改支付宝账号
#define AddChangeAlipy @"api/User/AddChangeAlipy"
//获取用户的原支付宝账号
#define Getalipayaccount @"api/Agent/Getalipayaccount"

//添加商户的基本信息(供码方的基本信息）
#define AddMerInfoRate @"api/User/AddMerInfoRate"

/** 生成链接界面接口 */
//获取代理商所有收款码
#define GetShopList @"api/PaymentCode/GetShopList"

//删除代理商费率
#define DelShopping @"api/PaymentCode/DelShopping"

/** 新增链接界面接口 */
//添加代理商收款码手续费
#define AddPaymentCode @"api/PaymentCode/AddPaymentCode"

/** 生成二维码界面接口 */
//生成付款
#define GetUrlQrCode @"api/Agent/GetUrl"
//代理商推广码链接
#define GetAuthQrCodeUrl @"api/Agent/GetAuthQrCodeUrl"

/** 余额界面接口 */
//获取代理商的余额
#define GetAccountBalance @"api/Account/GetAccountBalance"

//提现 == 结算
#define Withdrawal @"api/Agent/Withdrawal"

/** 收款记录-提现记录界面接口 */
//提现记录
#define balance_change @"api/Account/GetbalanceChange"

/** 账单宏观界面接口 */
//获取订单的当日的交易金额和笔数
#define GetOrderData @"api/Account/GetOrderData"
//获取所有商户的订单
#define GetOrder @"api/Account/GetOrder"

/** 账单微观详情界面接口 */
//获取订单详情
/** 版本接口更新接口 */
#define Getedition @"api/User/Getedition"

/** 我的界面接口 */
//我的费率
#define AgentRate @"api/Agent/AgentRate"
//获取所有的代理商
#define GetAgent @"api/Agent/GetAgent"

/** 钱包界面接口 */
//获取路径
#define GetAgentUrl @"api/Agent/GetAgentUrl"

/** 远程通知接口 */
//获取路径
#define AddTestFenrun @"api/Agent/AddTestFenrun"
//获取公告路径
#define GetAgentMessage @"api/Agent/GetAgentMessage"
//获取公告详情
#define GetAgentDetailMessage @"api/Agent/GetAgentMessageByMessageid"

//获取下级代理商所设置费率的范围
#define GETChildAgentArea @"api/Agent/GETChildAgentArea"

//下级代理商所设置费率的范围
#define GETAgentArea @"api/Agent/GETAgentArea"

//修改下级费率
#define SetAgentRate @"api/Agent/SetAgentRate"




#endif /* API_h */
