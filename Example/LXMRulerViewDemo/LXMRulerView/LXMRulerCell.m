//
//  LXMRulerCell.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/23.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import "LXMRulerCell.h"

@interface LXMRulerCell ()

@property (nonatomic, strong) CALayer *horizonalLayer;
@property (nonatomic, strong) NSArray<CALayer *> *verticalLayerArray;
@property (nonatomic, strong) UILabel *leadingLabel;
@property (nonatomic, strong) UILabel *trailingLabel;
@property (nonatomic, strong) LXMRulerStyle *rulerStyle;

@end

@implementation LXMRulerCell


#pragma mark - Property

- (LXMRulerStyle *)rulerStyle {
    if (!_rulerStyle) {
        _rulerStyle = [[LXMRulerStyle alloc] init];
    }
    return _rulerStyle;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect leadingRect = self.leadingLabel.frame;
    leadingRect.origin.x = -(leadingRect.size.width / 2);
    leadingRect.origin.y = self.rulerStyle.longLineDistance;
    self.leadingLabel.frame = leadingRect;
    
    CGRect trailingRect = self.trailingLabel.frame;
    trailingRect.origin.x = CGRectGetWidth(self.bounds) - (trailingRect.size.width / 2);
    trailingRect.origin.y = self.rulerStyle.longLineDistance;
    self.trailingLabel.frame = trailingRect;
}


#pragma mark - PrivateMethod

- (void)setupUI {
    
    self.horizonalLayer = [CALayer layer];
    self.horizonalLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1);
    self.horizonalLayer.backgroundColor = self.rulerStyle.rulerBackgroundColor.CGColor;
    [self.layer addSublayer:self.horizonalLayer];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 11; i++) {
        CALayer *subLayer = [CALayer layer];
        subLayer.frame = CGRectMake(i, 0, 1, 1);
        subLayer.backgroundColor = self.rulerStyle.rulerBackgroundColor.CGColor;
        [array addObject:subLayer];
        [self.layer addSublayer:subLayer];
    }
    self.verticalLayerArray = array;
    
    self.leadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.leadingLabel];
    
    self.trailingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.trailingLabel];
    
    [self updateUIWithRulerStyle:self.rulerStyle atIndexPath:nil];
}


#pragma mark - PublicMethod

- (void)updateUIWithRulerStyle:(LXMRulerStyle *)rulerStyle atIndexPath:(NSIndexPath *)indexPath {
    self.rulerStyle = rulerStyle;
    
    self.horizonalLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1);
    self.horizonalLayer.backgroundColor = self.rulerStyle.rulerLineColor.CGColor;
    
    CGFloat startPoint = 0;
    CGFloat endPoint = 0;
    CGFloat spacing = self.rulerStyle.rulerSpacing;
    CGFloat offsetValue = self.rulerStyle.minValue + indexPath.row * self.rulerStyle.accuracy * 10;
    for (int i = 0; i < 11; i++) {
        CALayer *subLayer = self.verticalLayerArray[i];
        startPoint = i * spacing;
        if (i == 0) {
            endPoint = self.rulerStyle.longLineDistance;
            self.leadingLabel.font = self.rulerStyle.rulerFont;
            self.leadingLabel.textColor = self.rulerStyle.rulerLineColor;
            self.leadingLabel.text = [NSString stringWithFormat:@"%.0f", offsetValue + i * self.rulerStyle.accuracy];
            [self.leadingLabel sizeToFit];
        } else if (i == 5) {
            endPoint = (self.rulerStyle.longLineDistance + self.rulerStyle.shortLineDistance) / 2.0;
        } else if (i == 10) {
            endPoint = self.rulerStyle.longLineDistance;
            self.trailingLabel.font = self.rulerStyle.rulerFont;
            self.trailingLabel.textColor = self.rulerStyle.rulerLineColor;
            self.trailingLabel.text = [NSString stringWithFormat:@"%.0f", offsetValue + i * self.rulerStyle.accuracy];
            [self.trailingLabel sizeToFit];
        } else {
            endPoint = self.rulerStyle.shortLineDistance;
        }
        subLayer.frame = CGRectMake(startPoint, 0, 1, endPoint);
        subLayer.backgroundColor = self.rulerStyle.rulerLineColor.CGColor;
        
    }
    
    if ((self.rulerStyle.maxValue - self.rulerStyle.minValue) / self.rulerStyle.accuracy / 10 - 1 == indexPath.row) {
        self.trailingLabel.hidden = NO;
    } else {
        self.trailingLabel.hidden = YES;
    }
    
}

@end


@implementation UICollectionReusableView (LXMTool)


+ (NSString *)lxm_reuseIdentifier {
    return NSStringFromClass(self);
}


@end
