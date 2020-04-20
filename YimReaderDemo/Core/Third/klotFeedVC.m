//
//  cuiteFeedbackVC.m
//  cutieRescue
//
//  Created by blaceman on 2020/3/3.
//  Copyright © 2020 new4545. All rights reserved.
//

#import "klotFeedVC.h"
#import "Masonry.h"
#import "ReaderHomeViewController.h"
#import "PersonalCenterPageViewController.h"
@interface klotFeedVC ()
@property (nonatomic,strong)UIButton *feedbackBtn;

@end

@implementation klotFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setfeedBackView];
}

- (void)setfeedBackView{
    UIImageView *cuiteimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HomePage.jpg"]];
    [self.view addSubview:cuiteimageView];
    [cuiteimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    UILabel *emailLabel = [UILabel new];
    emailLabel.text = @"用户名：";
    emailLabel.textColor = [UIColor whiteColor];
    emailLabel.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(140);
        make.left.offset(32);
    }];
    
    UITextField *emailTextField = [[UITextField alloc]init];
    emailTextField.placeholder = @"请输入你的用户名";
//     [emailTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    emailTextField.textColor = [UIColor whiteColor];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    leftView.backgroundColor = [UIColor clearColor];
    emailTextField.leftView = leftView;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;

    [self.view addSubview:emailTextField];
    emailTextField.font = [UIFont systemFontOfSize:18];
    [emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailLabel.mas_bottom).offset(12);
        make.left.equalTo(emailLabel);
        make.right.offset(-80);
        make.height.mas_equalTo(40);
    }];
    emailTextField.layer.cornerRadius = 5.f;
    emailTextField.layer.borderWidth = 1;
    emailTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    emailTextField.layer.masksToBounds = YES;
    emailTextField.tag = 10;

    
    UILabel *feedLabel = [UILabel new];
    feedLabel.text = @"密码：";
    feedLabel.textColor = [UIColor whiteColor];
    feedLabel.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:feedLabel];
    [feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailTextField.mas_bottom).offset(48);
        make.left.equalTo(emailTextField);
    }];
    
    UITextField *feedBackTextField = [[UITextField alloc]init];
    feedBackTextField.textColor = [UIColor whiteColor];
    feedBackTextField.placeholder = @"请输入你的密码";
    feedBackTextField.tag = 12;
    UIView *leftView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    leftView2.backgroundColor = [UIColor clearColor];
    feedBackTextField.leftView = leftView2;
    feedBackTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:feedBackTextField];
    [feedBackTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feedLabel.mas_bottom).offset(12);
        make.left.equalTo(emailLabel);
        make.right.offset(-80);
        make.height.mas_equalTo(40);
    }];
    feedBackTextField.font = [UIFont systemFontOfSize:18];
    feedBackTextField.layer.cornerRadius = 5.f;
    feedBackTextField.layer.borderWidth = 1;
    feedBackTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    feedBackTextField.layer.masksToBounds = YES;
    
    
    self.feedbackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:self.feedbackBtn];
    
    
    // 按钮
    [self.feedbackBtn setBackgroundImage:[UIImage imageNamed:@"按钮.png"] forState:(UIControlStateNormal)];
    [self.feedbackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(feedBackTextField.mas_bottom).offset(66);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(72);
    }];
    [self.feedbackBtn addTarget:self action:@selector(feedbackAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.feedbackBtn setTitle:@"feedback" forState:(UIControlStateNormal)];
//    [self.feedbackBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    self.feedbackBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    UILabel *feedbackLabel = [UILabel new];
    feedbackLabel.text = @"登陆";
    feedbackLabel.textColor = [UIColor whiteColor];
    feedbackLabel.font = [UIFont systemFontOfSize:18];
    [self.feedbackBtn addSubview:feedbackLabel];
    [feedbackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    // 返回
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:btn];
//    btn.frame = CGRectMake(20, 30, 32, 32);
//    [btn setImage:[UIImage imageNamed:@"klotResource/back.png"] forState:(UIControlStateNormal)];
//    [btn addTarget:self action:@selector(feedBackDissAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)feedbackAction:(UIButton *)sender{
    [self feedBackAction];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
}

- (void)feedBackAction{
    UILabel *tipLabel = [UILabel new];
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.backgroundColor = [UIColor whiteColor];
    UITextField *emailField = [self.view viewWithTag:10];
    UITextField *feedField = [self.view viewWithTag:12];
    if (emailField.text.length > 0 && feedField.text.length > 0) {
        tipLabel.text = @"登录成功！";
    }else{
        tipLabel.text = @"账号名或密码不能为空！";
    }

    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (emailField.text.length > 0 && feedField.text.length > 0) {
            [self loginReadBook];
        }else{
            [tipLabel removeFromSuperview];
        }
    });
}



- (void)loginReadBook
{
    //1.创建Tab所属的ViewController
    // 看书首页
    ReaderHomeViewController *homeVC = [[ReaderHomeViewController alloc] init];
    
    
    
    
    UITabBarItem * homeTabItem = [[UITabBarItem alloc] initWithTitle:@"看书" image:[[UIImage imageNamed:@"ReadingIcon.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ReadingIcon.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

//    UITabBarItem* homeTabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
//    homeTabItem.title = @"看书";
    homeVC.tabBarItem = homeTabItem;
    //    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    //    homeNav.navigationBar.translucent = NO;
    
    
    //    //工作
    PersonalCenterPageViewController * PersonalCenterPageVC = [[PersonalCenterPageViewController alloc]init];
    //    UINavigationController *PersonalCenterPageVCNav = [[UINavigationController alloc] initWithRootViewController:PersonalCenterPageVC];
    //    PersonalCenterPageVCNav.navigationBar.translucent = NO;
    UITabBarItem * PerSonCenItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[[UIImage imageNamed:@"PersonalCenterIcon.jpeg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"PersonalCenterIcon.jpeg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    UITabBarItem * PerSonCenItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
//    PerSonCenItem.title = @"个人中心";
    PersonalCenterPageVC.tabBarItem = PerSonCenItem;
    
    
    //2、创建一个数组，放置多有控制器
    NSArray *vcArray = [NSArray arrayWithObjects:homeVC,PersonalCenterPageVC, nil];
    
    //3、创建UITabBarController，将控制器数组设置给UITabBarController
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
    //设置多个Tab的ViewController到TabBarViewController
    tabBarVC.viewControllers = vcArray;
    //4、将UITabBarController设置为Window的RootViewController
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    [[tabBarVC tabBar]setTranslucent:NO];
    
}



- (void)feedBackDissAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
