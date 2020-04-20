//
//  QLReadParser.h
//  YimReaderDemo
//
//  Created by Yimmm on 2019/12/2.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLReadConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface QLReadParser : NSObject

+(CTFrameRef)parserContent:(NSString *)content config:(QLReadConfig *)parser bouds:(CGRect)bounds;
+(UIButton *)ReadButtonToTarget:(id)target action:(SEL)sel;
+(UIViewController *)getCurrentVC;


@end

NS_ASSUME_NONNULL_END
