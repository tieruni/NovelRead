//
//  QLReaderChapterModel.h
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/24.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLReaderChapterModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSUInteger pageCount;

-(NSString *)stringOfPage:(NSUInteger)index;
-(void)updateChapterText;

@end

NS_ASSUME_NONNULL_END
