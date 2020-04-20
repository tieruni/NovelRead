//
//  QLtapMenuView.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/5.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "QLtapMenuView.h"

@interface QLtapMenuView()<QLMenuDelegate>

@end

@implementation QLtapMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topMenu];
    [self addSubview:self.bottomView];

    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenMenuView)]];
}

# pragma mark - getter setter 、 init

-(QLTopMenuView *)topMenu
{
    if (!_topMenu) {
        _topMenu = [[QLTopMenuView alloc] initWithFrame:CGRectMake(0, -TopViewHeight, ViewFrameSize(self).width,TopViewHeight)];
//        _topMenu.delegate = self;
    }
    return _topMenu;
}

-(QLBottomMenuView *)bottomView
{
    if (!_bottomMenu) {
        _bottomMenu = [[QLBottomMenuView alloc] initWithFrame:CGRectMake(0, ViewFrameSize(self).height, ViewFrameSize(self).width,BottomViewHeight)];
        _bottomMenu.delegate = self;
    }
    return _bottomMenu;
}

- (void)setRecordModel:(QLReadRecordModel *)recordModel
{
    _recordModel = recordModel;
    _bottomMenu.recordModel = recordModel;
}


# pragma mark - private Method
-(void)showAnimation:(BOOL)animation
{
    self.hidden = NO;
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        self.topMenu.frame = CGRectMake(0, 0, ViewFrameSize(self).width, TopViewHeight);
        self.bottomMenu.frame = CGRectMake(0, ViewFrameSize(self).height-BottomViewHeight, ViewFrameSize(self).width,BottomViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    // 状态栏
//    if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
//        [self.delegate menuViewDidAppear:self];
//    }
    
}


-(void)hiddenMenuView
{
    [UIView animateWithDuration:AnimationDelay animations:^{
        self.topMenu.frame = CGRectMake(0, -TopViewHeight, ViewFrameSize(self).width, TopViewHeight);
        self.bottomMenu.frame = CGRectMake(0, ViewFrameSize(self).height, ViewFrameSize(self).width,BottomViewHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
//    if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
//        [self.delegate menuViewDidHidden:self];
//    }}
}



#pragma mark - QLMenuDelegate

-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
        [self.delegate menuViewJumpChapter:chapter page:page];
    }
}

-(void)menuViewFontSize:(QLBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:bottomMenu];
    }
}

-(void)menuViewInvokeCatalog:(QLBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:bottomMenu];
    }
}

@end
