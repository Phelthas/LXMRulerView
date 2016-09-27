//
//  LXMRulerView.h
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 16/7/13.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXMRulerView : UIView


@property (nonatomic, strong) UIColor *rulerBackgroundColor;//default is 0xf9f9f9
@property (nonatomic, strong) UIColor *rulerLineColor;//default is 0xc7c7c7
@property (nonatomic, strong) UIFont *rulerFont;//尺子上数字的字体 default is [UIFont systemFontOfSize:18];
@property (nonatomic, assign) BOOL limitToInteger;//default is YES;

@property (nonatomic, assign) CGFloat rulerMargin;//第一条刻度距离边缘的距离，default is 15,showMarkView == YES时无效
@property (nonatomic, assign) NSInteger rulerSpacing;//刻度之间的距离，default is 10;涉及到位置的准确性，所以用整型
@property (nonatomic, assign) CGFloat longLineDistance;//长刻度的长度，default is 24
@property (nonatomic, assign) CGFloat shortLineDistance;//短刻度的长度，default is 12
@property (nonatomic, assign) NSInteger minValue;//default is 0
@property (nonatomic, assign) NSInteger maxValue;//default is 100

@property (nonatomic, assign) CGFloat accuracy;//精确度默认是1，可以是0.1，0.2，0.5,2,5,10等等；可以被1整除的效果会比较好

@property (nonatomic, assign) BOOL showMarkView;//default is YES
@property (nonatomic, strong) UIColor *markViewColor;//指示标记的颜色，default is 0xea5151
@property (nonatomic, assign) CGSize  markViewSize;//指示标记的大小，default is 16*8
@property (nonatomic, assign, readonly) CGFloat currentValue;//markView指示的值，showMarkView == NO时无效
@property (nonatomic, copy) void(^valueChangeCallback)(CGFloat currentValue);//currentValue变化的回调，showMarkView == NO时无效

/**
 *  设置尺子指示的值,showMarkView == NO时无效
 */
- (void)updateCurrentValue:(CGFloat)value;

/**
 *  更改样式之类的属性后，需要调用reloadData才能生效；
 */
- (void)reloadData;

@end
