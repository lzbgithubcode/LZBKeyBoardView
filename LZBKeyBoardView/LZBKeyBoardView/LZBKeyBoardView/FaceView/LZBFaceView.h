//
//  LZBFaceView.h
//  LZBKeyBoardView
//
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBEmojiModel.h"
@interface LZBFaceView : UIView

- (void)setEmojiModles:(NSArray <LZBEmojiModel *>*)emojiModles selectEmojiModelBlock:(void(^)(LZBEmojiModel*selectModel))selectBlock deleteBlcok:(void(^)())deleteBlcok sendBlcok:(void(^)())sendBlock;
@end
