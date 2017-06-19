//
//  FFLoginView.h
//  FFLoginView
//
//  Created by 鹭源 on 2017/6/19.
//  Copyright © 2017年 luyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HideEyesType) {
    AllEyesHide = 0,    //全部遮住
    LeftEyeHide,    //遮住左眼
    RightEyeHide,   //遮住右眼
    NOEyesHide     //两只眼睛都漏一半
};

typedef void(^LoginBtnClickBolck)(UITextField *userTF, UITextField *passwordTF);

@interface FFLoginView : UIView<UITextFieldDelegate>

@property (nonatomic) LoginBtnClickBolck loginBtnClickBlock;
@property (nonatomic, strong) UITextField *userTF;//账号
@property (nonatomic, strong) UITextField *passwordTF;//密码
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UIButton *loginBtn;//登录

/**
 遮眼效果 默认为全部遮盖
 */
@property (nonatomic) HideEyesType eyesType;

- (void)LoginBtnClickBlock:(LoginBtnClickBolck)loginBtnClickBlock;
@end
