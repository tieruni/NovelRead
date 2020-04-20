//
//  QLReadRecordModel.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/10/23.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReadRecordModel.h"

@implementation QLReadRecordModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chapterModel forKey:@"chapterModel"];
    [aCoder encodeInteger:self.page forKey:@"page"];
    [aCoder encodeInteger:self.chapter forKey:@"chapter"];
    [aCoder encodeInteger:self.chapterCount forKey:@"chapterCount"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.chapterModel = [aDecoder decodeObjectForKey:@"chapterModel"];
        self.page = [aDecoder decodeIntegerForKey:@"page"];
        self.chapter = [aDecoder decodeIntegerForKey:@"chapter"];
        self.chapterCount = [aDecoder decodeIntegerForKey:@"chapterCount"];
    }
    return self;
}


@end
