//
//  QLReadPageViewController.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/10/12.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "QLReadPageViewController.h"
#import "QLReadViewController.h"
#import "QLtapMenuView.h"
#import "UIImage+ImageEffects.h"
#import "QLMenuCataLogViewController.h"
#import "MenuCatalogVc/QLMenuChapterVC.h"
@interface QLReadPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,QLMenuDelegate,UIGestureRecognizerDelegate,QLMenuChapterVCDelegate>
{
    NSUInteger _chapter;    //当前显示的章节
    NSUInteger _page;       //当前显示的页数
    NSUInteger _chapterChange;  //将要变化的章节
    NSUInteger _pageChange;     //将要变化的页数
    BOOL _isTransition;     //是否开始翻页
}


@property (nonatomic,strong) UIPageViewController * pageViewController;
@property (nonatomic,strong) QLReadViewController * readView;   //当前阅读视图
@property (nonatomic,strong) QLtapMenuView * tapMenuView;
//菜单栏
@property (nonatomic,strong) UIView * catalogView;  //侧边栏背景
@property (nonatomic,strong) QLMenuCataLogViewController *menuCatalogVC;   //侧边栏



@end

@implementation QLReadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化(UIPageViewController)pageViewController
    [self addChildViewController:self.pageViewController];
    // 通过提供的set方法将(UIViewController)LSYReadViewController(展示文本的控制器)装入pageViewController中
    NSArray * pageViewArr = [NSArray arrayWithObjects:[self readViewWithChapter:_RBmodel.RBrecord.chapter page:_RBmodel.RBrecord.page], nil];
    [_pageViewController setViewControllers:pageViewArr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
   
    _chapter = _RBmodel.RBrecord.chapter;
    _page = _RBmodel.RBrecord.page;
    
    // 添加屏幕点击手势，展示工具菜单
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
        tap.delegate = self;
        tap;
    })];
    
    [self.view addSubview:self.tapMenuView];
    // 屏幕快照截图背景
    [self.view addSubview:self.catalogView];

    [self addChildViewController:self.menuCatalogVC];
    [self.catalogView addSubview:self.menuCatalogVC.view];
    
    
    // Do any additional setup after loading the view.
}



#pragma  mark - setter getter | init

-(QLtapMenuView *)tapMenuView
{
    if (!_tapMenuView) {
        _tapMenuView = [[QLtapMenuView alloc] initWithFrame:self.view.frame];
        _tapMenuView.hidden = YES;
        _tapMenuView.delegate = self;
        _tapMenuView.recordModel = _RBmodel.RBrecord;
    }
    return _tapMenuView;
}



-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        //滚动，垂直的UIPageViewController
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}

-(UIView *)catalogView
{
    if (!_catalogView) {
        _catalogView = [[UIView alloc] initWithFrame:CGRectMake(-ViewFrameSize(self.view).width, 0, ViewFrameSize(self.view).width * 2, ViewFrameSize(self.view).height)];
        _catalogView.backgroundColor = [UIColor clearColor];
        _catalogView.hidden = YES;
        [_catalogView addGestureRecognizer:({
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCatalog)];
            tap.delegate = self;
            tap;
        })];
    }
    return _catalogView;
}


- (QLMenuCataLogViewController *)menuCatalogVC
{
    if (!_menuCatalogVC) {
        _menuCatalogVC = [[QLMenuCataLogViewController alloc] init];
        _menuCatalogVC.readModel = _RBmodel;
        _menuCatalogVC.catalogDelegate = self;
    }
    return _menuCatalogVC;
}



#pragma  mark - private Method

-(void)showToolMenu
{
//    [_readView.readView cancelSelected];
//    NSString * key = [NSString stringWithFormat:@"%d_%d",(int)_model.record.chapter,(int)_model.record.page];
    
//    id state = _model.marksRecord[key];
//    state?(_tapMenuView.topView.state=1): (_tapMenuView.topView.state=0);
    [self.tapMenuView showAnimation:YES];
}

-(void)catalogShowState:(BOOL)show
{
    show?({
        _catalogView.hidden = !show;
        [UIView animateWithDuration:AnimationDelay animations:^{
            _catalogView.frame = CGRectMake(0, 0,2*ViewFrameSize(self.view).width, ViewFrameSize(self.view).height);
            
        } completion:^(BOOL finished) {
            // 加一个截屏（已自定义模糊化效果）的UIView
            [_catalogView insertSubview:[[UIImageView alloc] initWithImage:[self EffectBlurredSnapshot]] atIndex:0];
        }];
    }):({
        if ([_catalogView.subviews.firstObject isKindOfClass:[UIImageView class]]) {
            [_catalogView.subviews.firstObject removeFromSuperview];
        }
        [UIView animateWithDuration:AnimationDelay animations:^{
            _catalogView.frame = CGRectMake(-ViewFrameSize(self.view).width, 0, 2*ViewFrameSize(self.view).width, ViewFrameSize(self.view).height);
        } completion:^(BOOL finished) {
            _catalogView.hidden = !show;
            
        }];
    });
}

- (UIImage *)EffectBlurredSnapshot {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)), NO, 1.0f);
    // 渲染一个完整的当前图层快照  （截屏作用）
    [self.view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIImage *blurredSnapshotImage = [snapshotImage applyLightEffect];
    UIGraphicsEndImageContext();
    return blurredSnapshotImage;
}


-(void)hiddenCatalog
{
    [self catalogShowState:NO];
}



#pragma mark - Create Read View Controller

-(QLReadViewController *)readViewWithChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    // FIXME:重新分章，读取数据，做完翻页后打开
    if (_RBmodel.RBrecord.chapter != chapter) {
        [_RBmodel.RBrecord.chapterModel updateChapterText];
    }
    
    _readView = [[QLReadViewController alloc]init];
    _readView.recordModel = _RBmodel.RBrecord;
    // 获取阅读界面一页能承载的内容字符串（用于展示），page是阅读记录record中的值
    _readView.content = [_RBmodel.chapters[chapter] stringOfPage:page];
    // MARK:_readView = QLReadViewController
//    _readView.delegate = self;
    NSLog(@"_readGreate");
    
    return _readView;
}

#pragma mark - Read View Controller Delegate
//长按选择文本的代理方法
//-(void)readViewEndEdit:(QLReadViewController *)readView
//{
//    for (UIGestureRecognizer *ges in self.pageViewController.view.gestureRecognizers) {
//        if ([ges isKindOfClass:[UIPanGestureRecognizer class]]) {
//            ges.enabled = YES;
//            break;
//        }
//    }
//}
//
//-(void)readViewEditeding:(QLReadViewController *)readView
//{
//    for (UIGestureRecognizer *ges in self.pageViewController.view.gestureRecognizers) {
//        if ([ges isKindOfClass:[UIPanGestureRecognizer class]]) {
//            ges.enabled = NO;
//            break;
//        }
//    }
//}

// MARK：应该在 ViewDidLoad之后执行
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _pageViewController.view.frame = self.view.frame;
    //    _catalogView.frame = CGRectMake(-ViewFrameSize(self.view).width, 0, 2*ViewFrameSize(self.view).width, ViewFrameSize(self.view).height);
    _menuCatalogVC.view.frame = CGRectMake(0, 0, ViewFrameSize(self.view).width-130, ViewFrameSize(self.view).height);
    [_menuCatalogVC reload];
}


#pragma MARK - UIPageViewControllerDataSource

//向前翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    _pageChange = _page;
    _chapterChange = _chapter;
    
    if (_chapterChange == 0 && _pageChange == 0)
    {
        return nil;
    }
    if (_pageChange == 0)
    {
        _chapterChange--;
        _pageChange = _RBmodel.chapters[_chapterChange].pageCount-1;
    }
    else
    {
        _pageChange--;
    }
    
    //再一次执行readViewWithChapter？返回一个ReadViewController
    return [self readViewWithChapter:_chapterChange page:_pageChange];
}


//向后翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    _pageChange = _page;
    _chapterChange = _chapter;
    if (_pageChange == _RBmodel.chapters.lastObject.pageCount - 1 && _chapterChange == _RBmodel.chapters.count - 1)
    {
        return nil;
    }
    if (_pageChange == _RBmodel.chapters[_chapterChange].pageCount - 1)
    {
        _chapterChange ++;
        _pageChange = 0;
    }
    else
    {
        _pageChange ++;
    }
    return [self readViewWithChapter:_chapterChange page:_pageChange];
}




-(void)updateReadModelWithChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    _chapter = chapter;
    _page = page;
    _RBmodel.RBrecord.chapterModel = _RBmodel.chapters[chapter];
    _RBmodel.RBrecord.chapter = chapter;
    _RBmodel.RBrecord.page = page;
    // 用来更新阅读进度记录record，下次打开时的位置。
    [QLReadBookModel updateLocalModel:_RBmodel url:_resourceURL];
}



#pragma mark -PageViewController Delegate
//在动画执行完毕后被调用，在controller切换完成后，我们可以在这个代理中进行一些后续操作，如，用UIPageViewController实现轮播分页等
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed)
    {
        QLReadViewController *readView = previousViewControllers.firstObject;
        _readView = readView;
        _page = readView.recordModel.page;
        _chapter = readView.recordModel.chapter;
    }
    else
    {
        [self updateReadModelWithChapter:_chapter page:_page];
    }
}




- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    _chapter = _chapterChange;
    _page = _pageChange;
}


#pragma mark - Menu View Delegate

- (void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    [_pageViewController setViewControllers:@[[self readViewWithChapter:chapter page:page]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self updateReadModelWithChapter:chapter page:page];
}


-(void)menuViewFontSize:(QLBottomMenuView *)bottomMenu
{
    
    [_RBmodel.RBrecord.chapterModel updateChapterText];
    // 重新加载pageViewController
    [_pageViewController setViewControllers:@[[self readViewWithChapter:_RBmodel.RBrecord.chapter page:(_RBmodel.RBrecord.page>_RBmodel.RBrecord.chapterModel.pageCount-1)?_RBmodel.RBrecord.chapterModel.pageCount-1:_RBmodel.RBrecord.page]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // 更新数据模型
    [self updateReadModelWithChapter:_RBmodel.RBrecord.chapter page:(_RBmodel.RBrecord.page>_RBmodel.RBrecord.chapterModel.pageCount-1)?_RBmodel.RBrecord.chapterModel.pageCount-1:_RBmodel.RBrecord.page];
}

-(void)menuViewInvokeCatalog:(QLBottomMenuView *)bottomMenu
{
    [_tapMenuView hiddenMenuView];
    [self catalogShowState:YES];
}

#pragma mark - QLMenuChapterVCDelegate Delegate

-(void)catalogDidSelectChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    [_pageViewController setViewControllers:@[[self readViewWithChapter:chapter page:page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self updateReadModelWithChapter:chapter page:page];
    [self hiddenCatalog];
    
}



#pragma mark -  UIGestureRecognizer Delegate
//解决ChapterTableView与Tap手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


@end
