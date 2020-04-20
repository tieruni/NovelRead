//
//  QLReaderChapterModel.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/24.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReaderChapterModel.h"

@interface QLReaderChapterModel ()
@property (nonatomic,strong) NSMutableArray * pageArray;
@end


@implementation QLReaderChapterModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageArray = [NSMutableArray array];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.pageCount forKey:@"pageCount"];
    [aCoder encodeObject:self.pageArray forKey:@"pageArray"];
//    [aCoder encodeObject:self.epubImagePath forKey:@"epubImagePath"];
//    [aCoder encodeObject:@(self.type) forKey:@"type"];
//    [aCoder encodeObject:self.epubContent forKey:@"epubContent"];
//    [aCoder encodeObject:self.chapterpath forKey:@"chapterpath"];
//    [aCoder encodeObject:self.html forKey:@"html"];
//    [aCoder encodeObject:self.epubString forKey:@"epubString"];
    /**
     @property (nonatomic,copy) NSArray *epubframeRef;
     @property (nonatomic,copy) NSString *epubImagePath;
     @property (nonatomic,copy) NSArray <LSYImageData *> *imageArray;
     
     */
    //    [aCoder encodeObject:self.epubframeRef forKey:@"epubframeRef"];
    //    [aCoder encodeObject:self.epubImagePath forKey:@"epubImagePath"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _content = [aDecoder decodeObjectForKey:@"content"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.pageCount = [aDecoder decodeIntegerForKey:@"pageCount"];
        self.pageArray = [aDecoder decodeObjectForKey:@"pageArray"];
//        self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
//        self.epubImagePath = [aDecoder decodeObjectForKey:@"epubImagePath"];
//        self.epubContent = [aDecoder decodeObjectForKey:@"epubContent"];
//        self.chapterpath = [aDecoder decodeObjectForKey:@"chapterpath"];
//        self.html = [aDecoder decodeObjectForKey:@"html"];
//        self.epubString = [aDecoder decodeObjectForKey:@"epubString"];
        //        self.epubframeRef = [aDecoder decodeObjectForKey:@"epubframeRef"];
        
    }
    return self;
}


-(void)updateChapterText
{
    [self paginateWithUIScreenBounds:CGRectMake(LeftSpacing, TopSpacing, [UIScreen mainScreen].bounds.size.width-LeftSpacing-RightSpacing, [UIScreen mainScreen].bounds.size.height-TopSpacing-BottomSpacing)];
}


// 在屏幕上draw文本的范围，用来获得每一页可以draw在屏幕上的字数章节数组
- (void)paginateWithUIScreenBounds:(CGRect)bounds
{
    [_pageArray removeAllObjects];
    NSAttributedString *attrString;
    CTFramesetterRef frameSetter;
    CGPathRef path;
    NSMutableAttributedString *attrMutableStr;
    // 如果能分章，self.content只有一章的内容
    attrMutableStr = [[NSMutableAttributedString alloc] initWithString:self.content];
    // 初始化并Keychain和NSUserDefault保存文本样式（字体、颜色、行距、主题背景），添加对文本样式的KVO监听，初始化段落样式并赋值给NSDictionary
    NSDictionary *attribute = [QLReadConfig parseAttribute:[QLReadConfig shareInstance]];
    [attrMutableStr setAttributes:attribute range:NSMakeRange(0, attrMutableStr.length)];
    attrString = [attrMutableStr copy];
    frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    path = CGPathCreateWithRect(bounds, NULL);
    
    int currentOffset = 0;
    int currentInnerOffset = 0;
    BOOL hasMorePages = YES;
    // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
    int preventDeadLoopSign = currentOffset;
    int samePlaceRepeatCount = 0;
    
    while (hasMorePages)
    {
        if (preventDeadLoopSign == currentOffset)
        {
            ++samePlaceRepeatCount;
        }
        else
        {
            samePlaceRepeatCount = 0;
        }
        if (samePlaceRepeatCount > 1)
        {
            // MARK:从来没走过这里面
            // 退出循环前检查一下最后一页是否已经加上
            if (_pageArray.count == 0)
            {
                [_pageArray addObject:@(currentOffset)];
            }
            else
            {
                NSUInteger lastOffset = [[_pageArray lastObject] integerValue];
                if (lastOffset != currentOffset)
                {
                    [_pageArray addObject:@(currentOffset)];
                }
            }
            break;
        }
        
        [_pageArray addObject:@(currentOffset)];//@()可以用来将一些非对象的数据包装成OC里面的对象，(int)currentOffset会被包装成NSNumber对象存到_pageArrayj可变数组里
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, NULL);
        CFRange range = CTFrameGetVisibleStringRange(frame);
        //页面能展示的字数range.location + range.length不等于一章节的总字数attrString.length
        if ((range.location + range.length) != attrString.length)
        {
            currentOffset += range.length;
            currentInnerOffset += range.length;
        }
        else
        {
            // 已经分完，提示跳出循环
            hasMorePages = NO;
        }
        if (frame) CFRelease(frame);
    }
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    _pageCount = _pageArray.count;
}


-(NSString *)stringOfPage:(NSUInteger)index
{
    // 阅读记录第0章，就取章节目录可变数组第0个元素
    NSUInteger local = [_pageArray[index] integerValue];
    NSUInteger length;
    if (index<self.pageCount-1)
    {
        length = [_pageArray[index+1] integerValue] - [_pageArray[index] integerValue];
    }
    else
    {
        length = _content.length - [_pageArray[index] integerValue];
    }
    return [_content substringWithRange:NSMakeRange(local, length)];
}



#pragma mark - 自定义Set方法
- (void)setContent:(NSString *)content
{
    //传过来的content是一章的内容
    _content = content;
    [self paginateWithUIScreenBounds:CGRectMake(LeftSpacing, TopSpacing, [UIScreen mainScreen].bounds.size.width-LeftSpacing-RightSpacing, [UIScreen mainScreen].bounds.size.height-TopSpacing-BottomSpacing)];
    
}

@end
