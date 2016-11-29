//
//  ViewController.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBTextView.h"

@interface ViewController ()

@property (nonatomic, strong) LZBTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    self.textView.frame = CGRectMake(0, 100, 300, 200);
    self.textView.placeholder = @"请输入文字";
    self.textView.placeholderColor = [UIColor redColor];
    self.textView.font = [UIFont systemFontOfSize:18.0];
    self.textView.cursorOffset = UIOffsetMake(5, 10);
}


- (LZBTextView *)textView
{
  if(_textView == nil)
  {
      _textView = [[LZBTextView alloc]init];
      _textView.backgroundColor = [UIColor blueColor];
  }
    return _textView;
}

@end
