//
//  UIViewController+LZBKeyBoardObserver.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+LZBKeyBoardObserver.h"
#import <objc/runtime.h>

static const void *lzbkeyBoard_DefaultMarginKey = @"lzbkeyBoard_DefaultMarginKey";
@implementation UIViewController (LZBKeyBoardObserver)
- (void)setLzb_keyBoard_DefaultMargin:(NSInteger)lzb_keyBoard_DefaultMargin
{
    objc_setAssociatedObject(self, lzbkeyBoard_DefaultMarginKey, @(lzb_keyBoard_DefaultMargin), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)lzb_keyBoard_DefaultMargin
{
    return [objc_getAssociatedObject(self,lzbkeyBoard_DefaultMarginKey) integerValue];
}


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
}

- (void)lzb_addKeyBoardTapAnyAutoDismissKeyBoard
{
    UITapGestureRecognizer *lzbTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
     __weak UIViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                      object:nil
                                                       queue:mainQuene
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                    [weakSelf.view addGestureRecognizer:lzbTap];
                                                   }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
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
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardAnimaitonDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [self.view.layer removeAllAnimations];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *firstResponseView = [self findFirstResponderWithView:self.view];
    CGRect rect = [keyWindow convertRect:firstResponseView.frame fromView:firstResponseView.superview];
    CGFloat firstResponseViewMaxY= CGRectGetMaxY(rect);
    CGFloat keyBoardY = keyWindow.bounds.size.height - keyboardHeight;
    CGFloat keyBoardResponseViewMargin = firstResponseViewMaxY - keyBoardY;
    if(firstResponseViewMaxY > keyBoardY)
    {
        self.lzb_keyBoard_DefaultMargin +=keyBoardResponseViewMargin;
        __weak UIViewController *weakSelf = self;
        [UIView animateKeyframesWithDuration:keyboardAnimaitonDuration
                                       delay:0
                                     options:option
                                  animations:^{
                                      CGRect frame = weakSelf.view.frame;
                                      frame.origin.y -= weakSelf.lzb_keyBoard_DefaultMargin;
                                      weakSelf.view.frame = frame;
             
           } completion:nil];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat keyboardAnimaitonDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
     __weak UIViewController *weakSelf = self;
    [UIView animateWithDuration:keyboardAnimaitonDuration
                          delay:0
                        options:option
                     animations:^{
                         CGRect frame = weakSelf.view.frame;
                         frame.origin.y += weakSelf.lzb_keyBoard_DefaultMargin;
                         weakSelf.view.frame = frame;
                     }
                     completion:nil];
     self.lzb_keyBoard_DefaultMargin = 0;
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
