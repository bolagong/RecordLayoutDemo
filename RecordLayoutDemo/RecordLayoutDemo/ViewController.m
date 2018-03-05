//
//  ViewController.m
//  RecordLayoutDemo
//
//  Created by chang on 2018/3/5.
//  Copyright © 2018年 chang. All rights reserved.
//

#import "ViewController.h"
#import "CCRecordView.h"

#define MAIN_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //模拟数据
    NSArray *recordArray = @[@"Classical",@"摇滚",@"art",@"rock",@"波普哈哈",@"pop",@"说唱", @"pop",@"rap",@"雷鬼",@"reg",@"gae",@"索尔", @"古典音",@"Pop",@"music:", @"流",@"行音乐",@"Bl", @"蓝调歌曲",@"忧郁音乐",@"Rock", @"Roll",@"electrophonic", @"music", @"电",@"音乐",@"ambient", @"情境音乐",@"trance",@"舞曲",@"classical",@"摇滚乐",@"Jazz"];
    //封装的那个view
    CCRecordView *recordView = [[CCRecordView alloc] initWithFrame:CGRectMake(0, 100, MAIN_SCREEN_WIDTH, 120) title:@"这里有记录" array:recordArray];
    [self.view addSubview:recordView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
