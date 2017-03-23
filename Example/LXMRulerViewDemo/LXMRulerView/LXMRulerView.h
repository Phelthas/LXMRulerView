//
//  LXMRulerView.h
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 16/7/13.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMRulerStyle.h"

typedef NS_ENUM(NSInteger, LXMRulerType) {
    LXMRulerTypePicker = 0,
    LXMRulerTypeRuler = 1,
};

@interface LXMRulerView : UIView

@property (nonatomic, strong, nonnull) LXMRulerStyle *rulerStyle;
@property (nonatomic, assign) LXMRulerType rulerType;//default is LXMRulerTypePicker


/**
 在更改了rulerStyle里面的属性或者rulerType之后，需要调用该方法才会生效
 */
- (void)reloadData;




/**
 rulerType == LXMRulerTypePicker有效，markView指示的值
 */
@property (nonatomic, assign, readonly) CGFloat currentValue;

/**
 rulerType == LXMRulerTypePicker有效，currentValue变化的回调
 */

@property (nonatomic, copy, nullable) void(^valueChangeCallback)(CGFloat currentValue);

/**
 rulerType == LXMRulerTypePicker有效，手动设置ruler指示的值
 */
- (void)updateCurrentValue:(CGFloat)value animated:(BOOL)animated;


@end


