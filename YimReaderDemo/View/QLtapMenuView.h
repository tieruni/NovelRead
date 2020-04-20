//
//  QLtapMenuView.h
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/5.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QLBottomMenuView.h"
#import "QLTopMenuView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol QLMenuDelegate <NSObject>

-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page;
-(void)menuViewFontSize:(QLBottomMenuView *)bottomMenu;
-(void)menuViewInvokeCatalog:(QLBottomMenuView *)bottomMenu;

@end

@interface QLtapMenuView : UIView

@property (nonatomic,weak) id<QLMenuDelegate> delegate;

@property (nonatomic,strong) QLReadRecordModel *recordModel;
@property (nonatomic, strong) QLTopMenuView * topMenu;
@property (nonatomic, strong) QLBottomMenuView * bottomMenu;

-(void)showAnimation:(BOOL)animation;

-(void)hiddenMenuView;


@end

NS_ASSUME_NONNULL_END
