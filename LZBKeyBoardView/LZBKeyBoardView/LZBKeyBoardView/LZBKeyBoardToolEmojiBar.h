//
//  LZBKeyBoardToolEmojiBar.h
//  LZBKeyBoardView
//
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZBKeyBoardToolEmojiBar : UIView
/**
 弹出自定义键盘和输入框工具条--无表情键盘  注意：一定是要在viewDidLayout中增加控件
 
 @param toolBarHeight 工具条的高度
 @param sendTextBlock 返回输入框输入的文字
 @return  返回LZBKeyBoardToolBar
 */
+ (LZBKeyBoardToolEmojiBar *)showKeyBoardWithConfigToolBarHeight:(CGFloat)toolBarHeight sendTextCompletion:(void(^)(NSString *sendText))sendTextBlock;

/**
 设置输入框占位文字
 
 @param placeText 占位文字
 */
- (void)setInputViewPlaceHolderText:(NSString *)placeText;


- (void)becomeFirstResponder;

- (void)resignFirstResponder;
@end
