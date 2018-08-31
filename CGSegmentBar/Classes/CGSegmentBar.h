//
//  CGSegmentBar.h
//  CGSegmentBar
//
//  Created by 徐晨光 on 2018/8/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGSegmentBarWidthStyle) {
    CGSegmentBarWidthStyleFixed,    // Segment width is fixed
    CGSegmentBarWidthStyleDynamic,  // Segment width will only be as big as the text width (including inset)
};

typedef NS_ENUM(NSInteger, CGSegmentBarScrollDirection) {
    CGSegmentBarScrollDirectionVertical,
    CGSegmentBarScrollDirectionHorizontal
};

typedef void(^CGSegmentBarDidSelectItem)(NSUInteger index);

@interface CGSegmentBar : UIView

@property (nonatomic, strong) NSDictionary *textAttributes; //!< 标题设置
@property (nonatomic, strong) NSDictionary *selectedTextAttributes; //!< 选中标题设置

@property (nonatomic, strong) UIColor      *indicatorColor; //!< 选中指示条颜色.
@property (nonatomic, assign) CGFloat      indicatorHeight; //!< 选中指示条高度.
@property (nonatomic, assign) BOOL         indicatorHidden; //!< 选中指示条隐藏

@property (nonatomic, assign) UIEdgeInsets                paddingInsets;
@property (nonatomic, assign) CGFloat                     interitemSpacing;//间距
@property (nonatomic, assign) CGSegmentBarWidthStyle      widthStyle;
@property (nonatomic, assign) CGSegmentBarScrollDirection scrollDiretion;

@property (nonatomic, strong) NSArray<NSString *>    *titles; //!< 标题
@property (nonatomic, copy) CGSegmentBarDidSelectItem didSelectItemBlock;

- (void)reload;

@end
