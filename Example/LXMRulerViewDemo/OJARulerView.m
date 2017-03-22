//
//  OJARulerView.m
//  LXMRulerViewDemo
//
//  Created by luxiaoming on 2017/3/21.
//  Copyright © 2017年 luxiaoming. All rights reserved.
//

#import "OJARulerView.h"
#import "LXMRulerLeadingCell.h"
#import "LXMRulerNormalCell.h"
#import "LXMRulerTrailingCell.h"
#import "UICollectionReusableView+LXMTool.h"

#define OJAColorFromHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface OJARulerView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation OJARulerView

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
    [self.collectionView registerClass:[LXMRulerLeadingCell class] forCellWithReuseIdentifier:[LXMRulerLeadingCell lxm_reuseIdentifier]];
    [self.collectionView registerClass:[LXMRulerNormalCell class] forCellWithReuseIdentifier:[LXMRulerNormalCell lxm_reuseIdentifier]];
    [self.collectionView registerClass:[LXMRulerTrailingCell class] forCellWithReuseIdentifier:[LXMRulerTrailingCell lxm_reuseIdentifier]];
    
    [self addSubview:self.collectionView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        LXMRulerLeadingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXMRulerLeadingCell lxm_reuseIdentifier] forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    else if (indexPath.item == self.dataArray.count - 1) {
        LXMRulerTrailingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXMRulerTrailingCell lxm_reuseIdentifier] forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    else {
        LXMRulerNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXMRulerNormalCell lxm_reuseIdentifier] forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor orangeColor];
        return cell;
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return CGSizeMake(80, CGRectGetHeight(collectionView.bounds));
    }
    else if (indexPath.item == self.dataArray.count - 1) {
        return CGSizeMake(60, CGRectGetHeight(collectionView.bounds));
    }
    else {
        return CGSizeMake(100, CGRectGetHeight(collectionView.bounds));
    }
}

@end


