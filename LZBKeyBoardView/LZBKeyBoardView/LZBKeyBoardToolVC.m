//
//  LZBKeyBoardToolVC.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/12/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBKeyBoardToolVC.h"
#import "LZBKeyBoardToolBar.h"


@interface LZBKeyBoardToolVC ()
@property (nonatomic, strong) LZBKeyBoardToolBar *keyboardView ;
@end

@implementation LZBKeyBoardToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
   
  
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.keyboardView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (LZBKeyBoardToolBar *)keyboardView
{
  if(_keyboardView == nil)
  {
      _keyboardView = [LZBKeyBoardToolBar showKeyBoardWithConfigToolBarHeight:0 sendTextCompletion:nil];
  }
    return _keyboardView;
}



@end
