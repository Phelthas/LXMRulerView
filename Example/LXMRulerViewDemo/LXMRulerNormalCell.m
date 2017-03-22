//
//  LXMRulerNormalCell.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/21.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import "LXMRulerNormalCell.h"

@implementation LXMRulerNormalCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}


#pragma mark - PrivateMethod

- (void)setupUI {
    self.horizonalLayer = [CALayer layer];
    self.horizonalLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1);
    self.horizonalLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:self.horizonalLayer];
    
    CGFloat startPoint = 0;
    CGFloat spacing = 10;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        CALayer *subLayer = [CALayer layer];
        startPoint = i * spacing;
        subLayer.frame = CGRectMake(startPoint, 0, 1, 15);
        subLayer.backgroundColor = [UIColor orangeColor].CGColor;
        [array addObject:subLayer];
        [self.layer addSublayer:subLayer];
    }
    self.verticalLayerArray = array;
}

@end
