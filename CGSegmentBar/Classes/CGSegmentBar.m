//
//  CGSegmentBar.m
//  CGSegmentBar
//
//  Created by CodeGeekXu on 2018/8/31.
//

#import "CGSegmentBar.h"

#define TAG_TITLE 100
#define kIndicatorWidth 30

static NSString *const cellIdentfire = @"cellIdentfire";


@interface CGSegmentBar ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *seperatorLineView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation CGSegmentBar

#pragma mark - system methods
    
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
    [self placeSubViews];
}

#pragma mark - public methods

- (void)reload
{
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollIndicatorToIndexPath:self.selectedIndexPath
                                animated:NO];
    });
}

#pragma mark - private methods

- (void)initSetupStyle
{
    self.indicatorColor = [UIColor blueColor];
    self.indicatorHeight = 2;
    self.widthStyle = CGSegmentBarWidthStyleFixed;
    self.paddingInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.interitemSpacing = 10;
    
    [self.collectionView registerClass:UICollectionViewCell.class  forCellWithReuseIdentifier:cellIdentfire];
    [self addSubview:self.collectionView];
    
    [self.collectionView addSubview:self.indicatorView];
    [self.collectionView bringSubviewToFront:self.indicatorView];
    
    [self addSubview:self.seperatorLineView];
}

- (void)placeSubViews
{
    self.collectionView.frame = self.bounds;
    self.seperatorLineView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.bounds), 1);
}

- (void)scrollIndicatorToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGPoint moveToCenter = CGPointMake(attributes.center.x, CGRectGetHeight(self.bounds) - self.indicatorHeight/2);;
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.indicatorView.center = moveToCenter;
        }];
    }else{
        self.indicatorView.center = moveToCenter;
    }
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self.collectionView reloadData];
    
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(indexPath.item);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollItemToIndexPath:indexPath];
        [self scrollIndicatorToIndexPath:indexPath animated:YES];
    });
}

- (void)scrollItemToIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewScrollPosition scrollPosition = UICollectionViewScrollPositionCenteredHorizontally;
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:scrollPosition
                                        animated:YES];
}

#pragma mark - UICollectionView

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
        
        CGFloat textWidth = [text sizeWithAttributes:attibutes].width;
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
    
    NSString *title = self.titles[indexPath.item];
    NSDictionary *attibutes = (self.selectedIndexPath.item == indexPath.item) ? self.selectedTextAttributes : self.textAttributes;
    NSAttributedString *attbutedText = [[NSAttributedString alloc]initWithString:title attributes:attibutes];
    titleLabel.attributedText = attbutedText;
    
    if(self.widthStyle == CGSegmentBarWidthStyleFixed){
        titleLabel.frame = cell.contentView.bounds;
    }else{
        titleLabel.frame = CGRectMake(0, 0, [title sizeWithAttributes:attibutes].width, CGRectGetHeight(cell.contentView.bounds));
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    [self didSelectItemAtIndexPath:indexPath];
}

#pragma mark - setter

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
}

- (void)setIndicatorHidden:(BOOL)indicatorHidden
{
    _indicatorHidden = indicatorHidden;
    self.indicatorView.hidden = indicatorHidden;
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight
{
    _indicatorHeight = indicatorHeight;
    
    CGRect frame = self.indicatorView.frame;
    frame.size.height = indicatorHeight;
    self.indicatorView.frame = frame;
}
    
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
                      
    [self didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0]];
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
        _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kIndicatorWidth, self.indicatorHeight)];
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
