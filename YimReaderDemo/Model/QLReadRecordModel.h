//
//  QLReadRecordModel.h
//  YimReaderDemo
//
//  Created by Yimmm on 2019/10/23.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLReaderChapterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QLReadRecordModel : NSObject <NSCoding>
@property (nonatomic,strong) QLReaderChapterModel * chapterModel;  //阅读的章节
@property (nonatomic, assign) NSUInteger page;  //阅读的页数
@property (nonatomic, assign) NSUInteger chapter;    //阅读的章节数
@property (nonatomic, assign) NSUInteger chapterCount;  //总章节数


@end

NS_ASSUME_NONNULL_END
