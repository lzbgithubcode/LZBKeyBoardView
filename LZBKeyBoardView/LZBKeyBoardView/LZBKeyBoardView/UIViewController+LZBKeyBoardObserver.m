//
//  UIViewController+LZBKeyBoardObserver.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+LZBKeyBoardObserver.h"
#import <objc/runtime.h>

CGFloat _lzb_keyBoard_DefaultMargin = lzb_settingKeyBoard_DefaultMargin;
static NSObject *_keyboardWillShowObser;
static NSObject *_keyboardWillHideObser;
@implementation UIViewController (LZBKeyBoardObserver)

#pragma mark - API
- (void)lzb_addKeyBoardObserverAutoAdjustHeight
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)lzb_removeKeyBoardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //键盘手势
    [[NSNotificationCenter defaultCenter] removeObserver:_keyboardWillShowObser name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:_keyboardWillHideObser name:UIKeyboardWillHideNotification object:nil];
}

- (void)lzb_addKeyBoardTapAnyAutoDismissKeyBoard
{
    UITapGestureRecognizer *lzbTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
     __weak UIViewController *weakSelf = self;
   _keyboardWillShowObser=[[NSNotificationCenter defaultCenter]
                           addObserverForName:UIKeyboardWillShowNotification
                                       object:nil
                                        queue:mainQuene
                                   usingBlock:^(NSNotification * _Nonnull note) {
                                [weakSelf.view addGestureRecognizer:lzbTap];
                            }];
    
  _keyboardWillHideObser = [[NSNotificationCenter defaultCenter]
                            addObserverForName:UIKeyboardWillHideNotification
                                        object:nil
                                         queue:mainQuene
                                    usingBlock:^(NSNotification *note){
                           [weakSelf.view removeGestureRecognizer:lzbTap];
                          }];
}


#pragma mark - handel
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的参数
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardAnimaitonDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    //移除之前的动画
    [self.view.layer removeAllAnimations];
  
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //找出第一响应者
    UIView *firstResponseView = [self findFirstResponderWithView:self.view];
    CGRect rect = [keyWindow convertRect:firstResponseView.frame fromView:firstResponseView.superview];
    //计算第一响应者与键盘弹出的差值，滚动距离
    CGFloat firstResponseViewMaxY= CGRectGetMaxY(rect);
    CGFloat keyBoardY = keyWindow.bounds.size.height - keyboardHeight;
    CGFloat keyBoardResponseViewMargin = firstResponseViewMaxY - keyBoardY;
    //如果响应者的最大Y值 > 键盘的Y值才滚动
    _lzb_keyBoard_DefaultMargin = 0;
    if(firstResponseViewMaxY > keyBoardY)
    {
        //设置lzb_settingKeyBoard_DefaultMargin固定距离（就是滚动后的间距）
        _lzb_keyBoard_DefaultMargin = lzb_settingKeyBoard_DefaultMargin;
        _lzb_keyBoard_DefaultMargin +=keyBoardResponseViewMargin;
        
        //滚动动画
        __weak UIViewController *weakSelf = self;
        [UIView animateKeyframesWithDuration:keyboardAnimaitonDuration
                                       delay:0
                                     options:option
                                  animations:^{
                                      CGRect frame = weakSelf.view.frame;
                                      frame.origin.y -= _lzb_keyBoard_DefaultMargin;
                                      weakSelf.view.frame = frame;
             
           } completion:nil];
    }
   
}

- (void)keyboardWillHide:(NSNotification *)notification
{
     //获取键盘的参数
    CGFloat keyboardAnimaitonDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
     __weak UIViewController *weakSelf = self;
    //滚动动画
    [UIView animateWithDuration:keyboardAnimaitonDuration
                          delay:0
                        options:option
                     animations:^{
                         CGRect frame = weakSelf.view.frame;
                         frame.origin.y += _lzb_keyBoard_DefaultMargin;
                         weakSelf.view.frame = frame;
                     }
                     completion:nil];
    //注意：一定要清0，因为不知道下一次响应者是位置
     _lzb_keyBoard_DefaultMargin = 0;
}
- (UIView *)findFirstResponderWithView:(UIView *)view
{
   if(self.isFirstResponder)
       return self.view;
    for (UIView *subView in view.subviews)
    {
        if(subView.isFirstResponder)
            return subView;
        else
            continue;
    }
    return view;
}



@end
