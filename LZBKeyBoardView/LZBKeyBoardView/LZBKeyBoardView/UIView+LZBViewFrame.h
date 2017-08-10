
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git

#import <UIKit/UIKit.h>

@interface UIView (LZBViewFrame)

//只能生成get/Set方法声明
@property (nonatomic,assign) CGFloat LZB_width;

@property (nonatomic,assign) CGFloat LZB_heigth;

@property (nonatomic,assign) CGFloat LZB_x;

@property (nonatomic,assign) CGFloat LZB_y;


@property (nonatomic,assign) CGFloat LZB_centerX;

@property (nonatomic,assign) CGFloat LZB_centerY;

#pragma mark - API
- (BOOL)isDisplayedInScreen;

@end
