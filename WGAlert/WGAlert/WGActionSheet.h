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

@interface WGActionSheet : UIView

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
- (void)setCancelButttonWithTitle:(NSString *)title;
- (void)addButtonWithTitle:(NSString *)title;
- (void)setMaxVisibleButtonCount:(NSInteger)count;
- (void)show;
- (void)close;

@end
