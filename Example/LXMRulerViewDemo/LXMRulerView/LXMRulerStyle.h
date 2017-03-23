//
//  LXMRulerStyle.h
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/21.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXMRulerStyle : NSObject

@property (nonatomic, strong, nonnull) UIColor *rulerBackgroundColor;//default is 0xf9f9f9
@property (nonatomic, strong, nonnull) UIColor *rulerLineColor;//default is 0xc7c7c7
@property (nonatomic, strong, nonnull) UIFont *rulerFont;//尺子上数字的字体 default is [UIFont systemFontOfSize:18];
@property (nonatomic, assign) NSInteger rulerSpacing;//刻度之间的距离，default is 10;涉及到位置的准确性，所以用整型
@property (nonatomic, assign) CGFloat longLineDistance;//长刻度的长度，default is 24
@property (nonatomic, assign) CGFloat shortLineDistance;//短刻度的长度，default is 12
@property (nonatomic, assign) NSInteger minValue;//default is 0
@property (nonatomic, assign) NSInteger maxValue;//default is 100
@property (nonatomic, assign) CGFloat accuracy;//精确度默认是1，可以是0.1，0.2，0.5,2,5,10等等；可以被1整除的效果会比较好
@property (nonatomic, assign) BOOL limitToAccuracy;//default is YES;设置以后只会停止到具体刻度上，不会停到两个刻度中间
@property (nonatomic, assign) CGFloat rulerMargin;//LXMRulerTypeRuler专用属性，第一条刻度距离边缘的距离，default is 15



@property (nonatomic, strong, nullable) UIColor *markViewColor;//LXMRulerTypePicker专用属性，指示标记的颜色，default is 0xea5151
@property (nonatomic, assign) CGSize markViewSize;//LXMRulerTypePicker专用属性，指示标记的大小，default is 16*8


@end
