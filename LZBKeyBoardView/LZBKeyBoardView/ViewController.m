//
//  ViewController.m
//  LZBKeyBoardView
//
//  Created by zibin on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBTextView.h"
#import "LZBAutoAdjustViewVC.h"
#import "LZBKeyBoardToolVC.h"
#import "LZBEmojiKeyBoardVC.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LZBTextView *textView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <NSString *>*methodKeys;
@property (nonatomic, strong) NSArray <NSString *>*methodValues;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title= @"主页";
    self.methodKeys = @[@"LZBUserTextViewVC",
                        @"LZBAutoAdjustViewVC",
                        @"LZBKeyBoardToolVC",
                         @"LZBEmojiKeyBoardVC",];
    //显示文字
    self.methodValues = @[@"LZBTextView的使用 - 输入多行文字",
                          @"自定调整View来适应键盘-登录页面常用",
                          @"无表情键盘工具条使用 - 发布评论常用",
                          @"含有表情键盘工具条",
                          ];

}


#pragma mark- tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.methodKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"loadAnimaitonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.textLabel.text = self.methodValues[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *method = self.methodKeys[indexPath.row];
    Class classVC = NSClassFromString(method);
    UIViewController *vc = (UIViewController *)[classVC new];
    [self.navigationController pushViewController:vc animated:YES];
   
}


#pragma mark - 懒加载
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


@end
