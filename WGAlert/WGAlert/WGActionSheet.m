//
//  WGActionSheet.m
//  WGAlert
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "WGActionSheet.h"

#define greenColor         [UIColor colorWithRed:(CGFloat)52/255 green:(CGFloat)170/255 blue:(CGFloat)135/255 alpha:1]
#define brownColor         [UIColor brownColor]
#define layerColor         [UIColor grayColor]
#define buttonTextColor    [UIColor whiteColor]
#define titleTextColor     [UIColor whiteColor]
#define buttonHeight       39.0
#define widthFactor        0.9

@implementation WGActionSheet
{
    CGFloat width;
    CGFloat height;
    
    // superView: self
    UIView *_bgView;
    UIView *_bottomView;
    
    // superView: _bottomView
    UIView *_titleView;
    UIScrollView *_btnView;
    UIButton *_cancelBtn;
    
    // superView: _titleView
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    
    BOOL inAnimate;
}

- (instancetype)initWithTitle:(NSString *)title andDetail:(NSString *)detail
{
    self = [super init];
    if (self) {
        [self initVariable];
        _title = title;
        _detail = detail;
        [self setBGView];
        
        _bottomView = [[UIView alloc] init];
        [self addSubview:_bottomView];
        [self setTitleView];
        [self setCancelButton];
        [self setViewsFrame];
    }
    
    return self;
}

- (void)setTitleColor:(UIColor *)color
{
    if (color && _titleLabel) {
        _titleLabel.textColor = color;
    }
}

- (void)setDetailColor:(UIColor *)color
{
    if (color && _detailLabel) {
        _detailLabel.backgroundColor = color;
    }
}

- (void)setTitleViewBackgroundColor:(UIColor *)color
{
    if (color && _titleView) {
        _titleView.backgroundColor = color;
    }
}

- (void)setMaxVisibleButtonCount:(NSUInteger)count
{
    _maxCount = count > 0 ? count : _maxCount;
}

- (void)setCancelButttonWithTitle:(NSString *)title
{
    if (title) {
        [_cancelBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)setCancelButtonBackGroundColor:(UIColor *)color
{
    if (color) {
        _cancelBtn.backgroundColor = color;
    }
}

- (void)addButtonWithTitle:(NSString *)title
{
    if (title) {
        if (!_btnView) {
            _btnView = [[UIScrollView alloc] init];
            _btnView.delegate = self;
            _btnView.bounces = NO;
            [_bottomView addSubview:_btnView];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = greenColor;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:buttonTextColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = _btnArray.count;
        btn.frame = CGRectMake(0, _btnArray.count * (buttonHeight + 1), width * widthFactor, buttonHeight);
        [_btnArray addObject:btn];
        [_btnView addSubview:btn];
        _btnView.contentSize = CGSizeMake(width * widthFactor, _btnArray.count * (buttonHeight + 1) - 1);
    }
    
    [self setViewsFrame];
}

- (void)setButtonsTitleColor:(UIColor *)color
{
    if (color) {
        for (UIButton *btn in _btnArray) {
            [btn setTitleColor:color forState:UIControlStateNormal];
        }
    }
}

- (void)setButtonsBackgroundColor:(UIColor *)color
{
    if (color) {
        for (UIButton *btn in _btnArray) {
            [btn setBackgroundColor:color];
        }
    }
}

- (void)setButton:(NSUInteger)index titleColor:(UIColor *)color
{
    if (index < _btnArray.count && color) {
        UIButton *btn = _btnArray[index];
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}

- (void)setButton:(NSUInteger)index backGroundColor:(UIColor *)color
{
    if (index < _btnArray.count && color) {
        UIButton *btn = _btnArray[index];
        [btn setBackgroundColor:color];
    }
}

- (void)show
{
    CGRect originRect = _bottomView.frame;
    CGRect rect = originRect;
    rect.origin.y = height;
    _bottomView.frame = rect;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame = originRect;
        _bgView.alpha = 0.2;
    }];
}

- (void)close
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = _bottomView.frame;
        rect.origin.y = height;
        _bottomView.frame = rect;
        _bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark Private Methods

- (void)initVariable
{
    CGRect rect = [UIScreen mainScreen].bounds;
    self.frame = rect;
    width = rect.size.width;
    height = rect.size.height;
    _delegate = nil;
    inAnimate = NO;
    _maxCount = 3;
    _btnArray = [NSMutableArray array];
}

- (void)setViewsFrame
{
    CGFloat bvH = _titleView ? _titleView.frame.size.height + 1.5 : 0;
    
    if (_btnView) {
        CGFloat btnViewH = MAX(0,  MIN(_btnArray.count, _maxCount) * (buttonHeight + 1) - 1);
        _btnView.frame = CGRectMake(0, bvH, width * widthFactor, btnViewH);
        bvH += btnViewH + 8;
    }
    
    _cancelBtn.frame = CGRectMake(0, bvH, width * widthFactor, buttonHeight);
    bvH += buttonHeight  + 8;
    _bottomView.frame = CGRectMake(width * (1 - widthFactor) / 2, height - bvH, width * widthFactor, bvH);
}

- (void)setTitleView
{
    if (_title && ![_title isEqualToString:@""]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = _title;
        _titleLabel.textColor = titleTextColor;
    }
    
    if (_detail && ![_detail isEqualToString:@""]) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.text = _detail;
        _detailLabel.textColor = titleTextColor;
    }
    
    if (_titleLabel || _detailLabel) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width * widthFactor, 51.5)];
        [self maskToBounds:_titleView cornerRect:UIRectCornerTopLeft | UIRectCornerTopRight];
        _titleView.backgroundColor = greenColor;
        [_bottomView addSubview:_titleView];
        
        if (_titleLabel && _detailLabel) {
            _titleLabel.frame = CGRectMake(0, 10, width * widthFactor, 17);
            _detailLabel.frame = CGRectMake(0, 28, width * widthFactor, 15);
            [_titleView addSubview:_titleLabel];
            [_titleView addSubview:_detailLabel];
        } else if (_titleLabel) {
            _titleLabel.frame = CGRectMake(0, 17, width * widthFactor, 17);
            [_titleView addSubview:_titleLabel];
        } else if (_detailLabel) {
            _detailLabel.frame = CGRectMake(0, 17, width * widthFactor, 15);
            [_titleView addSubview:_detailLabel];
        }
    }
}

- (void)setBGView
{
    _bgView = [[UIView alloc] initWithFrame:self.frame];
    _bgView.userInteractionEnabled = YES;
    _bgView.backgroundColor = [UIColor grayColor];
    _bgView.alpha = 0;
    [self addSubview:_bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_bgView addGestureRecognizer:tap];
}

- (void)setCancelButton
{
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.backgroundColor = brownColor;
    [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:buttonTextColor forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 5;
    [_bottomView addSubview:_cancelBtn];
    
    CGFloat btnY = _titleView ? _titleView.frame.size.height + 16 : 0;
    _cancelBtn.frame = CGRectMake(0, btnY, width * widthFactor, buttonHeight);
    _bottomView.frame = CGRectMake(0, height - (btnY + buttonHeight), width * widthFactor, btnY + buttonHeight);
}

- (void)onButtonClick:(UIButton *)button
{
    printf("%s\n",button.titleLabel.text.UTF8String);
    if ([_delegate respondsToSelector:@selector(actionSheet:buttonDidClick:)]) {
        [_delegate actionSheet:self buttonDidClick:button.tag];
    }
    
    [self close];
}

- (void)maskToBounds:(UIView *)view cornerRect:(UIRectCorner)corners
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    CGPoint offset = scrollView.contentOffset;
    CGFloat bWhole = offset.y / (buttonHeight + 1);
    if (bWhole != 0) {
        [scrollView setContentOffset:CGPointMake(offset.x, (buttonHeight + 1) * round(bWhole)) animated:YES];
    }
}


@end
