//
//  LZBAutoAdjustViewVC.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBAutoAdjustViewVC.h"
#import "LZBTextView.h"
#import "UIViewController+LZBKeyBoardObserver.h"

@interface LZBAutoAdjustViewVC ()


@property (nonatomic, strong) UIView *lastView;
@end

@implementation LZBAutoAdjustViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //去除边沿延伸效果
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor purpleColor];
    titleLabel.text = @"注意：文本框自动适应键盘高度，主要用在登录页面";
    titleLabel.numberOfLines = 0;
    titleLabel.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //第一个
    LZBTextView *textView1 = [[LZBTextView alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    [self.view addSubview:textView1];
    textView1.backgroundColor = [UIColor yellowColor];
    textView1.placeholder = @"第一个-LZBTextView";
    textView1.placeholderColor = [UIColor redColor];
    textView1.font = [UIFont systemFontOfSize:14.0];
    self.lastView = textView1;
    
    //第二个
    LZBTextView *textView2 = [[LZBTextView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.lastView.frame) + 50, 200, 40)];
    self.lastView = textView2;
    [self.view addSubview:textView2];
    textView2.backgroundColor = [UIColor yellowColor];
    textView2.placeholder = @"第二个-LZBTextView";
    textView2.placeholderColor = [UIColor blueColor];
    textView2.font = [UIFont systemFontOfSize:16.0];
    
    //第三个
    LZBTextView *textView3 = [[LZBTextView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.lastView.frame) + 50, 200, 40)];
    self.lastView = textView3;
    [self.view addSubview:textView3];
    textView3.backgroundColor = [UIColor yellowColor];
    textView3.placeholder = @"第三个-LZBTextView";
    textView3.placeholderColor = [UIColor purpleColor];
    textView3.font = [UIFont systemFontOfSize:16.0];
    
    //第四个
    LZBTextView *textView4 = [[LZBTextView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.lastView.frame) + 50, 200, 40)];
    self.lastView = textView4;
    [self.view addSubview:textView4];
    textView4.backgroundColor = [UIColor yellowColor];
    textView4.placeholder = @"第四个-主要看键盘弹出";
    textView4.placeholderColor = [UIColor darkGrayColor];
    textView4.font = [UIFont systemFontOfSize:17.0];

    
    //第四个
    LZBTextView *textView5 = [[LZBTextView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.lastView.frame) + 50, 200, 40)];
    self.lastView = textView5;
    [self.view addSubview:textView5];
    textView5.backgroundColor = [UIColor yellowColor];
    textView5.placeholder = @"第五个-主要看键盘弹出";
    textView5.placeholderColor = [UIColor orangeColor];
    textView5.font = [UIFont systemFontOfSize:17.0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self lzb_addKeyBoardTapAnyAutoDismissKeyBoard];
    [self lzb_addKeyBoardObserverAutoAdjustHeight];
}


- (void)dealloc
{
    [self lzb_removeKeyBoardObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
