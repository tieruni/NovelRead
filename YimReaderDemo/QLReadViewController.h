//
//  QLReadViewController.h
//  YimReaderDemo
//
//  Created by Yimmm on 2019/10/23.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QLReadViewController;
//@protocol QLReadViewControllerDelegate <NSObject>
//-(void)readViewEditeding:(QLReadViewController *)readView;
//-(void)readViewEndEdit:(QLReadViewController *)readView;
//@end


@interface QLReadViewController : UIViewController

@property (nonatomic,strong) NSString *content; //显示的内容
@property (nonatomic,strong) QLReadRecordModel * recordModel;   //阅读进度
@property (nonatomic,strong) QLReadView * readView;

//@property (nonatomic,weak) id<QLReadViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
