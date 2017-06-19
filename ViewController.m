//
//  ViewController.m
//  FFLoginView
//
//  Created by 鹭源 on 2017/6/19.
//  Copyright © 2017年 luyuan. All rights reserved.
//

#import "ViewController.h"
#import "FFLoginView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FFLoginView *view = [[FFLoginView alloc]initWithFrame:self.view.bounds];
    view.titleLabel.text = @"我是谢强,请输入";
    view.eyesType = AllEyesHide;
    [self.view addSubview:view];

    
    [view LoginBtnClickBlock:^(UITextField *userTF, UITextField *passwordTF) {
        NSString *message = [NSString stringWithFormat:@"账号：%@\n密码：%@",userTF.text,passwordTF.text];
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"登录提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }] ;
        [ac addAction:aa];
        
        [self presentViewController:ac animated:YES completion:nil];
    }];
    
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
