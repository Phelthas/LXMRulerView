//
//  TextXibViewController.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 16/7/21.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import "TextXibViewController.h"
#import "LXMRulerView.h"

@interface TextXibViewController ()

@property (weak, nonatomic) IBOutlet LXMRulerView *oneRulerView;
@property (weak, nonatomic) IBOutlet LXMRulerView *twoRulerView;
@property (weak, nonatomic) IBOutlet LXMRulerView *threeRulerView;

@end

@implementation TextXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:testLabel];
    
    
    self.oneRulerView.rulerStyle.minValue = 20;
    self.oneRulerView.rulerStyle.maxValue = 80;
    self.oneRulerView.rulerStyle.accuracy = 0.5;
    self.oneRulerView.rulerStyle.defaultValue = 32;
    self.oneRulerView.rulerStyle.rulerSpacing = 15;
    self.oneRulerView.rulerStyle.rulerLineColor = [UIColor orangeColor];
    [self.oneRulerView setValueChangeCallback:^(CGFloat currentValue) {
        NSLog(@"it is %@", @(currentValue));
        testLabel.text = [NSString stringWithFormat:@"ruler one :%.01f", currentValue];
    }];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneRulerView.frame), 100, 44)];
    addButton.backgroundColor = [UIColor orangeColor];
    [addButton setTitle:@"当前值加1" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(handleAddButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *changeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addButton.frame), CGRectGetMaxY(self.oneRulerView.frame), 100, 44)];
    changeButton.backgroundColor = [UIColor blueColor];
    [changeButton setTitle:@"改变样式" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(handleChangeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    
    
    //普通尺子样式
    
    self.twoRulerView.rulerType = LXMRulerTypeRuler;
    [self.twoRulerView reloadData];
    
    
    //自定义
    self.threeRulerView.rulerType = LXMRulerTypeRuler;
    self.threeRulerView.rulerStyle.rulerBackgroundColor = [UIColor purpleColor];
    self.threeRulerView.rulerStyle.rulerLineColor = [UIColor orangeColor];
    self.threeRulerView.rulerStyle.rulerFont = [UIFont boldSystemFontOfSize:14];
    self.threeRulerView.rulerStyle.rulerMargin = 40;
    self.threeRulerView.rulerStyle.rulerSpacing = 20;
    self.threeRulerView.rulerStyle.maxValue = 20;
    self.threeRulerView.rulerStyle.minValue = 10;
    self.threeRulerView.rulerStyle.longLineDistance = 10;
    self.threeRulerView.rulerStyle.shortLineDistance = 5;
    [self.threeRulerView reloadData];

    
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
//    [self.oneRulerView updateCurrentValue:30];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
