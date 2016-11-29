//
//  LZBTextView.h
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZBTextView : UITextView

/**
 * 设置占位文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  设置占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  占位文字的X偏移量
 */
@property (nonatomic, assign) CGFloat placeHolderOffsetX;

/**
 *  占位文字的Y偏移量
 */
@property (nonatomic, assign) CGFloat placeHolderOffsetY;

/**
 *  光标的偏移量
 */
@property (nonatomic, assign) UIOffset  cursorOffset;
@end
