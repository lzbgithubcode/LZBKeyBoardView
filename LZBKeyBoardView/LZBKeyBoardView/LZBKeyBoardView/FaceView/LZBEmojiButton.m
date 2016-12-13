//
//  LZBEmojiButton.m
//  LZBKeyBoardView
//
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBEmojiButton.h"
#import "NSString+LZBTranscoding.h"
#define LZBKeyboardBundleImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"Resource.bundle/",name]]
@implementation LZBEmojiButton
- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
     [self setupUI];
  }
    return self;
}

- (void)setupUI
{
   self.adjustsImageWhenHighlighted = NO;
   self.titleLabel.font = [UIFont systemFontOfSize:32];
}


- (void)setModel:(LZBEmojiModel *)model
{
    _model = model;
    if (model.png) { // 有图片
        [self setImage:LZBKeyboardBundleImage(model.png) forState:UIControlStateNormal];
    } else if (model.code) { // 是emoji表情
        // 设置emoji
        [self setTitle:model.code.emoji forState:UIControlStateNormal];
    }
}

@end
