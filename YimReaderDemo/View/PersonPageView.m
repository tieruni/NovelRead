//
//  PersonPageView.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/11.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "PersonPageView.h"

@interface PersonPageView()

@property (nonatomic, strong) UIButton * Avatar;
@property (nonatomic, strong) UIButton * UserName;

@property (nonatomic, strong) UIButton * AboutUs;
@property (nonatomic, strong) UIButton * SharedButton;


@end

@implementation PersonPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _Avatar.frame = CGRectMake(ViewFrameSize(self).width/2 - 50, 150, 100, 100);
    _UserName.frame = CGRectMake(ViewFrameSize(self).width/2 - 50, DistanceFromTopView(_Avatar), 100, 40);
    _SharedButton.frame = CGRectMake(20, ViewFrameSize(self).height - 130, 60, 80);
    _AboutUs.frame = CGRectMake(ViewFrameSize(self).width - 120, ViewFrameSize(self).height - 130, 100, 80);
    
    
    _Avatar.userInteractionEnabled = NO;
    _UserName.userInteractionEnabled = NO;
    _AboutUs.enabled = NO;
}


#pragma mark - setter getter | init

- (UIButton *)Avatar
{
    if (!_Avatar)
    {
        _Avatar = [[UIButton alloc]init];
        _Avatar.layer.cornerRadius = 15.f;
        _Avatar.layer.masksToBounds = YES;
//        [_Avatar setTintColor:[UIColor whiteColor]];
//        [_Avatar.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_Avatar addTarget:self action:@selector(changeAvatar) forControlEvents:UIControlEventTouchUpInside];
        [_Avatar setImage:[UIImage imageNamed:@"Avatar1.jpeg"] forState:UIControlStateNormal];
    }
    return _Avatar;
}

- (UIButton *)UserName
{
    if (!_UserName)
    {
        _UserName = [QLReadParser ReadButtonToTarget:self action:@selector(changeUserName)];
        [_UserName setTitle:@"书友9527" forState:UIControlStateNormal];
        [_UserName.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _UserName.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _UserName;
}

- (UIButton *)AboutUs
{
    if (!_AboutUs)
    {
        _AboutUs = [QLReadParser ReadButtonToTarget:self action:@selector(showAboutUs)];
        [_AboutUs setTitle:@"关于我们" forState:UIControlStateNormal];
        [_AboutUs.titleLabel setFont:[UIFont systemFontOfSize:24]];

        _AboutUs.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [_AboutUs.titleLabel setTextColor:[UIColor darkGrayColor]];
    }
    return _AboutUs;
}

- (UIButton *)SharedButton
{
    if (!_SharedButton)
    {
        _SharedButton = [QLReadParser ReadButtonToTarget:self action:@selector(clickShared)];
        [_SharedButton setTitle:@"分享" forState:UIControlStateNormal];
        [_SharedButton.titleLabel setFont:[UIFont systemFontOfSize:24]];

        _SharedButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _SharedButton.tintColor = [UIColor cyanColor];
    }
    return _SharedButton;
}


#pragma mark - private Method

- (void)setupUI
{
    // 背景图
    UIImageView * myPersonalPageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Personalpage.jpg"]];
    myPersonalPageView.frame = self.bounds;
    
    [self addSubview:myPersonalPageView];
    [self addSubview:self.Avatar];
    [self addSubview:self.UserName];
    [self addSubview:self.AboutUs];
    [self addSubview:self.SharedButton];

    
}

- (void)changeAvatar
{
    
}

- (void)changeUserName
{
    
}


- (void)showAboutUs
{
    
}

// 分享
- (void)clickShared
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:@"小说分享～"];
    //这里是一张本地的图片
    [items addObject:[UIImage imageNamed:@"HomePage.jpg"]];
    [items addObject:[NSURL URLWithString:@"http://hongmingzhange.mysxl.cn/"]];

    //    NSArray * items =  @[[UIImage imageNamed:@"klotResource/gameLogoImg.jpg"],@"游戏介绍：这是一款华容道玩法的拼图游戏，需要你充分发挥你的手速和观察能力，有不同难度和图片可以选择，用时越短，步数越少，你的排名和获得的星星就越高，快来一起拼个高下吧"];    //分享图片 数组


    UIActivityViewController * activityCtl = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityCtl animated:YES completion:nil];
    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[UIActivityViewController alloc]initWithActivityItems:@[[UIImage imageNamed:@"klotResource/gameLogoImg.jpg"],@"游戏介绍：这是一款华容道玩法的拼图游戏，需要你充分发挥你的手速和观察能力，有不同难度和图片可以选择，用时越短，步数越少，你的排名和获得的星星就越高，快来一起拼个高下吧",[NSURL URLWithString:@"http://hongmingzhange.mysxl.cn/"]] applicationActivities:nil] animated:YES completion:nil];

    
}






@end
