//
//  ViewController.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 16/7/13.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import "ViewController.h"
#import "LXMRulerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:testLabel];
    
    
    //尺子选择器样式
    LXMRulerView *oneRulerView = [[LXMRulerView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    [oneRulerView setValueChangeCallback:^(CGFloat currentValue) {
        testLabel.text = [NSString stringWithFormat:@"ruler one :%.01f", currentValue];
    }];
    oneRulerView.accuracy = 3;
    [oneRulerView reloadData];
    [self.view addSubview:oneRulerView];
    
    [oneRulerView updateCurrentValue:30];
    
    //普通尺子样式
    LXMRulerView *twoRulerView = [[LXMRulerView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    twoRulerView.showMarkView = NO;
    [twoRulerView reloadData];
    [self.view addSubview:twoRulerView];
    
    
    
    //自定义
    LXMRulerView *threeRulerView = [[LXMRulerView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
    threeRulerView.showMarkView = NO;
    threeRulerView.rulerBackgroundColor = [UIColor purpleColor];
    threeRulerView.rulerLineColor = [UIColor orangeColor];
    threeRulerView.rulerFont = [UIFont boldSystemFontOfSize:14];
    threeRulerView.rulerMargin = 40;
    threeRulerView.rulerSpacing = 20;
    threeRulerView.maxValue = 20;
    threeRulerView.minValue = 10;
    threeRulerView.longLineDistance = 10;
    threeRulerView.shortLineDistance = 5;
    
    [threeRulerView reloadData];
    [self.view addSubview:threeRulerView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
