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
    
    //尺子选择器样式
    [self.oneRulerView setValueChangeCallback:^(CGFloat currentValue) {
        testLabel.text = [NSString stringWithFormat:@"ruler one :%.01f", currentValue];
    }];
    self.oneRulerView.markViewSize = CGSizeMake(40, 30);

    [self.oneRulerView reloadData];
    [self.view addSubview:self.oneRulerView];
    
    [self.oneRulerView updateCurrentValue:30];
    
    
    //普通尺子样式
    self.twoRulerView.showMarkView = NO;
    [self.twoRulerView reloadData];
    [self.view addSubview:self.twoRulerView];
    
    
    
    //自定义
    self.threeRulerView.showMarkView = NO;
    self.threeRulerView.rulerBackgroundColor = [UIColor purpleColor];
    self.threeRulerView.rulerLineColor = [UIColor orangeColor];
    self.threeRulerView.rulerFont = [UIFont boldSystemFontOfSize:14];
    self.threeRulerView.rulerMargin = 40;
    self.threeRulerView.rulerSpacing = 20;
    self.threeRulerView.maxValue = 20;
    self.threeRulerView.minValue = 10;
    self.threeRulerView.longLineDistance = 10;
    self.threeRulerView.shortLineDistance = 5;
    
    [self.threeRulerView reloadData];
    [self.view addSubview:self.threeRulerView];

    
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
