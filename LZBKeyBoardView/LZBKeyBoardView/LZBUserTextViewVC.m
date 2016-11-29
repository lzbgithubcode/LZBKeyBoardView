//
//  LZBUserTextViewVC.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBUserTextViewVC.h"
#import "LZBTextView.h"
@interface LZBUserTextViewVC ()
@property (nonatomic, strong)  LZBTextView *textView;
@end

@implementation LZBUserTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //去除边沿延伸效果
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.textView];
    self.textView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200);
    self.textView.backgroundColor = [UIColor yellowColor];
    self.textView.placeholder = @"请输入文字，颜色、间距、光标位置可调";
    self.textView.placeholderColor = [UIColor redColor];
    self.textView.font = [UIFont systemFontOfSize:18.0];
    self.textView.cursorOffset = UIOffsetMake(5, 10);
   
}

- (LZBTextView *)textView
{
  if(_textView == nil)
  {
      _textView = [LZBTextView new];
  }
    return _textView;
}
@end
