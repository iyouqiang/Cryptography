//
//  ViewController.m
//  002--RSA代码
//
//  Created by H on 2017/2/15.
//  Copyright © 2017年 TZ. All rights reserved.
//  在日常开发中 用 RSA & AES 组合使用!!
//  1.AES对数据本身加密 & 解密    2. RSA 对 AES(KEY)密钥进行加密!!

#import "ViewController.h"
#import "RSACryptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.加载公钥
    [[RSACryptor sharedRSACryptor] loadPublicKey:[[NSBundle mainBundle] pathForResource:@"rsacert.der" ofType:nil]];
    //2. 加载私钥 - P12的文件  password : 生成P12 的时候设置的密码
    [[RSACryptor sharedRSACryptor] loadPrivateKey:[[NSBundle mainBundle] pathForResource:@"p.p12" ofType:nil] password:@"123456"];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSData * reault = [[RSACryptor sharedRSACryptor] encryptData:[@"hello" dataUsingEncoding:NSUTF8StringEncoding]];
    //base64 编码
    NSString * base64 = [reault base64EncodedStringWithOptions:0];
    NSLog(@"加密的信息: %@",base64);
    
    //解密
    NSData * jiemi = [[RSACryptor sharedRSACryptor] decryptData:reault];
    NSLog(@"%@",[[NSString alloc]initWithData:jiemi encoding:NSUTF8StringEncoding]);
}


@end
