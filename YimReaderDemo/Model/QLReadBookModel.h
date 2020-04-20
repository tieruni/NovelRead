//
//  QLReadBookModel.h
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/19.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLReaderChapterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QLReadBookModel : NSObject <NSCoding>

@property (nonatomic, strong) NSMutableArray <QLReaderChapterModel *> * chapters;
@property (nonatomic,strong) QLReadRecordModel *RBrecord;
@property (nonatomic, strong) NSString * BookContent;
@property (nonatomic,strong) NSURL *resource;




+(void)updateLocalModel:(QLReadBookModel *)readModel url:(NSURL *)url;

+ (id)getReadBookModelWithLocalURL:(NSURL *)txtURL;

@end

NS_ASSUME_NONNULL_END
