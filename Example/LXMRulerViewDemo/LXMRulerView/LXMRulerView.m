//
//  LXMRulerView.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 16/7/13.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import "LXMRulerView.h"

#define OJAColorFromHex(rgbValue) [UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
    blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface LXMRulerValueView : UIView;

@property (nonatomic, strong) UIColor *rulerLineColor;
@property (nonatomic, strong) UIFont *rulerFont;
@property (nonatomic, assign) CGFloat rulerMargin;
@property (nonatomic, assign) CGFloat rulerSpacing;
@property (nonatomic, assign) CGFloat longLineDistance;
@property (nonatomic, assign) CGFloat shortLineDistance;
@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, assign) NSInteger maxValue;
@property (nonatomic, assign) CGFloat accuracy;

@end

@implementation LXMRulerValueView


- (instancetype)initWithFrame:(CGRect)frame
               rulerLineColor:(UIColor *)rulerLineColor
                    rulerFont:(UIFont *)rulerFont
                  rulerMargin:(CGFloat)rulerMargin
                 rulerSpacing:(CGFloat)rulerSpacing
             longLineDistance:(CGFloat)longLineDistance
            shortLineDistance:(CGFloat)shortLineDistance
                     minValue:(NSInteger)minValue
                     maxValue:(NSInteger)maxValue
                     accuracy:(CGFloat)accuracy {
    self = [super initWithFrame:frame];
    if (self) {
        self.rulerLineColor = rulerLineColor;
        self.rulerFont = rulerFont;
        self.rulerMargin = rulerMargin;
        self.rulerSpacing = rulerSpacing;
        self.longLineDistance = longLineDistance;
        self.shortLineDistance = shortLineDistance;
        self.minValue = minValue;
        self.maxValue = maxValue;
        self.accuracy = accuracy;
        [self setupUI];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    CGFloat startPoint = self.rulerMargin;
    for (int i = 0; i <= (self.maxValue - self.minValue) / self.accuracy; i++) {
        CALayer *subLayer = [CALayer layer];
        startPoint = i * self.rulerSpacing + self.rulerMargin;
        CGFloat endPoint = 0;
        if (i % 10 == 0) {
            endPoint = self.longLineDistance;
            NSInteger temp = (int)(i * self.accuracy);
            UILabel *label = [[UILabel alloc] init];
            label.text = [NSString stringWithFormat:@"%@", @(self.minValue + temp)];
            label.font = self.rulerFont;
            label.textColor = self.rulerLineColor;
            [label sizeToFit];
            CGRect rect = label.frame;
            rect.origin.x = startPoint - rect.size.width/2;
            rect.origin.y = self.longLineDistance + self.shortLineDistance;
            label.frame = rect;
            [self addSubview:label];
            
        }
        else if (i % 5 == 0) {
            endPoint = (self.longLineDistance + self.shortLineDistance) / 2.0;
        }
        else {
            endPoint = self.shortLineDistance;
        }
        subLayer.frame = CGRectMake(startPoint, 0, 1, endPoint);
        subLayer.backgroundColor = self.rulerLineColor.CGColor;
        [self.layer addSublayer:subLayer];
    }
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(self.rulerMargin, 0, startPoint - self.rulerMargin, 1);
    layer.backgroundColor = self.rulerLineColor.CGColor;
    [self.layer addSublayer:layer];
}

@end


@interface LXMRulerMarkView : UIView;

@property (nonatomic, strong) UIColor *markColor;
@property (nonatomic, strong) CAShapeLayer *markLayer;


@end

@implementation LXMRulerMarkView

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

- (void)setupUI {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height=  CGRectGetHeight(self.bounds);
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(width / 2.0, height)];
    [path closePath];
    layer.path = path.CGPath;
    self.markLayer = layer;
    [self.layer addSublayer:layer];
}

- (void)setMarkColor:(UIColor *)markColor {
    _markColor = markColor;
    self.markLayer.fillColor = markColor.CGColor;
    self.markLayer.borderColor = markColor.CGColor;
}

@end













@interface LXMRulerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LXMRulerValueView *valueView;
@property (nonatomic, strong) LXMRulerMarkView *markView;

@property (nonatomic, assign, readwrite) CGFloat currentValue;

@end

@implementation LXMRulerView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupDefault];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //使valueView的大小跟随self变化，因为其是scrollview的contentView，没法用autoLayout
    CGRect frame = self.valueView.frame;
    frame.size.height = CGRectGetHeight(self.bounds);
    self.valueView.frame = frame;
    
    [self updateScrollViewContentInset];
    [self reloadData];
}

- (void)setupDefault {
    self.rulerBackgroundColor = OJAColorFromHex(0xf9f9f9);
    self.rulerLineColor = OJAColorFromHex(0xc7c7c7);
    self.rulerFont = [UIFont systemFontOfSize:18];
    self.rulerMargin = 15;
    self.rulerSpacing = 10;
    self.longLineDistance = 24;
    self.shortLineDistance = 12;
    self.minValue = 0;
    self.maxValue = 100;
    self.limitToInteger = YES;
    self.accuracy = 1;
    
    self.showMarkView = YES;
    self.markViewColor = OJAColorFromHex(0xea5151);
    self.markViewSize = CGSizeMake(16, 8);
    self.currentValue = 0;
    
    self.backgroundColor = self.rulerBackgroundColor;
    [self addSubview:self.scrollView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
}

- (void)updateScrollViewContentInset {
    if (self.showMarkView == YES) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, floor(CGRectGetWidth(self.bounds) / 2) - self.rulerMargin, 0, floor(CGRectGetWidth(self.bounds) / 2) - self.rulerMargin);//这里如果出现小数貌似会不准，所以特殊处理一下
    } else {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.showMarkView == NO) {
        return;
    }
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentValue = (offsetX + scrollView.contentInset.left) / self.rulerSpacing * self.accuracy + self.minValue;
    if (self.valueChangeCallback) {
        self.valueChangeCallback(self.currentValue);
    }
}

/**
 *  这个方法可以让scrollview刚好停留在整数位置！！！牛逼完了~~
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.limitToInteger == YES) {
        CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
        CGFloat offsetX = originalTargetContentOffset.x;
        CGFloat result = round((offsetX + scrollView.contentInset.left) / self.rulerSpacing) * self.rulerSpacing;
        
        *targetContentOffset = CGPointMake(result - scrollView.contentInset.left, originalTargetContentOffset.y);
        
    }
}

#pragma mark - Property

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (CGFloat)rulerMargin {
    if (self.showMarkView == YES) {
        return 0;
    } else {
        return _rulerMargin;
    }
}

#pragma mark - PublicMethod

- (void)reloadData {
    NSAssert(self.maxValue > self.minValue, @"max should be greater than min");
    for (UIView *subView in self.scrollView.subviews) {
        [subView removeFromSuperview];
    }
    [self.markView removeFromSuperview];
    self.backgroundColor = self.rulerBackgroundColor;
    
    CGFloat totalWidth = self.rulerSpacing * (self.maxValue - self.minValue) / self.accuracy + self.rulerMargin * 2;
    CGFloat height = 0;//CGRectGetHeight(self.bounds);
    self.scrollView.contentSize = CGSizeMake(totalWidth, 0);
    
    self.scrollView.delegate = self;
    LXMRulerValueView *valueView = [[LXMRulerValueView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, height)rulerLineColor:self.rulerLineColor rulerFont:self.rulerFont rulerMargin:self.rulerMargin rulerSpacing:self.rulerSpacing longLineDistance:self.longLineDistance shortLineDistance:self.shortLineDistance minValue:self.minValue maxValue:self.maxValue accuracy:self.accuracy];
//    valueView.contentMode = UIViewContentModeRedraw;//使ValueView的bounds变化时，重新调用drawRect方法
    valueView.backgroundColor = self.rulerBackgroundColor;
    [self.scrollView addSubview:valueView];
    
    self.valueView = valueView;
    
    if (self.showMarkView) {
        self.markView = [[LXMRulerMarkView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2 - self.markViewSize.width / 2, 0, self.markViewSize.width, self.markViewSize.height)];
        self.markView.translatesAutoresizingMaskIntoConstraints = NO;
        self.markView.markColor = self.markViewColor;
        self.markView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.markView];
        [self.markView addConstraint:[NSLayoutConstraint constraintWithItem:self.markView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.markViewSize.width]];
        [self.markView addConstraint:[NSLayoutConstraint constraintWithItem:self.markView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.markViewSize.height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.markView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.markView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

    }
    
    [self updateCurrentValue:self.currentValue];
}

- (void)updateCurrentValue:(CGFloat)value {
    if (self.showMarkView == NO) {
        return;
    }
    self.currentValue = value;
    CGFloat offsetX = (self.currentValue - self.minValue) * self.rulerSpacing / self.accuracy - self.scrollView.contentInset.left;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0)];
}

@end
