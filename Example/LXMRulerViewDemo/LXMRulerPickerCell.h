//
//  LXMRulerPickerCell.h
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/22.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMRulerStyle.h"

@interface LXMRulerPickerCell : UICollectionViewCell

- (void)updateUIWithRulerStyle:(LXMRulerStyle *)rulerStyle atIndexPath:(NSIndexPath *)indexPath;

@end
