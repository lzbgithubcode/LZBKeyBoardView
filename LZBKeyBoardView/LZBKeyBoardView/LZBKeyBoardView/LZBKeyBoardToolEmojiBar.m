//
//  LZBKeyBoardToolEmojiBar.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBKeyBoardToolEmojiBar.h"
#import "LZBTextView.h"
#import "UIView+LZBViewFrame.h"
#import "LZBFaceView.h"
#import "NSString+LZBTranscoding.h"

//颜色转换
#define LZBColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//获取图片资源
#define LZBKeyboardBundleImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"Resource.bundle/",name]]

#define kKeyboardView_FaceViewHeight 216  // 表情键盘高度
#define kKeyboardViewToolBarHeight 50  // 默认键盘输入工具条的高度
#define kKeyboardViewToolBar_TextView_Height 35  // 默认键盘输入框的高度
#define kKeyboardViewToolBar_TextView_LimitHeight 60  // 默认键盘输入框的限制高度
#define kKeyboardViewToolBar_SendBtn_Width 40  // 默认发送按钮的宽度
#define kKeyboardViewToolBar_Horizontal_DefaultMargin 15  //水平方向默认间距
#define kKeyboardViewToolBar_Vertical_DefaultMargin 8  //垂直方向默认间距
#define LZBScreenHeight [UIScreen mainScreen].bounds.size.height
#define LZBScreenWidth [UIScreen mainScreen].bounds.size.width
#define inputextViewFont [UIFont systemFontOfSize:14.0]

@interface LZBKeyBoardToolEmojiBar()
//View
@property (nonatomic, strong) LZBTextView *inputTextView;  //输入框
@property (nonatomic, strong) UIView *topLine;      // 顶部分割线
@property (nonatomic, strong) UIView *bottomLine;      // 底部分割线
@property (nonatomic, strong) UIButton *faceButton;      // 按钮
@property (nonatomic, strong) LZBFaceView *faceView;

//data
@property (nonatomic, copy) void(^sendTextBlock)(NSString *text);  //输入框输入字符串回调Blcok
@property (nonatomic, assign) CGFloat textHeight;   //输入文字高度
@property (nonatomic, assign) CGFloat animationDuration;  //动画时间
@property (nonatomic, strong) NSString *placeHolder;  //占位文字
@end

@implementation LZBKeyBoardToolEmojiBar
#pragma mark - API
+ (LZBKeyBoardToolEmojiBar *)showKeyBoardWithConfigToolBarHeight:(CGFloat)toolBarHeight sendTextCompletion:(void(^)(NSString *sendText))sendTextBlock
{
    LZBKeyBoardToolEmojiBar *toolBar = [[LZBKeyBoardToolEmojiBar alloc]init];
    toolBar.backgroundColor = LZBColorRGB(247, 248, 250);
    if(toolBarHeight < kKeyboardViewToolBarHeight)
        toolBarHeight = kKeyboardViewToolBarHeight;
    toolBar.frame = CGRectMake(0, LZBScreenHeight - toolBarHeight, LZBScreenWidth, toolBarHeight);
    toolBar.sendTextBlock = sendTextBlock;
    return toolBar;
    
}
- (void)setInputViewPlaceHolderText:(NSString *)placeText
{
    self.inputTextView.placeholder = placeText;
    self.placeHolder = placeText;
}
- (void)becomeFirstResponder{
    [self.inputTextView becomeFirstResponder];
    self.hidden = NO;
}

- (void)resignFirstResponder{
    [self.inputTextView resignFirstResponder];
}


#pragma mark - private
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.inputTextView];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.faceButton];
     __weak typeof(self) weakSelf = self;
    [self.faceView setEmojiModles:[self loadEmojiEmotions] selectEmojiModelBlock:^(LZBEmojiModel *selectModel) {
        [weakSelf emojitionDidSelect:selectModel];
    } deleteBlcok:^{
        [weakSelf emojitionDidDelete];
    } sendBlcok:^{
        [weakSelf emojitionDidSend];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.inputTextView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    CGFloat height = (self.textHeight + kKeyboardViewToolBar_TextView_Height)> kKeyboardViewToolBarHeight ? (self.textHeight + kKeyboardViewToolBar_TextView_Height) : kKeyboardViewToolBarHeight;
    CGFloat offsetY = self.LZB_heigth - height;
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.LZB_y  += offsetY;
        weakSelf.LZB_heigth = height;
    }];
    
    self.topLine.LZB_width = self.LZB_width;
    self.bottomLine.LZB_width = self.LZB_width;
    
    
    CGSize sendButtonSize = self.faceButton.currentImage.size;
    self.faceButton.LZB_width = sendButtonSize.width;
    self.faceButton.LZB_heigth = sendButtonSize.height;
    self.faceButton.LZB_x = self.LZB_width - sendButtonSize.width - kKeyboardViewToolBar_Horizontal_DefaultMargin;
    
    
    self.inputTextView.LZB_width = self.LZB_width - sendButtonSize.width - 3 *kKeyboardViewToolBar_Horizontal_DefaultMargin;
    self.inputTextView.LZB_x = kKeyboardViewToolBar_Horizontal_DefaultMargin;
    
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.inputTextView.LZB_heigth = weakSelf.LZB_heigth - 2 *kKeyboardViewToolBar_Vertical_DefaultMargin;
        weakSelf.inputTextView.LZB_centerY = weakSelf.LZB_heigth * 0.5;
        weakSelf.faceButton.LZB_y = weakSelf.LZB_heigth - sendButtonSize.height -kKeyboardViewToolBar_Vertical_DefaultMargin;
        weakSelf.bottomLine.LZB_y = weakSelf.LZB_heigth - weakSelf.bottomLine.LZB_heigth;
    }];
    
    [self.inputTextView setNeedsUpdateConstraints];
}



#pragma mark - handle
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    CGFloat keyboardAnimaitonDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.animationDuration = keyboardAnimaitonDuration;
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    // 普通文本键盘与表情键盘切换时，过滤
    BOOL isEmojiKeyBoard = !self.faceButton.selected &&keyboardFrame.size.height == kKeyboardView_FaceViewHeight;
    BOOL isNormalKeyBoard = self.faceButton.selected &&keyboardFrame.size.height != kKeyboardView_FaceViewHeight;
    if(isEmojiKeyBoard || isNormalKeyBoard) return;
    
    //判断键盘是否出现
    BOOL isKeyBoardHidden = LZBScreenHeight == keyboardFrame.origin.y;
    CGFloat offsetMarginY = isKeyBoardHidden ? LZBScreenHeight - self.LZB_heigth :LZBScreenHeight - self.LZB_heigth - keyboardHeight;
    
    [UIView animateKeyframesWithDuration:self.animationDuration delay:0 options:option animations:^{
        self.LZB_y = offsetMarginY;
    } completion:nil];
    
}

- (void)textDidChange
{
    //注意：点击发送之后是先收到这个通知，收到通知的时候hasText = YES，让后再text = @"",所以在inputTextView里面的监听无效
    self.inputTextView.placeHolderHidden = self.inputTextView.hasText;
    if([self.inputTextView.text containsString:@"\n"])
    {
        [self emojitionDidSend];
        return;
    }
    
    CGFloat margin = self.inputTextView.textContainerInset.left + self.inputTextView.textContainerInset.right;
    
    CGFloat height = [self.inputTextView.text boundingRectWithSize:CGSizeMake(self.inputTextView.LZB_width - margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.inputTextView.font} context:nil].size.height;
    
    if(height == self.textHeight) return;
    
    // 确保输入框不会无限增高，控制在显示4行
    if (height > kKeyboardViewToolBar_TextView_LimitHeight) {
        return;
    }
    self.textHeight = height;
    
    [self setNeedsLayout];
}

- (void)faceButtonClick:(UIButton *)faceButton
{
    faceButton.selected = !faceButton.isSelected;
    self.bottomLine.hidden = !faceButton.selected;
    [self.inputTextView resignFirstResponder];
    self.inputTextView.inputView = faceButton.selected?self.faceView : nil;
    [self.inputTextView becomeFirstResponder];
}

- (void)emojitionDidSelect:(LZBEmojiModel *)emojiModel
{
    self.inputTextView.text = [self.inputTextView.text stringByAppendingString:emojiModel.code.emoji];
    [self textDidChange];
}

- (void)emojitionDidDelete
{
    [self.inputTextView deleteBackward];
}

- (void)emojitionDidSend
{
    NSString *text = self.inputTextView.text;
    if(self.sendTextBlock)
        self.sendTextBlock(text);
    [self resetInputView];
    [self textDidChange];
    
}

- (void)resetInputView
{
    self.inputTextView.text = @"";
    [self setInputViewPlaceHolderText:self.placeHolder.length > 0 ? self.placeHolder : @""];
    [self.inputTextView resignFirstResponder];
    if(self.faceButton.selected)
    {
        self.faceButton.selected = !self.faceButton.isSelected;
        self.bottomLine.hidden = !self.faceButton.selected;
        self.inputTextView.inputView = self.faceButton.selected?self.faceView : nil;
    }
  
    //布局的目的是布局textContainer 显示区域,显示区域回到初始位置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}



#pragma mark - lazy

- (NSArray <LZBEmojiModel *>*)loadEmojiEmotions{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Resource.bundle/emoji.plist" ofType:nil];
    
    NSArray *emotions = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *emotionsMul = [NSMutableArray array];
    for (NSDictionary *dic in emotions) {
        LZBEmojiModel *model = [[LZBEmojiModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [emotionsMul addObject:model];
    }
    return emotionsMul.copy;
}
- (LZBFaceView *)faceView
{
  if(_faceView == nil)
  {
      _faceView = [LZBFaceView new];
      _faceView.backgroundColor = LZBColorRGB(240, 240, 240);
      _faceView.frame = CGRectMake(0, 0, LZBScreenWidth, kKeyboardView_FaceViewHeight);
  }
    return _faceView;
}
- (UIButton *)faceButton
{
    if(_faceButton == nil)
    {
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_faceButton setImage:LZBKeyboardBundleImage(@"iocn_comment_expression") forState:UIControlStateNormal];
        [_faceButton setImage:LZBKeyboardBundleImage(@"iocn_comment_keyboard") forState:UIControlStateSelected];
        [_faceButton addTarget:self action:@selector(faceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}
- (LZBTextView *)inputTextView
{
    if(_inputTextView == nil)
    {
        _inputTextView = [[LZBTextView alloc]init];
        _inputTextView.layer.cornerRadius = 4;
        _inputTextView.layer.masksToBounds = YES;
        _inputTextView.layer.borderWidth = 1;
        _inputTextView.layer.borderColor = LZBColorRGB(221, 221, 221).CGColor;
        _inputTextView.font = inputextViewFont;
        _inputTextView.textColor = LZBColorRGB(102, 102, 102);
        _inputTextView.tintColor = _inputTextView.textColor;
        _inputTextView.enablesReturnKeyAutomatically = YES;
        _inputTextView.returnKeyType = UIReturnKeySend;
        _inputTextView.placeholderColor = LZBColorRGB(150, 150, 150);
    }
    return _inputTextView;
}

- (UIView *)topLine{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        _topLine.LZB_heigth = 0.5;
        _topLine.backgroundColor = LZBColorRGB(214, 214, 214);
    }
    return _topLine;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = LZBColorRGB(214, 214, 214);
        _bottomLine.LZB_heigth = 0.5;
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}



@end
