//
//  ViewController.m
//  001--登录
//
//  Created by H on 2017/2/10.
//  Copyright © 2017年 TZ. All rights reserved.
//
//  1.NSUserDefaults  -- 明文保存才能反算(能够反算的算法)
//  2.钥匙串访问 -- 开放给开发者是 7.0.3版本

#import "ViewController.h"
#import "NSString+Hash.h"
#import "SSKeychain.h"

/* 盐*/
static NSString * salt = @"lkajsd;flj)(*@$!#(*&OJKD(*&)291IOJPOIHCD*FUPOH$RO*UOIDSHFP(*EWUJRT:LK@#$U(*)_Q#R()IJD*(F_U";


#define HKLoginServiceName @"HKLoginServiceName"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *UserText;
@property (weak, nonatomic) IBOutlet UITextField *PwdText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载用户信息
    [self loadUserInfo];
    
}
- (IBAction)login:(id)sender {
    //发请求给服务器 -- 验证
    NSString * user = self.UserText.text;
    //密码 明文的!!
    NSString * pwd = self.PwdText.text;
    // 1. ------------- MD5 加密 --------------
//    pwd = pwd.md5String;
    // 2. ------------- MD5 加盐 --------------
    //不足:盐是固定的!有人知道!!
//    pwd = [pwd stringByAppendingString:salt].md5String;
    // 3. ------------- HMAC --------------
    // 在实际开发中,密钥来自于服务器!! 注册的时候!!
    NSString * key = nil;//通过钥匙串访问来获取这个key
    if (key == nil) {
        //1.发送网络请求!获取密钥!!
        //2.展示"小菊花!!!"
        key = [self getKeyWithAccunt:user];
        //展示等待授权页面!!
        
        //立刻马上保存这个KEY在本地!! -- 通过钥匙串访问!
        
    }
    pwd = [pwd hmacMD5StringWithKey:key];
    
    
    NSLog(@"现在的密码是:%@",pwd);
    
    //模拟网络请求!!
    if( [self isLoginWithUserId:user PassWord:pwd]){
        //保存账号密码 明文账号--密码
        [self savePwdWithAccunt:self.UserText.text Pwd:self.PwdText.text];
        NSLog(@"登录成功");
    }else{
        NSLog(@"登录失败");
    }
    
}

//加载本地用户信息
-(void)loadUserInfo{
    //加载账号
    self.UserText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"HKLoginUserName"];
    //找出所有的账号
    self.PwdText.text = [SSKeychain passwordForService:HKLoginServiceName account:self.UserText.text];
}


//保存账号密码
-(void)savePwdWithAccunt:(NSString *)accunt Pwd:(NSString *)pwd{
    //保存账号
    [[NSUserDefaults standardUserDefaults] setObject:self.UserText.text forKey:@"HKLoginUserName"];
    //同步 -- 立刻马上保存!
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //保存密码
    if (accunt.length > 0 && pwd.length> 0) {
        /**
         *  参数
         *  1. 密码明文
         *  2. 服务,可以随便写,但是他是APP的一个标识,建议用BundleID
         *  3. 账号,用户名
         */
        [SSKeychain setPassword:pwd forService:HKLoginServiceName account:accunt];
    }
}


//获取授权信息 -- 等待设备授权!!
-(NSString *)getKeyWithAccunt:(NSString *)accunt{
    //1.需要授权
    //2.直接返回密钥
    return @"hank";
}

- (BOOL)isLoginWithUserId:(NSString *)userid PassWord:(NSString *)passw{
    if ([userid isEqualToString:@"hank"] && [passw isEqualToString:@"e9cdab82d48dcd37af7734b6617357e6"]) {
        return YES;
    }else{
        return NO;
    }
    
}


@end
