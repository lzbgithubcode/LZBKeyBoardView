//
//  NSString+LZBTranscoding.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSString+LZBTranscoding.h"

#define EMOJI_CODE_TO_SYMBOL(x) (((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000))
@implementation NSString (LZBTranscoding)

+ (NSString *)emojiWithByIntCode:(int)intCode
{
    int sym = EMOJI_CODE_TO_SYMBOL(intCode);
    NSString *codeString = [[NSString alloc]initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
    if (codeString == nil) {
        codeString = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return codeString;
}

+ (NSString *)emojiWithByStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    long intCode = strtol(charCode, NULL, 16);
    return [self emojiWithByIntCode:(int)intCode];
}

/**
 *  转为emoji字符
 */
- (NSString *)emoji
{
    return [NSString emojiWithByStringCode:self];
}

- (BOOL)isContainsEmoji
{
    __block BOOL returnValue = NO;
    if(self.length == 0)  return returnValue;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                        const unichar hs = [substring characterAtIndex:0];
                        if (0xd800 <= hs && hs <= 0xdbff)
                        {
                            if (substring.length > 1)
                            {
                                const unichar ls = [substring characterAtIndex:1];
                                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                if (0x1d000 <= uc && uc <= 0x1f77f)
                                {
                                   returnValue = YES;
                                }
                            }
                        }
                        else if (substring.length > 1)
                        {
                          const unichar ls = [substring characterAtIndex:1];
                          if (ls == 0x20e3)
                          {
                            returnValue = YES;
                           }
                        }
                        else
                        {
                          if (0x2100 <= hs && hs <= 0x27ff)
                          {
                             returnValue = YES;
                          }
                          else if (0x2B05 <= hs && hs <= 0x2b07)
                          {
                             returnValue = YES;
                          }
                          else if (0x2934 <= hs && hs <= 0x2935)
                          {
                             returnValue = YES;
                          }
                          else if (0x3297 <= hs && hs <= 0x3299)
                          {
                            returnValue = YES;
                          }
                          else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
                          {
                            returnValue = YES;
                           }
                       }
            }];
    
         return returnValue;
}
@end
