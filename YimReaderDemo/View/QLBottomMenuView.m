//
//  QLBottomMenuView.m
//  YimReaderDemo
//
//  Created by Yimmm on 2020/3/5.
//  Copyright © 2020 Yimmm. All rights reserved.
//

#import "QLBottomMenuView.h"
#import "QLtapMenuView.h"

@interface QLBottomMenuView ()
//@property (nonatomic,strong) LSYReadProgressView *progressView;
@property (nonatomic,strong) LSYThemeView *themeView;
//@property (nonatomic,strong) UIButton *minSpacing;
//@property (nonatomic,strong) UIButton *mediuSpacing;
//@property (nonatomic,strong) UIButton *maxSpacing;
@property (nonatomic,strong) UIButton *catalog;
//@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UIButton *lastChapter;
@property (nonatomic,strong) UIButton *nextChapter;
@property (nonatomic,strong) UIButton *increaseFont;
@property (nonatomic,strong) UIButton *decreaseFont;
@property (nonatomic,strong) UILabel *fontLabel;
@end
//


@implementation QLBottomMenuView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    //    [self addSubview:self.slider];
    [self addSubview:self.lastChapter];
    [self addSubview:self.nextChapter];
    [self addSubview:self.increaseFont];
    [self addSubview:self.decreaseFont];
    [self addSubview:self.fontLabel];
    [self addSubview:self.catalog];
    //    [self addSubview:self.progressView];
    [self addSubview:self.themeView];
    [[QLReadConfig shareInstance] addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
    //    [self addObserver:self forKeyPath:@"readModel.chapter" options:NSKeyValueObservingOptionNew context:NULL];
    //    [self addObserver:self forKeyPath:@"readModel.page" options:NSKeyValueObservingOptionNew context:NULL];
}

#pragma mark - setter getter | init

-(UIButton *)lastChapter
{
    if (!_lastChapter) {
        _lastChapter = [QLReadParser ReadButtonToTarget:self action:@selector(jumpChapter:)];
        [_lastChapter setTitle:@"上一章" forState:UIControlStateNormal];
        //        _lastChapter.frame = CGRectMake(0, 5, ViewFrameSize(self).width /2, 30);
        _lastChapter.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _lastChapter.layer.borderWidth = 1;
        
        //        [_lastChapter setFrame:CGRectMake(0, 0, self.frame.size.width / 2, 15)];
    }
    return _lastChapter;
}

-(UIButton *)nextChapter
{
    if (!_nextChapter) {
        _nextChapter = [QLReadParser ReadButtonToTarget:self action:@selector(jumpChapter:)];
        [_nextChapter setTitle:@"下一章" forState:UIControlStateNormal];
        //        _nextChapter.frame = CGRectMake(DistanceFromLeftView(_lastChapter), 5, ViewFrameSize(self).width /2, 30);
        _nextChapter.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _nextChapter.layer.borderWidth = 1;
        
    }
    return _nextChapter;
}

-(UIButton *)increaseFont
{
    if (!_increaseFont) {
        _increaseFont = [QLReadParser ReadButtonToTarget:self action:@selector(changeFont:)];
        [_increaseFont setTitle:@"A+" forState:UIControlStateNormal];
        [_increaseFont.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _increaseFont.layer.borderWidth = 1;
        _increaseFont.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    return _increaseFont;
}

-(UILabel *)fontLabel
{
    if (!_fontLabel) {
        _fontLabel = [[UILabel alloc] init];
        _fontLabel.font = [UIFont systemFontOfSize:16];
        _fontLabel.textColor = [UIColor whiteColor];
        _fontLabel.textAlignment = NSTextAlignmentCenter;
        _fontLabel.text = [NSString stringWithFormat:@"%d",(int)[QLReadConfig shareInstance].fontSize];
    }
    return _fontLabel;
}


-(UIButton *)decreaseFont
{
    if (!_decreaseFont) {
        _decreaseFont = [QLReadParser ReadButtonToTarget:self action:@selector(changeFont:)];
        [_decreaseFont setTitle:@"A-" forState:UIControlStateNormal];
        [_decreaseFont.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _decreaseFont.layer.borderWidth = 1;
        _decreaseFont.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    return _decreaseFont;
}

-(LSYThemeView *)themeView
{
    if (!_themeView) {
        _themeView = [[LSYThemeView alloc] init];
    }
    return _themeView;
}

-(UIButton *)catalog
{
    if (!_catalog) {
        _catalog = [QLReadParser ReadButtonToTarget:self action:@selector(showCatalog)];
        [_catalog setImage:[UIImage imageNamed:@"reader_cover"] forState:UIControlStateNormal];
    }
    return _catalog;
}


#pragma mark - private Method

-(void)jumpChapter:(UIButton *)sender
{
    if (sender == _nextChapter) {
        if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
            [self.delegate menuViewJumpChapter:(_recordModel.chapter == _recordModel.chapterCount-1)?_recordModel.chapter:_recordModel.chapter+1 page:0];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
            [self.delegate menuViewJumpChapter:_recordModel.chapter?_recordModel.chapter-1:0 page:0];
        }
    }
}

-(void)changeFont:(UIButton *)sender
{
    
    if (sender == _increaseFont) {
        
        if (floor([QLReadConfig shareInstance].fontSize) == floor(MaxFontSize)) {
            [_increaseFont setEnabled:NO];
            return;
        }
        [_decreaseFont setEnabled:YES];
        [QLReadConfig shareInstance].fontSize++;
    }
    else{
        if (floor([QLReadConfig shareInstance].fontSize) == floor(MinFontSize)){
            [_decreaseFont setEnabled:NO];
            return;
        }
        [_increaseFont setEnabled:YES];
        [QLReadConfig shareInstance].fontSize--;
    }
    
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:self];
    }
}

-(void)showCatalog
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:self];
    }
}

// KVO监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"readModel.chapter"] || [keyPath isEqualToString:@"readModel.page"]) {
        //        _slider.value = _readModel.page/((float)(_readModel.chapterModel.pageCount-1))*100;
        //        [_progressView title:_readModel.chapterModel.title progress:[NSString stringWithFormat:@"%.1f%%",_slider.value]];
    }
    else if ([keyPath isEqualToString:@"fontSize"]){
        _fontLabel.text = [NSString stringWithFormat:@"%d",(int)[QLReadConfig shareInstance].fontSize];
    }
    //    else{
    //        if (_slider.state == UIControlStateNormal) {
    //            _progressView.hidden = YES;
    //        }
    //        else if(_slider.state == UIControlStateHighlighted){
    //            _progressView.hidden = NO;
    //        }
    //    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    //    _slider.frame = CGRectMake(50, 20, ViewSize(self).width-100, 30);
    _lastChapter.frame = CGRectMake(3, 5, ViewFrameSize(self).width /2 - 7, 30);
    _nextChapter.frame = CGRectMake(DistanceFromLeftView(_lastChapter) + 3, 5, ViewFrameSize(self).width /2 - 7, 30);
    _decreaseFont.frame = CGRectMake(10, DistanceFromTopView(_lastChapter)+10, (ViewFrameSize(self).width-20)/3, 30);
    _fontLabel.frame = CGRectMake(DistanceFromLeftView(_decreaseFont), DistanceFromTopView(_nextChapter)+10, (ViewFrameSize(self).width-20)/3,  30);
    _increaseFont.frame = CGRectMake(DistanceFromLeftView(_fontLabel), DistanceFromTopView(_nextChapter)+10,  (ViewFrameSize(self).width-20)/3, 30);
    _themeView.frame = CGRectMake(0, DistanceFromTopView(_decreaseFont)+10, ViewFrameSize(self).width, 50);
    _catalog.frame = CGRectMake(10, DistanceFromTopView(_themeView) + 5, 50, 50);
    //    _progressView.frame = CGRectMake(60, -60, ViewSize(self).width-120, 50);
}

-(void)dealloc
{
    //    [_slider removeObserver:self forKeyPath:@"highlighted"];
    //    [self removeObserver:self forKeyPath:@"readModel.chapter"];
    //    [self removeObserver:self forKeyPath:@"readModel.page"];
    [[QLReadConfig shareInstance] removeObserver:self forKeyPath:@"fontSize"];
//    [[QLReadConfig shareInstance] removeObserver:[QLReadConfig shareInstance] forKeyPath:@"lineSpace"];
//    [[QLReadConfig shareInstance] removeObserver:[QLReadConfig shareInstance] forKeyPath:@"fontColor"];
//    [[QLReadConfig shareInstance] removeObserver:[QLReadConfig shareInstance] forKeyPath:@"theme"];

}

@end




@interface LSYThemeView ()
@property (nonatomic,strong) UIView *theme1;
@property (nonatomic,strong) UIView *theme2;
@property (nonatomic,strong) UIView *theme3;
@end

@implementation LSYThemeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.theme1];
    [self addSubview:self.theme2];
    [self addSubview:self.theme3];
}
-(UIView *)theme1
{
    if (!_theme1) {
        _theme1 = [[UIView alloc] init];
        _theme1.backgroundColor = [UIColor whiteColor];
        [_theme1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
    }
    return _theme1;
}
-(UIView *)theme2
{
    if (!_theme2) {
        _theme2 = [[UIView alloc] init];
        _theme2.backgroundColor = [UIColor lightGrayColor];
        [_theme2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
    }
    return _theme2;
}
-(UIView *)theme3
{
    if (!_theme3) {
        _theme3 = [[UIView alloc] init];
        _theme3.backgroundColor = RGB(190, 182, 162);
        [_theme3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
    }
    return _theme3;
}
-(void)changeTheme:(UITapGestureRecognizer *)tap
{
    // tap（轻触对象）.view（的视图）
    [[NSNotificationCenter defaultCenter] postNotificationName:QLBottomThemeNotification object:tap.view.backgroundColor];
}
-(void)layoutSubviews
{
    CGFloat spacing = (ViewFrameSize(self).width-50*3)/4;
    _theme1.frame = CGRectMake(spacing, 0, 50, 50);
    _theme2.frame = CGRectMake(DistanceFromLeftView(_theme1)+spacing, 0, 50, 50);
    _theme3.frame = CGRectMake(DistanceFromLeftView(_theme2)+spacing, 0, 50, 50);
}
@end
