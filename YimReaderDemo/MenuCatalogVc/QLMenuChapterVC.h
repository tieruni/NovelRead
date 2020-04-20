//
//  QLMenuChapterVC.h
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/10.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QLMenuChapterVCDelegate <NSObject>

-(void)catalogDidSelectChapter:(NSUInteger)chapter page:(NSUInteger)page;

@end

@interface QLMenuChapterVC : UIViewController

@property (nonatomic,strong) QLReadBookModel * readModel;
@property (nonatomic,weak) id<QLMenuChapterVCDelegate>catalogDelegate;

@end

NS_ASSUME_NONNULL_END
