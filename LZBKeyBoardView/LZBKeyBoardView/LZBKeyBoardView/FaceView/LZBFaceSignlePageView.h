//
//  LZBFaceSignlePageView.h
//  LZBKeyBoardView
//
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBEmojiModel.h"
//获取图片资源
#define LZBKeyboardBundleImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"Resource.bundle/",name]]
//表情最大的行数
#define LZBFaceSignlePageView_Emjoi_MaxRow 3
//表情最大的列数
#define LZBFaceSignlePageView_Emjoi_MaxCol 7
//单页最多的表情个数
#define LZBFaceSignlePageView_AllEmjoiCount ((LZBFaceSignlePageView_Emjoi_MaxRow * LZBFaceSignlePageView_Emjoi_MaxCol) - 1)


@interface LZBFaceSignlePageView : UIView

//data
@property (nonatomic, strong) NSArray <LZBEmojiModel *> *emojiSignlePageModles;  //表情赋值
@property (nonatomic, copy) void (^emojiDidDeleteBlock)();   //表情删除回调
@property (nonatomic, copy) void (^emojiDidSelectBlock)(LZBEmojiModel *emojiModel);   //选中某个表情回调

@end
