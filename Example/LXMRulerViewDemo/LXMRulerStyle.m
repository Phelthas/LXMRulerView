//
//  LXMRulerStyle.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/21.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import "LXMRulerStyle.h"


#define OJAColorFromHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LXMRulerStyle ()

@end

@implementation LXMRulerStyle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.rulerBackgroundColor = OJAColorFromHex(0xf9f9f9);
        self.rulerLineColor = OJAColorFromHex(0xc7c7c7);
        self.rulerFont = [UIFont systemFontOfSize:18];
        self.rulerMargin = 15;
        self.rulerSpacing = 10;
        self.longLineDistance = 24;
        self.shortLineDistance = 12;
        self.minValue = 0;
        self.maxValue = 100;
        self.accuracy = 1;
        self.limitToAccuracy = YES;
        
        self.markViewColor = OJAColorFromHex(0xea5151);
        self.markViewSize = CGSizeMake(16, 8);
    
    }
    return self;
}

@end
