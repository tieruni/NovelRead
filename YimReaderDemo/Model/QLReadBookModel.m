//
//  QLReadBookModel.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/19.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReadBookModel.h"

@implementation QLReadBookModel

- (instancetype)initWithContent:(NSString *)content
{
    self = [super init];
    if(self)
    {
        _BookContent = content;
        // 分章节，存储章节信息，一章文本
        NSMutableArray * charpters = [NSMutableArray array];
        [QLReadConfig separateChapter:&charpters withContent:content];
        _chapters = charpters;
        
        _RBrecord = [[QLReadRecordModel alloc] init];
        _RBrecord.chapterModel = charpters.firstObject;
        _RBrecord.chapterCount = _chapters.count;
        
    }
    
    return self;
}


- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.BookContent forKey:@"BookContent"];
    [aCoder encodeObject:self.chapters forKey:@"chapters"];
    [aCoder encodeObject:self.RBrecord forKey:@"RBrecord"];
    [aCoder encodeObject:self.resource forKey:@"resource"];
    //    [aCoder encodeObject:self.marks forKey:@"marks"];
    //    [aCoder encodeObject:self.notes forKey:@"notes"];
//    [aCoder encodeObject:self.marksRecord forKey:@"marksRecord"];
//    [aCoder encodeObject:@(self.type) forKey:@"type"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.BookContent = [aDecoder decodeObjectForKey:@"BookContent"];
        self.chapters = [aDecoder decodeObjectForKey:@"chapters"];
        self.RBrecord = [aDecoder decodeObjectForKey:@"RBrecord"];
        self.resource = [aDecoder decodeObjectForKey:@"resource"];
//        self.marks = [aDecoder decodeObjectForKey:@"marks"];
//        self.notes = [aDecoder decodeObjectForKey:@"notes"];
//        self.marksRecord = [aDecoder decodeObjectForKey:@"marksRecord"];
//        self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
    }
    return self;
}





+(void)updateLocalModel:(QLReadBookModel *)readModel url:(NSURL *)url
{
    NSString *key = [url.path lastPathComponent];
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:readModel forKey:key];
    [archiver finishEncoding];
    // [archiver finishEncoding]之后data就有值了。
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}




//读取本地文本资源
+ (id)getReadBookModelWithLocalURL:(NSURL *)txtURL
{
    NSString * lastpathComponent = [txtURL.path lastPathComponent];
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:lastpathComponent];
    if (!myData)
    {
        if ([[lastpathComponent pathExtension] isEqualToString:@"txt"])
        {
            NSString * BookContent = [QLReadBookModel encodingWithUrl:txtURL];
            QLReadBookModel * ReadModel = [[QLReadBookModel alloc]initWithContent:BookContent];
            ReadModel.resource = txtURL;
            [QLReadBookModel updateLocalModel:ReadModel url:txtURL];
            return ReadModel;
        }
        else
        {
            @throw [NSException exceptionWithName:@"FileException" reason:@"文件格式错误" userInfo:nil];
        }
    }
    
    NSKeyedUnarchiver *unarchive = [[NSKeyedUnarchiver alloc]initForReadingWithData:myData];
    //主线程操作
    QLReadBookModel *ReadModel = [unarchive decodeObjectForKey:lastpathComponent];

    return ReadModel;
}



#pragma mark - Txt解码操作
// 解码中文小说
+ (NSString *)encodingWithUrl:(NSURL *)contentURL
{
    if(!contentURL)
    {
        return @"";
    }
    NSString * content = [NSString stringWithContentsOfURL:contentURL encoding:NSUTF8StringEncoding error:nil];
    if (!content) {
        content = [NSString stringWithContentsOfURL:contentURL encoding:0x80000632 error:nil];
        //        (NSStringEncoding) 0x80000632, // GB 18030 中国规定国标字符
        //        因为url中有中文字符，utf8解出来的字符串为nil，要用GB的方式解url
    }
    if (!content) {
        content = [NSString stringWithContentsOfURL:contentURL encoding:0x80000631 error:nil];
        //        (NSStringEncoding) 0x80000631, // GBK
    }
    if (!content) {
        return @"";
    }
    return content;
}






@end
