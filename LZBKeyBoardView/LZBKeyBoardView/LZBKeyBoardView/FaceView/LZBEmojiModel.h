//
//  LZBEmojiModel.h
//  LZBKeyBoardView
//
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZBEmojiModel : NSObject

/**
 *  表情的文字描述
 */
@property (nonatomic, strong)  NSString *desc;

/**
 *  表情的png图片名称
 */
@property (nonatomic, strong)  NSString *png;

/**
 *  emoji表情的16进制编码
 */
@property (nonatomic, strong)  NSString *code;

@end
