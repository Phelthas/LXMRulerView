//
//  ViewController.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 16/7/13.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import "ViewController.h"
#import "LXMRulerView.h"
#import "LXMRulerPickerView.h"

@interface ViewController ()


@property (nonatomic, strong) LXMRulerPickerView *fourRulerView;

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
    oneRulerView.accuracy = 0.1;
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
    
    
    LXMRulerPickerView *fourRulerView = [[LXMRulerPickerView alloc] initWithFrame:CGRectMake(0, 400, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    fourRulerView.rulerStyle.minValue = 20;
    fourRulerView.rulerStyle.maxValue = 80;
    fourRulerView.rulerStyle.accuracy = 0.5;
    fourRulerView.rulerStyle.rulerSpacing = 15;
    fourRulerView.rulerStyle.rulerLineColor = [UIColor orangeColor];
    [fourRulerView setValueChangeCallback:^(CGFloat currentValue) {
        NSLog(@"it is %@", @(currentValue));
    }];
    [self.view addSubview:fourRulerView];
    self.fourRulerView = fourRulerView;
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fourRulerView.frame), 100, 44)];
    addButton.backgroundColor = [UIColor orangeColor];
    [addButton setTitle:@"当前值加1" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(handleAddButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *changeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addButton.frame), CGRectGetMaxY(fourRulerView.frame), 100, 44)];
    changeButton.backgroundColor = [UIColor blueColor];
    [changeButton setTitle:@"改变样式" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(handleChangeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    
}


- (void)handleAddButtonTapped:(UIButton *)sender {
    CGFloat currentValue = self.fourRulerView.currentValue;
    [self.fourRulerView updateCurrentValue:currentValue + 1 animated:YES];
}

- (void)handleChangeButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.fourRulerView.rulerStyle.minValue = 30;
        self.fourRulerView.rulerStyle.maxValue = 120;
        self.fourRulerView.rulerStyle.accuracy = 1;
        self.fourRulerView.rulerStyle.rulerSpacing = 10;
        self.fourRulerView.rulerStyle.markViewColor = [UIColor redColor];
    } else {
        self.fourRulerView.rulerStyle.minValue = 20;
        self.fourRulerView.rulerStyle.maxValue = 80;
        self.fourRulerView.rulerStyle.accuracy = 0.5;
        self.fourRulerView.rulerStyle.rulerSpacing = 15;
        self.fourRulerView.rulerStyle.markViewColor = [UIColor purpleColor];
    }
    [self.fourRulerView reloadData];
    

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
