//
//  CGSegmentBar.m
//  CGSegmentBar
//
//  Created by 徐晨光 on 2018/8/31.
//

#import "CGSegmentBar.h"

#define TAG_TITLE 100
static NSString *const cellIdentfire = @"cellIdentfire";


@interface CGSegmentBar ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *seperatorLineView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation CGSegmentBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSetupStyle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetupStyle];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initSetupStyle];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    if (self.scrollDiretion == CGSegmentBarScrollDirectionHorizontal) {
        self.seperatorLineView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.bounds), 1);
    }else{
        self.seperatorLineView.frame = CGRectMake(0, CGRectGetWidth(self.bounds)-1, 1, CGRectGetHeight(self.bounds));
    }
}


#pragma mark - public method

- (void)reload
{
    [self.collectionView reloadData];
}

#pragma mark - private method

- (void)initSetupStyle
{
    self.indicatorColor = [UIColor blueColor];
    self.indicatorHeight = 2;
    self.widthStyle = CGSegmentBarWidthStyleFixed;
    self.paddingInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.interitemSpacing = 10;
    self.scrollDiretion = CGSegmentBarScrollDirectionHorizontal;
    
    [self.collectionView registerClass:UICollectionViewCell.class  forCellWithReuseIdentifier:cellIdentfire];
    [self addSubview:self.collectionView];
    
    [self addSubview:self.seperatorLineView];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self scrollItemToIndexPath:indexPath];
    
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(indexPath.item);
    }
    
    self.selectedIndexPath = indexPath;
    [self.collectionView reloadData];
}

- (void)scrollItemToIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewScrollPosition scrollPosition = UICollectionViewScrollPositionCenteredHorizontally;
    if (self.scrollDiretion == CGSegmentBarScrollDirectionVertical) {
        scrollPosition = UICollectionViewScrollPositionCenteredVertically;
    }else{
        scrollPosition = UICollectionViewScrollPositionCenteredHorizontally;
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:scrollPosition
                                        animated:YES];
}

#pragma mark - UICollectionView代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (self.widthStyle == CGSegmentBarWidthStyleFixed) ? 0 : self.interitemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.paddingInsets;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = 0;
    CGFloat height = CGRectGetHeight(collectionView.bounds)-self.paddingInsets.top-self.paddingInsets.bottom;
    
    if (self.widthStyle == CGSegmentBarWidthStyleFixed) {
        width =  (CGRectGetWidth(collectionView.bounds)-self.paddingInsets.left-self.paddingInsets.right)/self.titles.count;
    }else{
        NSString *text = self.titles[indexPath.item];
        NSDictionary *attibutes;
        if (self.selectedIndexPath.item == indexPath.item) {
            attibutes = self.selectedTextAttributes;
        }else{
            attibutes = self.textAttributes;
        }
        
        CGFloat textWidth = [text boundingRectWithSize:CGSizeMake(MAXFLOAT,0)
                                               options:NSStringDrawingTruncatesLastVisibleLine
                                            attributes:attibutes
                                               context:nil].size.width;
        width = textWidth;
    }
   
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentfire
                                                                           forIndexPath:indexPath];
 
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
    if (!titleLabel) {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        titleLabel.tag = TAG_TITLE;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel];
    }
    titleLabel.frame = cell.contentView.bounds;
    
    NSString *title = self.titles[indexPath.item];
    NSDictionary *attibutes = (self.selectedIndexPath.item == indexPath.item) ? self.selectedTextAttributes : self.textAttributes;
    NSAttributedString *attbutedText = [[NSAttributedString alloc]initWithString:title attributes:attibutes];
    titleLabel.attributedText = attbutedText;
    
    cell.contentView.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    [self didSelectItemAtIndexPath:indexPath];
}

#pragma mark - setter

- (void)setScrollDiretion:(CGSegmentBarScrollDirection)scrollDiretion
{
    _scrollDiretion = scrollDiretion;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.scrollDirection = (CGSegmentBarScrollDirectionVertical == scrollDiretion) ? UICollectionViewScrollDirectionVertical : UICollectionViewScrollDirectionHorizontal;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
}

#pragma mark - getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    
    return _collectionView;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _indicatorView;
}

- (UIView *)seperatorLineView
{
    if (!_seperatorLineView) {
        _seperatorLineView = [UIView new];
        _seperatorLineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    }
    return _seperatorLineView;
}

- (NSDictionary *)textAttributes
{
    if (!_textAttributes) {
        NSMutableDictionary *textAttributes = [NSMutableDictionary new];
        [textAttributes setObject:[UIFont systemFontOfSize:15]
                           forKey:NSFontAttributeName];
        [textAttributes setObject:[UIColor blackColor]
                           forKey:NSForegroundColorAttributeName];
        
        _textAttributes = textAttributes;
    }
    return _textAttributes;
}

- (NSDictionary *)selectedTextAttributes
{
    if (!_selectedTextAttributes) {
        NSMutableDictionary *textAttributes = [NSMutableDictionary new];
        [textAttributes setObject:[UIFont systemFontOfSize:17]
                           forKey:NSFontAttributeName];
        [textAttributes setObject:[UIColor blueColor]
                           forKey:NSForegroundColorAttributeName];
        
        _selectedTextAttributes = textAttributes;
    }
    return _selectedTextAttributes;
}

- (NSIndexPath *)selectedIndexPath
{
    if (!_selectedIndexPath) {
        _selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    return _selectedIndexPath;
}

@end
