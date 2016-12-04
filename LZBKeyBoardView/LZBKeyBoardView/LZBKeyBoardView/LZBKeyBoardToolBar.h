//
//  LZBKeyBoardToolBar.h
//  LZBKeyBoardView
//
//  Created by zibin on 16/12/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZBKeyBoardToolBar : UIView


/**
 弹出自定义键盘和输入框工具条--无表情键盘

 @param toolBarHeight 工具条的高度
 @param sendTextBlock 返回输入框输入的文字
 @return  返回LZBKeyBoardToolBar
 */
+ (LZBKeyBoardToolBar *)showKeyBoardWithConfigToolBarHeight:(CGFloat)toolBarHeight sendTextCompletion:(void(^)(NSString *sendText))sendTextBlock;


/**
 设置输入框占位文字

 @param placeText 占位文字
 */
- (void)setInputViewPlaceHolderText:(NSString *)placeText;


- (void)becomeFirstResponder;

- (void)resignFirstResponder;
@end
