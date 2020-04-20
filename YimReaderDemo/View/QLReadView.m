//
//  QLReadView.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/9/19.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReadView.h"

#import "QLReadViewController.h"

@interface QLReadView ()
//@property (nonatomic,strong) LSYMagnifierView *magnifierView;
@end


@implementation QLReadView
{
//    NSRange _selectRange;
//    NSRange _calRange;
    NSArray *_pathArray;

    UIPanGestureRecognizer *_pan;
//    //滑动手势有效区间
//    CGRect _leftRect;
//    CGRect _rightRect;
//
//    CGRect _menuRect;
//    //是否进入选择状态
//    BOOL _selectState;
//    BOOL _direction; //滑动方向  (0---左侧滑动 1 ---右侧滑动)
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
//        [self addGestureRecognizer:({
//            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//            longPress;
//        })];
        
//        [self addGestureRecognizer:({
//            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//            pan.enabled = NO;
//            _pan = pan;
//            pan;
//        })];
        
        
        
    }
    return self;
}
// MARK:drawRect 调用是在Controller->loadView, Controller->viewDidLoad 两方法之后调用的，或者直接调用setNeedsDisplay（在pan和longPress手势中、取消选择方法里有直接调用这个方法）
- (void)drawRect:(CGRect)rect
{
    if (!_frameRef) {
        return;
    }
    [super drawRect:rect];
    //ReadView的自动执行的方法，应该是Draw文本到UIView中的方法
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGRect leftDot,rightDot = CGRectZero;
//    _menuRect = CGRectZero;
    // 步骤 3
//    [self drawSelectedPath:_pathArray LeftDot:&leftDot RightDot:&rightDot];
    CTFrameDraw(_frameRef, context);

//    [self drawDotWithLeft:leftDot right:rightDot];

}


#pragma mark - Privite Method

// Mark : Draw Selected Path 以下两个方法是控制长按后选择文本的事件（手势事件|选择框等）
//-(void)drawSelectedPath:(NSArray *)array LeftDot:(CGRect *)leftDot RightDot:(CGRect *)rightDot{
//    if (!array.count) {
//        _pan.enabled = NO;
//        if ([self.delegate respondsToSelector:@selector(readViewEndEdit:)]) {
//            [self.delegate readViewEndEdit:nil];
//        }
//        return;
//    }
//    if ([self.delegate respondsToSelector:@selector(readViewEditeding:)]) {
//        [self.delegate readViewEditeding:nil];
//    }
//    // 长按选择编辑文本后的填充。
//    _pan.enabled = YES;
//    CGMutablePathRef     _path = CGPathCreateMutable();
//    [[UIColor cyanColor]setFill];
//    for (int i = 0; i < [array count]; i++) {
//        CGRect rect = CGRectFromString([array objectAtIndex:i]);
//        CGPathAddRect(_path, NULL, rect);
//        if (i == 0) {
//            *leftDot = rect;
////            _menuRect = rect;
//        }
//        if (i == [array count]-1) {
//            *rightDot = rect;
//        }
//
//    }
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddPath(ctx, _path);
//    CGContextFillPath(ctx);
//    CGPathRelease(_path);
//
//}
//-(void)drawDotWithLeft:(CGRect)Left right:(CGRect)right
//{
//    if (CGRectEqualToRect(CGRectZero, Left) || (CGRectEqualToRect(CGRectZero, right))){
//        return;
//    }
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGMutablePathRef _path = CGPathCreateMutable();
//    [[UIColor orangeColor] setFill];
//    CGPathAddRect(_path, NULL, CGRectMake(CGRectGetMinX(Left)-2, CGRectGetMinY(Left),2, CGRectGetHeight(Left)));
//    CGPathAddRect(_path, NULL, CGRectMake(CGRectGetMaxX(right), CGRectGetMinY(right),2, CGRectGetHeight(right)));
//    CGContextAddPath(ctx, _path);
//    CGContextFillPath(ctx);
//    CGPathRelease(_path);
//    CGFloat dotSize = 15;
//    _leftRect = CGRectMake(CGRectGetMinX(Left)-dotSize/2-10, ViewSize(self).height-(CGRectGetMaxY(Left)-dotSize/2-10)-(dotSize+20), dotSize+20, dotSize+20);
//    _rightRect = CGRectMake(CGRectGetMaxX(right)-dotSize/2-10,ViewSize(self).height- (CGRectGetMinY(right)-dotSize/2-10)-(dotSize+20), dotSize+20, dotSize+20);
//    CGContextDrawImage(ctx,CGRectMake(CGRectGetMinX(Left)-dotSize/2, CGRectGetMaxY(Left)-dotSize/2, dotSize, dotSize),[UIImage imageNamed:@"r_drag-dot"].CGImage);
//    CGContextDrawImage(ctx,CGRectMake(CGRectGetMaxX(right)-dotSize/2, CGRectGetMinY(right)-dotSize/2, dotSize, dotSize),[UIImage imageNamed:@"r_drag-dot"].CGImage);
//}

@end
