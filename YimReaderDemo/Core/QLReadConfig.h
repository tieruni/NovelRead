//
//  QLReadConfig.h
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/20.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
//
//typedef NS_ENUM(NSInteger, ReaderType)
//{
//    ReaderTXT,
//    ReaderEpub
//};


@interface QLReadConfig : NSObject<NSCoding>
+(instancetype)shareInstance;
@property (nonatomic, assign) CGFloat fontSize;// 字体大小
@property (nonatomic, assign) CGFloat lineSpace;// 行距
@property (nonatomic, strong) UIColor * fontColor;// 字体颜色
@property (nonatomic, strong) UIColor * theme;// 主题（背景颜色）

+ (void)separateChapter:(NSMutableArray * __strong *)chapters withContent:(NSString *)bookContent;

+ (NSDictionary *)parseAttribute:(QLReadConfig *)config;

@end

NS_ASSUME_NONNULL_END
