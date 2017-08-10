//
//  NSString+LZBTranscoding.h
//  LZBKeyBoardView
//
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LZBTranscoding)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithByIntCode:(int)intCode;

/**
 *  将十六进制字符串编码转为emoji字符
 */
+ (NSString *)emojiWithByStringCode:(NSString *)stringCode;

/**
 *  字符串对象转为emoji字符
 */
- (NSString *)emoji;

/**
 *  字符串是否包含为emoji字符
 */
- (BOOL)isContainsEmoji;

@end
