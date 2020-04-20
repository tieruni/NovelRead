//
//  PersonalCenterPageViewController.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/11.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "PersonalCenterPageViewController.h"
#import "PersonPageView.h"

@interface PersonalCenterPageViewController ()

@property (nonatomic, strong) PersonPageView * myPersonPage;

@end

@implementation PersonalCenterPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myPersonPage];
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 64, 0);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}


#pragma mark - setter getter | init

- (PersonPageView *)myPersonPage
{
    if (!_myPersonPage)
    {
        _myPersonPage = [[PersonPageView alloc]initWithFrame:self.view.frame];
    }
    
    return _myPersonPage;
}





@end
