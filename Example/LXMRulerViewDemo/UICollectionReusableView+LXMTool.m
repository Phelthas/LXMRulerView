//
//  UICollectionReusableView+LXMTool.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/21.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import "UICollectionReusableView+LXMTool.h"

@implementation UICollectionReusableView (LXMTool)


+ (NSString *)lxm_reuseIdentifier {
    return NSStringFromClass(self);
}


@end
