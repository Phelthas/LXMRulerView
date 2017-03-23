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


@property (nonatomic, strong) LXMRulerView *oneRulerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:testLabel];
    
    LXMRulerView *oneRulerView = [[LXMRulerView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    oneRulerView.rulerStyle.minValue = 20;
    oneRulerView.rulerStyle.maxValue = 80;
    oneRulerView.rulerStyle.accuracy = 0.5;
    oneRulerView.rulerStyle.rulerSpacing = 15;
    oneRulerView.rulerStyle.rulerLineColor = [UIColor orangeColor];
    [oneRulerView setValueChangeCallback:^(CGFloat currentValue) {
        NSLog(@"it is %@", @(currentValue));
        testLabel.text = [NSString stringWithFormat:@"ruler one :%.01f", currentValue];
    }];
    [self.view addSubview:oneRulerView];
    self.oneRulerView = oneRulerView;
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneRulerView.frame), 100, 44)];
    addButton.backgroundColor = [UIColor orangeColor];
    [addButton setTitle:@"当前值加1" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(handleAddButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *changeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addButton.frame), CGRectGetMaxY(oneRulerView.frame), 100, 44)];
    changeButton.backgroundColor = [UIColor blueColor];
    [changeButton setTitle:@"改变样式" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(handleChangeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    
    
    //普通尺子样式
    LXMRulerView *twoRulerView = [[LXMRulerView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    twoRulerView.rulerType = LXMRulerTypeRuler;
    [twoRulerView reloadData];
    [self.view addSubview:twoRulerView];
    
    
    //自定义
    LXMRulerView *threeRulerView = [[LXMRulerView alloc] initWithFrame:CGRectMake(0, 400, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
    threeRulerView.rulerType = LXMRulerTypeRuler;
    threeRulerView.rulerStyle.rulerBackgroundColor = [UIColor purpleColor];
    threeRulerView.rulerStyle.rulerLineColor = [UIColor orangeColor];
    threeRulerView.rulerStyle.rulerFont = [UIFont boldSystemFontOfSize:14];
    threeRulerView.rulerStyle.rulerMargin = 40;
    threeRulerView.rulerStyle.rulerSpacing = 20;
    threeRulerView.rulerStyle.maxValue = 20;
    threeRulerView.rulerStyle.minValue = 10;
    threeRulerView.rulerStyle.longLineDistance = 10;
    threeRulerView.rulerStyle.shortLineDistance = 5;
    [self.view addSubview:threeRulerView];
    [threeRulerView reloadData];
    
    
   
    
}


- (void)handleAddButtonTapped:(UIButton *)sender {
    CGFloat currentValue = self.oneRulerView.currentValue;
    [self.oneRulerView updateCurrentValue:currentValue + 1 animated:YES];
}

- (void)handleChangeButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.oneRulerView.rulerStyle.minValue = 30;
        self.oneRulerView.rulerStyle.maxValue = 120;
        self.oneRulerView.rulerStyle.accuracy = 1;
        self.oneRulerView.rulerStyle.rulerSpacing = 10;
        self.oneRulerView.rulerStyle.markViewColor = [UIColor redColor];
        self.oneRulerView.rulerStyle.rulerLineColor = [UIColor orangeColor];
    } else {
        self.oneRulerView.rulerStyle.minValue = 20;
        self.oneRulerView.rulerStyle.maxValue = 80;
        self.oneRulerView.rulerStyle.accuracy = 0.5;
        self.oneRulerView.rulerStyle.rulerSpacing = 15;
        self.oneRulerView.rulerStyle.markViewColor = [UIColor purpleColor];
        self.oneRulerView.rulerStyle.rulerLineColor = [UIColor blueColor];
    }
    [self.oneRulerView reloadData];
    

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
