//
//  QLBottomMenuView.h
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/5.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol QLMenuDelegate;

@interface QLBottomMenuView : UIView

@property (nonatomic, weak) id<QLMenuDelegate>delegate;

@property (nonatomic,strong) QLReadRecordModel * recordModel;


@end


@interface LSYThemeView : UIView

@end




NS_ASSUME_NONNULL_END
