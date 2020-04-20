//
//  QLMenuCataLogViewController.h
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/10.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol QLMenuChapterVCDelegate;

@interface QLMenuCataLogViewController : UIViewController
@property (nonatomic,strong) QLReadBookModel *readModel;
-(void)reload;

@property (nonatomic,weak) id<QLMenuChapterVCDelegate>catalogDelegate;


@end


@interface QLCatalogPagerTitleButton : UIButton

@end




NS_ASSUME_NONNULL_END
