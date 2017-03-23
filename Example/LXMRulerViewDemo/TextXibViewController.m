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
