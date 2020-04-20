//
//  QLReadConfig.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/20.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReadConfig.h"

@implementation QLReadConfig

+ (instancetype)shareInstance
{
    static QLReadConfig * readConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        readConfig = [[self alloc]init];
    });
    
    return readConfig;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"QLReadConfig"];
        if (data) {
            NSKeyedUnarchiver *unarchive = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
            QLReadConfig *config = [unarchive decodeObjectForKey:@"QLReadConfig"];
            [config addObserver:config forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"fontColor" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
            return config;
        }
        _lineSpace = 10.0f;
        _fontSize = 24.0f;
        _fontColor = [UIColor blackColor];
        _theme = [UIColor whiteColor];
        [self addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"fontColor" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
        [QLReadConfig updateLocalConfig:self];
        
    }
    return self;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [QLReadConfig updateLocalConfig:self];
}

+(void)updateLocalConfig:(QLReadConfig *)config
{
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:config forKey:@"QLReadConfig"];
    [archiver finishEncoding];
    NSUserDefaults * myUDef = [NSUserDefaults standardUserDefaults];
    [myUDef setObject:data forKey:@"QLReadConfig"];
    [myUDef synchronize];
}

+ (NSDictionary *)parseAttribute:(QLReadConfig *)config
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = config.fontColor;
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:config.fontSize];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.alignment = NSTextAlignmentJustified;//Justified两端对齐
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    return [dict copy];
}





// __strong 解决*chapters在block里面使用时候提前释放的问题
+ (void)separateChapter:(NSMutableArray * __strong *)chapters withContent:(NSString *)bookContent
{
    // charpters指向数组对象(*chapters)的指针地址，*chapters数组对象,**chapters数组内容
    [*chapters removeAllObjects];
    NSString * pattern = @"第[0-9一二三四五六七八九十百千]*[章回].*";
    // []表示在里面取一个匹配到的，[]*就是重复无数次直到匹配完，接着后面的[章回]匹配其中一个字符和后面的所有字符，即到下一章之前的所以字符。
    NSError* error = NULL;
    // 正则表达式，不区分大小写来检索章节
    NSRegularExpression * regChapter = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    // 得到匹配的类似一整个章节字段数组
    /** match数组打印结果
     NSRegularExpression * reg
    @ param <__NSArrayM 0x2809c6c40>(
     <NSSimpleRegularExpressionCheckingResult: 0x281206500>{2354, 6}{<NSRegularExpression: 0x2809e8d50> 第[0-9一二三四五六七八九十百千]*[章回].* 0x1},...)
     */
    // NSMatchingReportCompletion找到任何一个匹配串后都回调一次block
    NSArray * match = [regChapter matchesInString:bookContent options:NSMatchingReportCompletion range:NSMakeRange(0, [bookContent length])];
    if (match.count != 0)
    {
        __block NSRange lastRange = NSMakeRange(0, 0);
        
        
        
        [match enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 如 {location = 2354,length = 6}
            NSRange chapterObjRange = [obj range];
            NSInteger rangeLocal = chapterObjRange.location;
            
            if (idx == 0)
            {
                QLReaderChapterModel * ChapterModel = [[QLReaderChapterModel alloc]init];
                ChapterModel.title = @"开始";
                NSUInteger subLength = rangeLocal;
                //setContent方法自定义了，初始化并赋值了_pageArray。
                ChapterModel.content = [bookContent substringWithRange:NSMakeRange(0, subLength)];
                [*chapters addObject:ChapterModel];
            }
            if (idx > 0 )
            {
                QLReaderChapterModel * ChapterModel = [[QLReaderChapterModel alloc]init];
                ChapterModel.title = [bookContent substringWithRange:lastRange];
                NSUInteger subLength = rangeLocal - lastRange.location;
                ChapterModel.content = [bookContent substringWithRange:NSMakeRange(lastRange.location, subLength)];
                [*chapters addObject:ChapterModel];
            }
            if (idx == match.count-1)
            {
                QLReaderChapterModel * ChapterModel = [[QLReaderChapterModel alloc]init];
                ChapterModel.title = [bookContent substringWithRange:chapterObjRange];
                ChapterModel.content = [bookContent substringWithRange:NSMakeRange(rangeLocal, bookContent.length - rangeLocal)];
                [*chapters addObject:ChapterModel];
            }
            
            lastRange = chapterObjRange;
        }];
    }
    else
    {
        QLReaderChapterModel * chapterModel = [[QLReaderChapterModel alloc]init];
        chapterModel.content = bookContent;
        [*chapters addObject:chapterModel];
    }  
    
}




- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeDouble:self.fontSize forKey:@"fontSize"];
    [aCoder encodeDouble:self.lineSpace forKey:@"lineSpace"];
    [aCoder encodeObject:self.fontColor forKey:@"fontColor"];
    [aCoder encodeObject:self.theme forKey:@"theme"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.fontSize = [aDecoder decodeDoubleForKey:@"fontSize"];
        self.lineSpace = [aDecoder decodeDoubleForKey:@"lineSpace"];
        self.fontColor = [aDecoder decodeObjectForKey:@"fontColor"];
        self.theme = [aDecoder decodeObjectForKey:@"theme"];
    }
    return self;
}

@end
