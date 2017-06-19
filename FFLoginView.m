//
//  FFLoginView.m
//  FFLoginView
//
//  Created by 鹭源 on 2017/6/19.
//  Copyright © 2017年 luyuan. All rights reserved.
//

#import "FFLoginView.h"
#import "UIView+SetRect.h"

typedef NS_ENUM(NSInteger, WSLoginShowType) {
    WSLoginShowType_USER = 0,
    WSLoginShowType_PASS
};

@implementation FFLoginView
{
    WSLoginShowType showType;
    
    UIVisualEffectView *smallView;
    
    UIImageView* imgLeftHand;
    UIImageView* imgRightHand;
    
    UIImageView* imgLeftHandGone;
    UIImageView* imgRightHandGone;
    
    CGRect imgleftHandRect;
    CGRect imgRightHandRect;
    CGRect imgLeftHandGoneRect;
    CGRect imgRightHandGoneRect;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBackGround];
        [self createSubViews];
    }
    return self;
}
         
/**
 创建背景
 */
- (void)createBackGround {
    //1.背景图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self addSubview:imageView];
    //2.模糊
    UIVisualEffectView *veView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    veView.frame = imageView.bounds;
    [imageView addSubview:veView];
}

/**
 创建子视图
 */
- (void)createSubViews
{
    //1.猫头鹰部分
    //1.1.尺寸
    CGFloat topMargin = 100;
    CGFloat imgViewW = 211;//猫头宽度
    CGFloat imgViewH = 108;//猫头高度
    CGFloat handViewW = 40;//捂眼左右爪宽度
    CGFloat handViewH = 65;//捂眼左右爪高度
    CGFloat handViewWH = 40;//展开左右爪宽高
    //1.2.猫头
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, topMargin, imgViewW, imgViewH)];
    imgView.centerX = self.centerX;  
    imgView.image = [UIImage imageNamed:@"owl-login"];
    imgView.layer.masksToBounds = YES;
    [self addSubview:imgView];
    
    //1.3.捂眼的左右爪
    imgLeftHand = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, handViewW, handViewH)];
    imgLeftHand.bottom = imgView.height + handViewH - 20;
    imgLeftHand.image = [UIImage imageNamed:@"owl-login-arm-left"];
    [imgView addSubview:imgLeftHand];
    
    
    imgRightHand = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, handViewW, handViewH)];
    imgRightHand.right = imgView.width;
    imgRightHand.bottom = imgView.height + handViewH - 20;
    imgRightHand.image = [UIImage imageNamed:@"owl-login-arm-right"];
    [imgView addSubview:imgRightHand];
    
    
    //1.4.展开的左右爪
    imgLeftHandGone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, handViewWH, handViewWH)];
    imgLeftHandGone.bottom = imgView.height + 8;
    imgLeftHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [imgView addSubview:imgLeftHandGone];
    
    
    imgRightHandGone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, handViewWH, handViewWH)];
    imgRightHandGone.bottom = imgView.height + 8;
    imgRightHandGone.right = imgView.width;
    imgRightHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [imgView addSubview:imgRightHandGone];
    
    
    //2.登录框部分
    //2.1.登录框背景视图
    smallView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    CGFloat marginX = 20;
    smallView.frame = CGRectMake(marginX, 0, self.width - marginX * 2, self.width - marginX * 2);
    smallView.y = imgView.bottom - 10;
    smallView.layer.cornerRadius = 5;
    smallView.layer.masksToBounds = YES;
    [self addSubview:smallView];
    
    //2.2标题
    CGFloat sMarginX = 20;//
    CGFloat sMarginY = 10;//
    CGFloat height = 40;//label textfield button 的高度
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, sMarginY, smallView.width, height)];
    self.titleLabel.textColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [smallView addSubview:self.titleLabel];
    
    //2.3账号textfield
    
    self.userTF = [[UITextField alloc]initWithFrame:CGRectMake(sMarginX, _titleLabel.bottom + sMarginY, smallView.width - sMarginX *2, height)];
    self.userTF.delegate = self;
    self.userTF.layer.cornerRadius = 5;
    self.userTF.layer.borderWidth = .5;
    self.userTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userTF.layer.borderColor = [UIColor grayColor].CGColor;
    self.userTF.placeholder = @"请输入账号";
    self.userTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.userTF.height, self.userTF.height)];
    self.userTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    [self.userTF.leftView addSubview:imgUser];
    [smallView addSubview:self.userTF];
    
    //2.4密码textField
    self.passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(sMarginX, _userTF.bottom + sMarginY, smallView.width - sMarginX *2, height)];
    self.passwordTF.delegate = self;
    self.passwordTF.layer.cornerRadius = 5;
    self.passwordTF.layer.borderWidth = .5;
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.layer.borderColor = [UIColor grayColor].CGColor;
    self.passwordTF.placeholder = @"请输入密码";
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.passwordTF.frame), CGRectGetHeight(self.passwordTF.frame))];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 28, 28)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [self.passwordTF.leftView addSubview:imgPwd];
    [smallView addSubview:self.passwordTF];
    
    //2.5登录按钮
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(sMarginX, _passwordTF.bottom + sMarginY, smallView.width - sMarginX *2, height)];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:149/255.0 blue:232/255.0 alpha:1]];
    [self.loginBtn addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:self.loginBtn];
    
    //3.修正smallView的高度
    smallView.height = height * 4 + sMarginY * 5;
    
    //4.
    imgleftHandRect = imgLeftHand.frame;
    imgRightHandRect = imgRightHand.frame;
    imgLeftHandGoneRect = imgLeftHandGone.frame;
    imgRightHandGoneRect = imgRightHandGone.frame;
}
- (void)LoginAction:(UIButton *)sender{
    [self.userTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    if (_loginBtnClickBlock) {
        _loginBtnClickBlock(self.userTF, self.passwordTF);
    }
}
//
- (void)LoginBtnClickBlock:(LoginBtnClickBolck)loginBtnClickBlock
{
    self.loginBtnClickBlock = loginBtnClickBlock;
}
//设置眼睛方式的set方法
- (void)setEyesType:(HideEyesType)eyesType
{
    _eyesType = eyesType;
}
#pragma mark - 屏幕点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.window resignFirstResponder];
}

#pragma mark - textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.userTF isEqual:textField]) {
        self.titleLabel.text = @"我就看，咋的！";
        if (showType == WSLoginShowType_USER)
        {
            showType = WSLoginShowType_USER;
            return;
        }
        showType = WSLoginShowType_USER;
        [UIView animateWithDuration:0.5 animations:^{
            imgLeftHand.frame = imgleftHandRect;
            imgRightHand.frame = imgRightHandRect;
            imgLeftHandGone.frame = imgLeftHandGoneRect;
            imgRightHandGone.frame = imgRightHandGoneRect;
        } completion:^(BOOL finished) {
            
        }];
    }
    else if ([self.passwordTF isEqual:textField]) {
        self.titleLabel.text = @"我偏不看，咬我啊！";
        if (showType == WSLoginShowType_PASS)
        {
            showType = WSLoginShowType_PASS;
            return;
        }
        showType = WSLoginShowType_PASS;
        
        if (_eyesType == AllEyesHide) {//全部遮盖眼睛
            [self transViewsWithLeftOffsetX:60 rightOffsetX:60 leftOffsetY:30 rightOffset:30];
        }
        else if (_eyesType == LeftEyeHide) {//遮盖左眼
            [self transViewsWithLeftOffsetX:60 rightOffsetX:48 leftOffsetY:30 rightOffset:30];
        }
        else if (_eyesType == RightEyeHide) {//遮盖右眼
            [self transViewsWithLeftOffsetX:48 rightOffsetX:60 leftOffsetY:30 rightOffset:30];
        }
        else if (_eyesType == NOEyesHide) {//不遮盖眼
            [self transViewsWithLeftOffsetX:48 rightOffsetX:48 leftOffsetY:30 rightOffset:30];
        }

    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.titleLabel.text = @"我就是我，不一样的烟火";
    if ([textField isEqual:self.passwordTF]) {
        if (showType == WSLoginShowType_PASS)
        {
            showType = WSLoginShowType_USER;
            [UIView animateWithDuration:0.5 animations:^{
                imgLeftHand.frame = imgleftHandRect;
                imgRightHand.frame = imgRightHandRect;
                imgLeftHandGone.frame = imgLeftHandGoneRect;
                imgRightHandGone.frame = imgRightHandGoneRect;
                
            } completion:^(BOOL b) {
            }];
            
        }
    }
   
    
}

- (void)transViewsWithLeftOffsetX:(CGFloat)lx rightOffsetX:(CGFloat)rx leftOffsetY:(CGFloat)ly rightOffset:(CGFloat)ry
{
    [UIView animateWithDuration:0.5 animations:^{
        imgLeftHand.frame = CGRectMake(imgLeftHand.x + lx, imgLeftHand.y - ly, imgLeftHand.width, imgLeftHand.height);
        imgRightHand.frame = CGRectMake(imgRightHand.x - rx, imgRightHand.y - ry, imgRightHand.width, imgRightHand.height);
        
        
        imgLeftHandGone.frame = CGRectMake(imgLeftHandGone.x + lx + 10, imgLeftHandGone.y, 0, 0);
        
        imgRightHandGone.frame = CGRectMake(imgRightHandGone.x - rx + 10, imgRightHandGone.y, 0, 0);
        
    } completion:^(BOOL b) {
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
