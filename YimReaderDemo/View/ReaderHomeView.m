//
//  ReaderHomeView.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/11.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "ReaderHomeView.h"
#import "QLReadPageViewController.h"

@interface ReaderHomeView()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * bookCollectionView;
// 存放书籍全路径
@property (nonatomic, strong) NSArray * bookArray;

@end

@implementation ReaderHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBookView];
        _bookArray = [[NSBundle mainBundle]pathsForResourcesOfType:@"txt" inDirectory:nil];

    }
    return self;
}

- (void)setBookView
{
    [self addSubview:self.bookCollectionView];
    // 通知恢复页面使用
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ViewUseEnable) name:dismissVCNoti object:nil];
}

#pragma mark - private Method
- (void)ViewUseEnable
{
    self.userInteractionEnabled = YES;
}

#pragma mark - setter getter | init

- (UICollectionView *)bookCollectionView{
    
    if (_bookCollectionView == nil) {
        // 创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 垂直方向滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 创建collectionView
        CGRect frame = CGRectMake(0, 0, ViewFrameSize(self).width, ViewFrameSize(self).height);
        _bookCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        // 设置代理
        _bookCollectionView.delegate = self;
        _bookCollectionView.dataSource = self;
        // 其他属性
        _bookCollectionView.backgroundColor = [UIColor clearColor];
        // 隐藏垂直方向滚动条
        _bookCollectionView.showsVerticalScrollIndicator = NO;
        // 注册cell
        [_bookCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"BookCell"];
        // 注册Header
        [_bookCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader"];
        // 注册Footer
        [_bookCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyFooter"];
        _bookCollectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HomePage.jpg"]];
        
        
    }
    
    return _bookCollectionView;
}





#pragma mark - UICollectionViewDelegateFlowLayout

// 返回Header的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(0, 0);
}


// 返回cell的尺寸大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 让每个cell尺寸都不一样
    return CGSizeMake((ViewFrameSize(self).width - 4 * 10 - 40)/3, (ViewFrameSize(self).height - 4 * 20 - 40)/4);
}


// 返回Footer的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(0, 0);
}


// 返回cell之间行间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}


// 返回cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
}


// 设置上左下右边界缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


#pragma mark - UICollectionViewDataSource

// 返回Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([_bookArray count] % 3 == 0)
    {
        return [_bookArray count]/3;
    }
    return [_bookArray count]/3 + 1;
}


// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section != [_bookArray count]/3 - 1)
    {
        return 3;
    }
    
    return [_bookArray count] - section * 3;
}


// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell (重用)
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    [label setNumberOfLines:2];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = RGB(41, 36, 33);
//    label.text = @"书";
    [cell addSubview:label];
    
    // 设置cell内容
    long bookIndex = indexPath.section * 3 + indexPath.row;
    label.text = [[[_bookArray objectAtIndex:bookIndex]lastPathComponent]stringByDeletingPathExtension];

//    for (int i = 0;i < [_bookArray count];i++)
//    {
//    }
//    NSString * bookJpg = [[[[_bookArray objectAtIndex:bookIndex]lastPathComponent]stringByDeletingPathExtension]stringByAppendingString:@".jpg"];
//    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bookJpg]];
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BookCover.jpg"]];

    
    
    cell.layer.cornerRadius = 5.f;
    cell.layer.masksToBounds = YES;
    
    
    
    
    
    
    return cell;
}


// 返回Header/Footer内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //
    //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {          // Header视图
    //        // 从复用队列中获取HooterView
    //        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
    //        // 设置HooterView
    //        headerView.backgroundColor = [UIColor redColor];
    //        UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    //        label.textAlignment = NSTextAlignmentCenter;
    //        label.text = @"我是Header";
    //        label.textColor = [UIColor whiteColor];
    //        [headerView addSubview:label];
    //        // 返回HooterView
    //        return headerView;
    //
    //    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {    // Footer视图
    //        // 从复用队列中获取FooterView
    //        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyFooter" forIndexPath:indexPath];
    //        // 设置FooterView
    //        footerView.backgroundColor = [UIColor blueColor];
    //        UILabel *label = [[UILabel alloc] initWithFrame:footerView.bounds];
    //        label.textAlignment = NSTextAlignmentCenter;
    //        label.text = @"我是Footer";
    //        label.textColor = [UIColor whiteColor];
    //        [footerView addSubview:label];
    //        // 返回FooterView
    //        return footerView;
    //    }
    //
    return nil;
}


#pragma mark - UICollectionViewDelegate

// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中cell: %ld", indexPath.row);
    
    // 设置cell
    
    // 设置页面不可用，无法点击
    self.userInteractionEnabled = NO;
    // 加载书籍
    long bookIndex = indexPath.section * 3 + indexPath.row;
    NSURL * MyTxtUrl = [[NSBundle mainBundle] URLForResource:[[[_bookArray objectAtIndex:bookIndex]lastPathComponent]stringByDeletingPathExtension] withExtension:@"txt"];
    QLReadPageViewController * pageView = [[QLReadPageViewController alloc] init];
    //先设置LSYReadPageViewController属性
    pageView.resourceURL = MyTxtUrl;    //文件位置
    
    pageView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        pageView.RBmodel = [QLReadBookModel getReadBookModelWithLocalURL:MyTxtUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[QLReadParser getCurrentVC] presentViewController:pageView animated:YES completion:nil];
        });
    });
    
    
}




- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
