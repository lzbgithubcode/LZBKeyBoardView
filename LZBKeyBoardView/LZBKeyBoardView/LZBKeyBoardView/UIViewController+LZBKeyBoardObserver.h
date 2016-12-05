//
//  UIViewController+LZBKeyBoardObserver.h
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//
#pragma mark - 登录页面自动使用键盘高度
#import <UIKit/UIKit.h>
//设置键盘和第一响应者的间距
#define lzb_settingKeyBoard_DefaultMargin 10

@interface UIViewController (LZBKeyBoardObserver)

/**
    增加点击任意地方消除键盘
 */
- (void)lzb_addKeyBoardTapAnyAutoDismissKeyBoard;

/**
   增加键盘监听观察者
 */
- (void)lzb_addKeyBoardObserverAutoAdjustHeight;

/**
   移除键盘监听观察者，必须实现
 */
- (void)lzb_removeKeyBoardObserver;
@end
