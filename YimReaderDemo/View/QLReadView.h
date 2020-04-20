//
//  QLReadView.h
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/19.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
//@protocol QLReadViewControllerDelegate;

@interface QLReadView : UIView
@property (nonatomic,assign) CTFrameRef frameRef;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSArray * imageArray;
//@property (nonatomic,strong) id<QLReadViewControllerDelegate>delegate;



@end

NS_ASSUME_NONNULL_END
