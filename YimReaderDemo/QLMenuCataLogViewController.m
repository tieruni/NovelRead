//
//  QLMenuCataLogViewController.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/10.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "QLMenuCataLogViewController.h"
#import "QLMenuChapterVC.h"

@interface QLMenuCataLogViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,QLMenuChapterVCDelegate>
{
    NSInteger pendingVCIndex;   //将要显示的View Controller 索引
    NSInteger numberOfViewController;   //VC的总数量
    NSArray *arrayOfViewController;     //存放VC的数组
    NSArray *arrayOfViewControllerButton;    //存放VC Button的数组
    UIView *headerView;     //头部视图
    QLCatalogPagerTitleButton *oldButton;

    CGRect oldRect;   //用来保存title布局的Rect
}

@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,strong) UIScrollView *titleBackground;


@property (nonatomic,copy) NSArray *VCArray;
@property (nonatomic,copy) NSArray *titleArray;

@property (nonatomic) BOOL forbidGesture;

@property (nonatomic,strong) QLMenuChapterVC *chapterVC;

@end

@implementation QLMenuCataLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.titleBackground];
    
    
    _titleArray = @[@"目录"];

    _VCArray = @[({
        _chapterVC = [[QLMenuChapterVC alloc]init];
        _chapterVC.readModel = _readModel;
        _chapterVC.catalogDelegate = self;
        _chapterVC;
    }),
//                 ({
//        LSYMarkVC *markVC =[[LSYMarkVC alloc] init];
//        markVC.readModel = _readModel;
//        markVC.delegate = self;
//        markVC;
//    })
#import "QLMenuChapterVC.h"
 ];
    self.forbidGesture = YES;
//    self.delegate = self;
//    self.dataSource = self;
    [self reload];

}




-(void)viewDidLayoutSubviews
{
    headerView.frame = CGRectMake(0, self.topLayoutGuide.length, self.view.frame.size.width,0);
    _titleBackground.frame = CGRectMake(0, (headerView.frame.size.height)?headerView.frame.origin.y+headerView.frame.size.height:self.topLayoutGuide.length, self.view.frame.size.width,40.0);
    if (arrayOfViewControllerButton.count) {

        _titleBackground.contentSize = CGSizeMake(((UIButton *)arrayOfViewControllerButton.lastObject).frame.size.width+((UIButton *)arrayOfViewControllerButton.lastObject).frame.origin.x, _titleBackground.frame.size.height);
    }
    _pageViewController.view.frame = CGRectMake(0, _titleBackground.frame.origin.y+_titleBackground.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(_titleBackground.frame.origin.y+_titleBackground.frame.size.height));
}

#pragma mark - private Method

// 自己写的方法，不是系统自带的方法重写。
-(void)reload
{
    oldRect = CGRectZero;
    numberOfViewController = _titleArray.count;
    
    NSMutableArray *mutableArrayOfVC = [NSMutableArray array];
    NSMutableArray *mutableArrayOfBtn = [NSMutableArray array];
    
    for (int i = 0; i<numberOfViewController; i++)
    {
        [mutableArrayOfVC addObject:_VCArray[i]];
        
        NSString *buttonTitle = _titleArray[i];
        if (arrayOfViewControllerButton.count > i) {
            [[arrayOfViewControllerButton objectAtIndex:i] removeFromSuperview];
        }
        
        UIButton *button = [[QLCatalogPagerTitleButton alloc] init];
        [button addTarget:self action:@selector(p_titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0, [self p_fontText:buttonTitle withFontHeight:20], 40.0);
        oldRect = button.frame;
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [mutableArrayOfBtn addObject:button];
        [_titleBackground addSubview:button];
        if (i == 0) {
            oldButton = [mutableArrayOfBtn objectAtIndex:0];
            oldButton.selected = YES;
        }
        
    }
    
    if (mutableArrayOfBtn.count && ((UIButton *)mutableArrayOfBtn.lastObject).frame.origin.x + ((UIButton *)mutableArrayOfBtn.lastObject).frame.size.width<self.view.frame.size.width) //当所有按钮尺寸小于屏幕宽度的时候要重新布局
    {
        oldRect = CGRectZero;
        CGFloat padding = self.view.frame.size.width-(((UIButton *)mutableArrayOfBtn.lastObject).frame.origin.x + ((UIButton *)mutableArrayOfBtn.lastObject).frame.size.width);
        for (QLCatalogPagerTitleButton *button in mutableArrayOfBtn) {
            button.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0,button.frame.size.width+padding/mutableArrayOfBtn.count, 40.0);
            oldRect = button.frame;
        }
    }
    
    arrayOfViewControllerButton = [mutableArrayOfBtn copy];
    arrayOfViewController = [mutableArrayOfVC copy];
    
    
    if (arrayOfViewController.count) {
        [_pageViewController setViewControllers:@[arrayOfViewController.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
    
}


// 计算字体宽度
-(CGFloat)p_fontText:(NSString *)text withFontHeight:(CGFloat)height
{
    CGFloat padding = 20;
    NSDictionary *fontAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize fontSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:fontAttribute context:nil].size;
    return fontSize.width+padding;
}


-(void)p_titleButtonClick:(QLCatalogPagerTitleButton *)sender
{
    oldButton.selected = NO;
    sender.selected = YES;
    oldButton = sender;
    NSInteger index = [arrayOfViewControllerButton indexOfObject:sender];
    [_pageViewController setViewControllers:@[arrayOfViewController[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}



#pragma mark - setter getter | init

-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
    }
    return _pageViewController;
}

-(UIScrollView *)titleBackground
{
    if (!_titleBackground) {
        _titleBackground = [[UIScrollView alloc] init];
        _titleBackground.showsHorizontalScrollIndicator = NO;
        _titleBackground.showsVerticalScrollIndicator = NO;
    }
    return _titleBackground;
}

-(void)setForbidGesture:(BOOL)forbidGesture
{
    _forbidGesture = forbidGesture;
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            
            view.scrollEnabled = !forbidGesture;
        }
    }
    
}


#pragma mark - UIPageViewControllerDelegate & UIPageViewControllerDataSource
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        if (pendingVCIndex != [arrayOfViewController indexOfObject:previousViewControllers[0]]) {
//            [self p_titleSelectIndex:pendingVCIndex];
//            if ([self.delegate respondsToSelector:@selector(viewPagerViewController:didFinishScrollWithCurrentViewController:)]) {
//                [self.delegate viewPagerViewController:self didFinishScrollWithCurrentViewController:[arrayOfViewController objectAtIndex:pendingVCIndex]];
//            }
        }
        
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    pendingVCIndex = [arrayOfViewController indexOfObject:pendingViewControllers[0]];
//    if ([self.delegate respondsToSelector:@selector(viewPagerViewController:willScrollerWithCurrentViewController:)]) {
//        [self.delegate viewPagerViewController:self willScrollerWithCurrentViewController:pageViewController.viewControllers[0]];
//    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [arrayOfViewController indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    else{
        return arrayOfViewController[--index];
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [arrayOfViewController indexOfObject:viewController];
    if (index == arrayOfViewController.count-1) {
        return nil;
    }
    else{
        
        return arrayOfViewController[++index];
    }
}

#pragma mark - QLMenuChapterVCDelegate Delegate
- (void)catalogDidSelectChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    if ([self.catalogDelegate respondsToSelector:@selector(catalogDidSelectChapter:page:)]) {
        [self.catalogDelegate catalogDidSelectChapter:chapter page:page];
    }
}



@end




@implementation QLCatalogPagerTitleButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    if (self.selected) {
        CGFloat lineWidth = 2.5;
        CGColorRef color = self.titleLabel.textColor.CGColor;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, color);
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextMoveToPoint(ctx, 0, self.frame.size.height-lineWidth);
        CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height-lineWidth);
        CGContextStrokePath(ctx);
    }
}
@end
