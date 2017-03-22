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

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LXMRulerPickerView

#pragma mark - Property

- (LXMRulerStyle *)rulerStyle {
    if (!_rulerStyle) {
        _rulerStyle = [[LXMRulerStyle alloc] init];
    }
    return _rulerStyle;
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
    return CGSizeMake(self.rulerStyle.accuracy * 10 * self.rulerStyle.rulerSpacing, CGRectGetHeight(collectionView.bounds));
}

@end
