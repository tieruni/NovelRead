//
//  QLReadViewController.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/10/23.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReadViewController.h"

@interface QLReadViewController ()

@end

@implementation QLReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    //theme 白色背景
    [self.view setBackgroundColor:[QLReadConfig shareInstance].theme];
    [self.view addSubview:self.readView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme:) name:QLBottomThemeNotification object:nil];
}


-(void)changeTheme:(NSNotification *)no
{
    [QLReadConfig shareInstance].theme = no.object;
    [self.view setBackgroundColor:[QLReadConfig shareInstance].theme];
}


-(QLReadView *)readView
{
    // initWithFrame方法被重写，添加了两个手势识别方法。一个长按选择文本，一个长按后的拖动选择文本。
    if (!_readView) {
        _readView = [[QLReadView alloc] initWithFrame:CGRectMake(LeftSpacing,TopSpacing, self.view.frame.size.width-LeftSpacing-RightSpacing, self.view.frame.size.height-TopSpacing-BottomSpacing)];
        QLReadConfig *config = [QLReadConfig shareInstance];

        // CTFrameRef后面 drawRect:() 用来绘画文本到View上了
        _readView.frameRef = [QLReadParser parserContent:_content config:config bouds:CGRectMake(0,0, _readView.frame.size.width, _readView.frame.size.height)];
        
        _readView.content = _content;
//        _readView.delegate = self;
    }
    return _readView;
}


//-(void)readViewEditeding:(QLReadViewController *)readView
//{
//    if ([self.delegate respondsToSelector:@selector(readViewEditeding:)]) {
//        [self.delegate readViewEditeding:self];
//    }
//}
//-(void)readViewEndEdit:(QLReadViewController *)readView
//{
//    if ([self.delegate respondsToSelector:@selector(readViewEndEdit:)]) {
//        [self.delegate readViewEndEdit:self];
//    }
//}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
