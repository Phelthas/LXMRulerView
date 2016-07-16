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

@end

@implementation LXMRulerValueView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.rulerLineColor set];
    CGFloat startPoint = self.rulerMargin;
    for (int i = 0; i <= (self.maxValue - self.minValue); i++) {
        CGContextSetLineWidth(context, 1);
        startPoint = i * self.rulerSpacing + self.rulerMargin;
        CGFloat endPoint = 0;
        if (i % 5 == 0) {
            endPoint = self.longLineDistance;
            
            UILabel *label = [[UILabel alloc] init];
            label.text = [NSString stringWithFormat:@"%ld", self.minValue + i];
            label.font = self.rulerFont;
            label.textColor = self.rulerLineColor;
            [label sizeToFit];
            CGRect rect = label.frame;
            rect.origin.x = startPoint - rect.size.width/2;
            rect.origin.y = self.longLineDistance + self.shortLineDistance;
            label.frame = rect;
            [self addSubview:label];
            
        } else {
            endPoint = self.shortLineDistance;
        }
        CGContextMoveToPoint(context, startPoint, 0);
        CGContextAddLineToPoint(context, startPoint, endPoint);
        CGContextStrokePath(context);
    }
    CGContextMoveToPoint(context, self.rulerMargin, 0);
    CGContextAddLineToPoint(context, startPoint, 0);
    CGContextStrokePath(context);
}



@end


@interface LXMRulerMarkView : UIView;

@property (nonatomic, strong) UIColor *markColor;

@end

@implementation LXMRulerMarkView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.markColor set];
    CGContextSetLineWidth(context, 1);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height=  CGRectGetHeight(self.bounds);
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint centerPoint = CGPointMake(width / 2, height);
    CGPoint endPoint = CGPointMake(width, 0);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, self.markColor.CGColor);
    CGContextFillPath(context);
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
        
        self.showMarkView = YES;
        self.markViewColor = OJAColorFromHex(0xea5151);
        self.markViewSize = CGSizeMake(16, 8);
        self.currentValue = 0;
        
        self.backgroundColor = self.rulerBackgroundColor;
        [self addSubview:self.scrollView];
        [self reloadData];
    }
    return self;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.showMarkView == NO) {
        return;
    }
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentValue = (offsetX + scrollView.contentInset.left) / self.rulerSpacing + self.minValue;
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
        _scrollView.showsHorizontalScrollIndicator = NO;
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
    
    CGFloat totalWidth = self.rulerSpacing * (self.maxValue - self.minValue) + self.rulerMargin * 2;
    CGFloat height = CGRectGetHeight(self.bounds);
    self.scrollView.contentSize = CGSizeMake(totalWidth, height);
    if (self.showMarkView == YES) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds) / 2 - self.rulerMargin, 0, CGRectGetWidth(self.bounds) / 2 - self.rulerMargin);
    } else {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    self.scrollView.delegate = self;
    LXMRulerValueView *valueView = [[LXMRulerValueView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, height)];
    valueView.backgroundColor = self.rulerBackgroundColor;
    valueView.rulerLineColor = self.rulerLineColor;
    valueView.rulerFont = self.rulerFont;
    valueView.rulerMargin = self.rulerMargin;
    valueView.rulerSpacing = self.rulerSpacing;
    valueView.longLineDistance = self.longLineDistance;
    valueView.shortLineDistance = self.shortLineDistance;
    valueView.minValue = self.minValue;
    valueView.maxValue = self.maxValue;
    [self.scrollView addSubview:valueView];
    
    if (self.showMarkView) {
        self.markView = [[LXMRulerMarkView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2 - self.markViewSize.width / 2, 0, self.markViewSize.width, self.markViewSize.height)];
        self.markView.markColor = self.markViewColor;
        self.markView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.markView];
    }
    
    [self updateCurrentValue:self.currentValue];
}

- (void)updateCurrentValue:(CGFloat)value {
    if (self.showMarkView == NO) {
        return;
    }
    self.currentValue = value;
    CGFloat offsetX = (self.currentValue - self.minValue) * self.rulerSpacing - self.scrollView.contentInset.left;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0)];
}

@end
