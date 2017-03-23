//
//  LXMRulerPickerView.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/22.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import "LXMRulerPickerView.h"
#import "UICollectionReusableView+LXMTool.h"
#import "LXMRulerPickerCell.h"


@interface LXMRulerPickerView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) CAShapeLayer *markLayer;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign, readwrite) CGFloat currentValue;//markView指示的值

@end

@implementation LXMRulerPickerView

#pragma mark - Property

- (LXMRulerStyle *)rulerStyle {
    if (!_rulerStyle) {
        _rulerStyle = [[LXMRulerStyle alloc] init];
    }
    return _rulerStyle;
}

- (CAShapeLayer *)markLayer {
    if (!_markLayer) {
        CGSize size = self.rulerStyle.markViewSize;
        _markLayer = [CAShapeLayer layer];
        _markLayer.frame = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointZero];
        [path addLineToPoint:CGPointMake(size.width, 0)];
        [path addLineToPoint:CGPointMake(size.width / 2.0, size.height)];
        [path closePath];
        _markLayer.path = path.CGPath;
        _markLayer.fillColor = self.rulerStyle.markViewColor.CGColor;
        _markLayer.borderColor = self.rulerStyle.markViewColor.CGColor;
    }
    return _markLayer;
}


#pragma mark - Lifecycle

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
}


#pragma mark - PrivateMethod

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = self.rulerStyle.rulerBackgroundColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceHorizontal = YES;
    [self.collectionView registerClass:[LXMRulerPickerCell class] forCellWithReuseIdentifier:[LXMRulerPickerCell lxm_reuseIdentifier]];
    
    
    [self addSubview:self.collectionView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, floor(CGRectGetWidth(self.bounds) / 2), 0, floor(CGRectGetWidth(self.bounds) / 2));//这里如果出现小数貌似会不准，所以特殊处理一下
    
    self.currentValue = self.rulerStyle.minValue;
    [self.layer addSublayer:self.markLayer];
    CGRect layerFrame = self.markLayer.frame;
    layerFrame.origin.x = CGRectGetWidth(self.bounds) / 2 - CGRectGetWidth(layerFrame) / 2;
    self.markLayer.frame = layerFrame;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.rulerStyle.maxValue - self.rulerStyle.minValue) / self.rulerStyle.accuracy / 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXMRulerPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXMRulerPickerCell lxm_reuseIdentifier] forIndexPath:indexPath];
    [cell updateUIWithRulerStyle:self.rulerStyle atIndexPath:indexPath];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.rulerStyle.rulerSpacing * 10, CGRectGetHeight(collectionView.bounds));
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentValue = (offsetX + scrollView.contentInset.left) / self.rulerStyle.rulerSpacing * self.rulerStyle.accuracy + self.rulerStyle.minValue;
    if (self.valueChangeCallback) {
        self.valueChangeCallback(self.currentValue);
    }
}

/**
 *  这个方法可以让scrollview刚好停留在整数位置！！！牛逼完了~~
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.rulerStyle.limitToAccuracy == YES) {
        CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
        CGFloat offsetX = originalTargetContentOffset.x;
        CGFloat result = round((offsetX + scrollView.contentInset.left) / self.rulerStyle.rulerSpacing) * self.rulerStyle.rulerSpacing;
        
        *targetContentOffset = CGPointMake(result - scrollView.contentInset.left, originalTargetContentOffset.y);
        
    }
}


#pragma mark - PublicMethod

- (void)reloadData {
    [self.collectionView reloadData];
}


- (void)updateCurrentValue:(CGFloat)value {
    self.currentValue = value;
    CGFloat offsetX = (self.currentValue - self.rulerStyle.minValue) * self.rulerStyle.rulerSpacing / self.rulerStyle.accuracy - self.collectionView.contentInset.left;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0)];
}

@end
