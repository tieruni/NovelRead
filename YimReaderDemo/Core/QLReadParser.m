//
//  QLReadParser.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/12/2.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReadParser.h"

@implementation QLReadParser



+(CTFrameRef)parserContent:(NSString *)content config:(QLReadConfig *)parser bouds:(CGRect)bounds
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSDictionary *attribute = [self parserAttribute:parser];
    [attributedString setAttributes:attribute range:NSMakeRange(0, content.length)];
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(setterRef);
    CFRelease(pathRef);
    return frameRef;
    
}

+(NSDictionary *)parserAttribute:(QLReadConfig *)config
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = config.fontColor;
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:config.fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.alignment = NSTextAlignmentJustified;//Justified两端对齐
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    return [dict copy];
}


+(UIButton *)ReadButtonToTarget:(id)target action:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTintColor:[UIColor whiteColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+(UIViewController *)getCurrentVC
{
    UIViewController * result = nil;

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}



@end
