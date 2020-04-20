//
//  ReaderHomeViewController.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/11.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "ReaderHomeViewController.h"
#import "View/ReaderHomeView.h"

@interface ReaderHomeViewController ()

@property (nonatomic, strong) ReaderHomeView * myHomeView;
@end

@implementation ReaderHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.myHomeView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    // Do any additional setup after loading the view.
}

#pragma mark - setter getter | init
- (ReaderHomeView *)myHomeView
{
    if (!_myHomeView)
    {
        _myHomeView = [[ReaderHomeView alloc]initWithFrame:CGRectMake(0, 0, ViewFrameSize(self.view).width, ViewFrameSize(self.view).height)];
    }
    return _myHomeView;
}


@end
