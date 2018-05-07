//
//  ViewController.m
//  001--对称加密算法演练
//
//  Created by H on 2017/2/15.
//  Copyright © 2017年 TZ. All rights reserved.
//  哈希:不可逆!  --  验证!信息摘要
//

#import "ViewController.h"
#import "EncryptionTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //AES - ECB 加密
    NSString * key = @"hk";
    //加密
    NSLog(@"加密: %@",[[EncryptionTools sharedEncryptionTools] encryptString:@"hello" keyString:key iv:nil]);
    //解密
    NSLog(@"解密: %@",[[EncryptionTools sharedEncryptionTools] decryptString:@"cKRPM1ALLG+0q5qCjADoaQ==" keyString:key iv:nil]);
    
    
    
    //AES - CBC 加密
    uint8_t iv[8] = {2,3,4,5,6,7,0,0}; //直接影响加密结果!
    NSData * ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    NSLog(@"CBC加密: %@",[[EncryptionTools sharedEncryptionTools] encryptString:@"hello" keyString:key iv:ivData]);
    
    NSLog(@"CBC解密: %@", [[EncryptionTools sharedEncryptionTools] decryptString:@"+dv/u4juE0WE3S9XSFyibA==" keyString:key iv:ivData]);
    
    //DES - ECB 加密
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    NSLog(@"DES 加密%@",[[EncryptionTools sharedEncryptionTools] encryptString:@"hello" keyString:key iv:nil]);
    NSLog(@"DES 解密: %@", [[EncryptionTools sharedEncryptionTools] decryptString:@"vTuv8E5AlWQ=" keyString:key iv:nil]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
