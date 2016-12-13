//
//  LZBEmojiKeyBoardVC.m
//  LZBKeyBoardView
//
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBEmojiKeyBoardVC.h"
#import "LZBKeyBoardToolEmojiBar.h"

@interface LZBEmojiKeyBoardVC ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) LZBKeyBoardToolEmojiBar *keyboardView ;
@end

@implementation LZBEmojiKeyBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.keyboardView];
    [self.view addSubview:self.textLabel];
    self.textLabel.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 300);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - lazy
- (LZBKeyBoardToolEmojiBar *)keyboardView
{
    if(_keyboardView == nil)
    {
        __weak typeof(self) weakSelf = self;
        _keyboardView = [LZBKeyBoardToolEmojiBar showKeyBoardWithConfigToolBarHeight:0 sendTextCompletion:^(NSString *sendText) {
            weakSelf.textLabel.text = sendText;
        }];
        [_keyboardView  setInputViewPlaceHolderText:@"请输入文字"];
    }
    return _keyboardView;
}

- (UILabel *)textLabel
{
    if(_textLabel == nil)
    {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor redColor];
        _textLabel.text = @"显示输入框输入文字";
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}


@end
