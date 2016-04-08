//
//  ViewController.m
//  TestBadgeButton
//
//  Created by qianyb on 16/4/8.
//  Copyright © 2016年 qianyb. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Badge.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 60)];

    //显示小圆圈
    [button setBadge:@" " layoutOnImageOrTitleTopLeft:BadgeLayoutOnTitle];
//    //显示数字
//    [button setBadge:@"12" layoutOnImageOrTitleTopLeft:BadgeLayoutOnTitle];
//    //显示文字
//    [button setBadge:@"你好" layoutOnImageOrTitleTopLeft:BadgeLayoutOnTitle];
    
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ico_home"] forState:UIControlStateNormal];
    [button setTitle:@"我家" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
