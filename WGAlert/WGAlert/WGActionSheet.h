//
//  WGActionSheet.h
//  WGAlert
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGActionSheet;
@protocol WGActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(WGActionSheet *)actionSheet buttonDidClick:(NSInteger)index;

@end

@interface WGActionSheet : UIView <UIScrollViewDelegate>

// 标题
@property (nonatomic,  copy, readonly) NSString *title;

// 描述
@property (nonatomic,  copy, readonly) NSString *detail;

// 可以显示的button的最大数量
@property (nonatomic, assign, readonly) NSInteger maxCount;

// 按钮存放数组
@property (nonatomic, strong, readonly) NSMutableArray <UIButton *> *btnArray;

// 按钮点击代理
@property (nonatomic, weak) id <WGActionSheetDelegate> delegate;


- (instancetype)initWithTitle:(NSString *)title andDetail:(NSString *)detail;
- (void)setMaxVisibleButtonCount:(NSUInteger)count;

- (void)setTitleViewBackgroundColor:(UIColor *)color;
- (void)setTitleColor:(UIColor *)color;
- (void)setDetailColor:(UIColor *)color;

- (void)setCancelButttonWithTitle:(NSString *)title;
- (void)setCancelButtonBackGroundColor:(UIColor *)color;

- (void)addButtonWithTitle:(NSString *)title;
- (void)setButtonsTitleColor:(UIColor *)color;
- (void)setButtonsBackgroundColor:(UIColor *)color;
- (void)setButton:(NSUInteger)index titleColor:(UIColor *)color;
- (void)setButton:(NSUInteger)index backGroundColor:(UIColor *)color;

- (void)show;
- (void)close;


@end
