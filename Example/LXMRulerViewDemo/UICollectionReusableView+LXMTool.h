//
//  UICollectionReusableView+LXMTool.h
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/21.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionReusableView (LXMTool)


/**
 cell的复用id，返回类名的string
 */
+ (NSString *)lxm_reuseIdentifier;

@end
