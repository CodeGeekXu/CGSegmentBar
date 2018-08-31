//
//  CGSegmentBar.h
//  CGSegmentBar
//
//  Created by CodeGeekXu on 2018/8/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGSegmentBarWidthStyle) {
    CGSegmentBarWidthStyleFixed,    // Segment width is fixed
    CGSegmentBarWidthStyleDynamic,  // Segment width will only be as big as the text width (including inset)
};

typedef void(^CGSegmentBarDidSelectItem)(NSUInteger index);

@interface CGSegmentBar : UIView

    @property (nonatomic, strong) NSDictionary *textAttributes; // nomal title attributes
@property (nonatomic, strong) NSDictionary *selectedTextAttributes; // selected title attributes

@property (nonatomic, strong) UIColor      *indicatorColor;
@property (nonatomic, assign) CGFloat      indicatorHeight;
@property (nonatomic, assign) BOOL         indicatorHidden;

@property (nonatomic, assign) UIEdgeInsets                paddingInsets;   // content padding
@property (nonatomic, assign) CGFloat                     interitemSpacing;// title interitem
@property (nonatomic, assign) CGSegmentBarWidthStyle      widthStyle;

@property (nonatomic, strong) NSArray<NSString *>    *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) CGSegmentBarDidSelectItem didSelectItemBlock;

- (void)reload;

@end
