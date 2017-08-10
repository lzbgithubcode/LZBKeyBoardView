//
//  LZBFaceSignlePageView.m
//  LZBKeyBoardView
//
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//



#import "LZBFaceSignlePageView.h"
#import "LZBEmojiButton.h"

#define LZBFaceSignlePageView_Default_LeftRightInset 15  //左右间距
#define LZBFaceSignlePageView_Default_TopBottomInset 10   //上下间距

@interface LZBFaceSignlePageView()

@property (nonatomic, strong) UIButton *deleteButton;  /** 删除按钮 */

@end

@implementation LZBFaceSignlePageView
- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
      [self addSubview:self.deleteButton];
  }
    return self;
}

- (void)setEmojiSignlePageModles:(NSArray<LZBEmojiModel *> *)emojiSignlePageModles
{
    _emojiSignlePageModles = emojiSignlePageModles;
    NSInteger count = emojiSignlePageModles.count;
    for (NSInteger i = 0; i < count; i++)
    {
        LZBEmojiButton *emojiButton = [[LZBEmojiButton alloc]init];
        [self addSubview:emojiButton];
        emojiButton.model = emojiSignlePageModles[i];
        [emojiButton addTarget:self action:@selector(emojiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.emojiSignlePageModles.count;
    CGFloat emojiButtonW = (self.bounds.size.width - 2 *LZBFaceSignlePageView_Default_LeftRightInset)/LZBFaceSignlePageView_Emjoi_MaxCol;
    CGFloat emojiButtonH = (self.bounds.size.height - 2 *LZBFaceSignlePageView_Default_TopBottomInset)/LZBFaceSignlePageView_Emjoi_MaxRow;
    for (NSInteger i = 0; i < count; i++)
    {
        CGFloat emojiButtonX = LZBFaceSignlePageView_Default_LeftRightInset + (i%LZBFaceSignlePageView_Emjoi_MaxCol)*emojiButtonW;
        CGFloat emojiButtonY = LZBFaceSignlePageView_Default_TopBottomInset + (i/LZBFaceSignlePageView_Emjoi_MaxCol)*emojiButtonH;
        LZBEmojiButton *emojiButton = self.subviews[i + 1];  //第0个是删除按钮
        emojiButton.frame = CGRectMake(emojiButtonX, emojiButtonY, emojiButtonW, emojiButtonH);
    }
    LZBEmojiButton *lastEmojiButton = [self.subviews lastObject];
    //布局删除按钮
    CGFloat deleteButtonX = lastEmojiButton.frame.origin.x + lastEmojiButton.bounds.size.width;
    CGFloat deleteButtonY = lastEmojiButton.frame.origin.y;
    CGFloat deleteButtonW = emojiButtonW;
    CGFloat deleteButtonH = emojiButtonH;
    self.deleteButton.frame = CGRectMake(deleteButtonX, deleteButtonY, deleteButtonW, deleteButtonH);
    
    
}

#pragma mark - handle
- (void)deleteClick
{
  if(self.emojiDidDeleteBlock)
      self.emojiDidDeleteBlock();
}

- (void)emojiButtonClick:(LZBEmojiButton *)emojiButton
{
   if(self.emojiDidSelectBlock)
       self.emojiDidSelectBlock(emojiButton.model);
}

#pragma mark - lazy 
- (UIButton *)deleteButton{
    if (_deleteButton == nil)
    {
       _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
       [_deleteButton setImage:LZBKeyboardBundleImage(@"compose_emotion_delete")forState:UIControlStateNormal];
       [_deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
@end
