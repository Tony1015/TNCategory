//
//  UIView+TNAdd.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TNAdd)


#pragma mark - UIView + Frame
@property (nonatomic, assign) CGFloat tn_x;
@property (nonatomic, assign) CGFloat tn_y;
@property (nonatomic, assign) CGFloat tn_width;
@property (nonatomic, assign) CGFloat tn_height;

@property (nonatomic, assign) CGFloat tn_left;
@property (nonatomic, assign) CGFloat tn_right;
@property (nonatomic, assign) CGFloat tn_top;
@property (nonatomic, assign) CGFloat tn_bottom;

@property (nonatomic, assign) CGSize tn_size;

@property (nonatomic,assign) CGPoint tn_origin;

@property(nonatomic,assign) CGFloat tn_centerX;

@property(nonatomic,assign)CGFloat tn_centerY;

@property (nonatomic,assign) CGPoint tn_boundsCenter;


- (UIViewController *)tn_getViewController;

- (void)tn_setGradientBackgroundWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 截图
 */
- (UIImage*)tn_screenshot;

// 判断View是否显示在屏幕上
- (BOOL)tn_isDisplayedInScreen;

+ (instancetype)tn_getViewFromNib;

- (void)tn_removeAllSubviews;

//- (void)tn_showBottomLine:(BOOL)show withTintColor:(UIColor *)tintColor;
//
//- (void)tn_showBottomLine:(BOOL)show;

@end
