//
//  LXMRulerCell.h
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/23.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMRulerStyle.h"

@interface LXMRulerCell : UICollectionViewCell

- (void)updateUIWithRulerStyle:(LXMRulerStyle *)rulerStyle atIndexPath:(NSIndexPath *)indexPath;


@end



@interface UICollectionReusableView (LXMTool)


/**
 cell的复用id，返回类名的string
 */
+ (NSString *)lxm_reuseIdentifier;

@end
