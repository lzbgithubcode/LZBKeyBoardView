//
//  UIViewController+LZBKeyBoardObserver.h
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LZBKeyBoardObserver)

/**
    设置键盘与第一响应者的默认间距 lzb_keyBoard_DefaultMargin = 0
 */
@property (nonatomic, assign) NSInteger lzb_keyBoard_DefaultMargin;

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
