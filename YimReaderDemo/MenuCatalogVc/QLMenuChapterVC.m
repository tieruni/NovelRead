//
//  QLMenuChapterVC.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/10.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "QLMenuChapterVC.h"
static  NSString *chapterCell = @"chapterCell";

@interface QLMenuChapterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *ChapterTableView;
@property (nonatomic) NSUInteger readChapter;
@end

@implementation QLMenuChapterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.ChapterTableView];
    [self addObserver:self forKeyPath:@"readModel.RBrecord.chapter" options:NSKeyValueObservingOptionNew context:NULL];
    
}
//KVO监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [_ChapterTableView reloadData];
}

#pragma mark - setter getter | init
-(UITableView *)ChapterTableView
{
    if (!_ChapterTableView) {
        _ChapterTableView = [[UITableView alloc] init];
        _ChapterTableView.delegate = self;
        _ChapterTableView.dataSource = self;
        _ChapterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _ChapterTableView;
}

#pragma mark - UITableView Delagete DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _readModel.chapters.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chapterCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chapterCell];
    }
    cell.textLabel.text = _readModel.chapters[indexPath.row].title;
    if (indexPath.row == _readModel.RBrecord.chapter) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.catalogDelegate respondsToSelector:@selector(catalogDidSelectChapter:page:)]) {
        [self.catalogDelegate catalogDidSelectChapter:indexPath.row page:0];
    }
}



-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"readModel.RBrecord.chapter"];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _ChapterTableView.frame = CGRectMake(0, 0, ViewFrameSize(self.view).width, ViewFrameSize(self.view).height);
}
@end
