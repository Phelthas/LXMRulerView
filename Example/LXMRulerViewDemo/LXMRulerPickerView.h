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


/**
 在更改了rulerStyle里面的属性之后，需要调用该方法才会生效
 */
- (void)reloadData;



/**
 手动设置ruler指示的值
 */
- (void)updateCurrentValue:(CGFloat)value animated:(BOOL)animated;

@end

