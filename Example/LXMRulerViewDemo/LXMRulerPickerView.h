//
//  LXMRulerPickerView.h
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/22.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMRulerStyle.h"


@interface LXMRulerPickerView : UIView

@property (nonatomic, strong, nonnull) LXMRulerStyle *rulerStyle;

@property (nonatomic, assign, readonly) CGFloat currentValue;//markView指示的值
@property (nonatomic, copy, nullable) void(^valueChangeCallback)(CGFloat currentValue);//currentValue变化的回调


- (void)reloadData;

@end

