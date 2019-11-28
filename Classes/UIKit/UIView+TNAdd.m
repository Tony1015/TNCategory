//
//  UIView+TNAdd.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "UIView+TNAdd.h"

//#define BottomLineView "BottomLineView"



@implementation UIView (TNAdd)

#pragma mark - UIView + Frame
- (void)setTn_x:(CGFloat)tn_x{
    CGRect frame = self.frame;
    frame.origin.x = tn_x;
    self.frame = frame;
}

- (CGFloat)tn_x{
    return self.frame.origin.x;
}

- (void)setTn_y:(CGFloat)tn_y{
    CGRect frame = self.frame;
    frame.origin.y = tn_y;
    self.frame = frame;
}

- (CGFloat)tn_y{
    return self.frame.origin.y;
}

- (void)setTn_width:(CGFloat)tn_width{
    CGRect frame = self.frame;
    frame.size.width = tn_width;
    self.frame = frame;
}

- (CGFloat)tn_width{
    return self.frame.size.width;
}

- (void)setTn_height:(CGFloat)tn_height{
    CGRect frame = self.frame;
    frame.size.height = tn_height;
    self.frame = frame;
}

- (CGFloat)tn_height{
    return self.frame.size.height;
}


- (void)setTn_left:(CGFloat)tn_left{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(tn_left,r.origin.y, r.size.width, r.size.height)];
}

- (CGFloat)tn_left{
    return self.frame.origin.x;
}

- (void)setTn_right:(CGFloat)tn_right{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(tn_right-r.size.width,r.origin.y, r.size.width, r.size.height)];
}

- (CGFloat)tn_right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTn_top:(CGFloat)tn_top{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, tn_top, r.size.width, r.size.height)];
}

- (CGFloat)tn_top{
    return self.frame.origin.y;
}

- (void)setTn_bottom:(CGFloat)tn_bottom{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, tn_bottom-r.size.height, r.size.width, r.size.height)];
}

- (CGFloat)tn_bottom{
    return self.frame.origin.y + self.frame.size.height;
}



- (void)setTn_size:(CGSize)tn_size{
    CGRect frame = self.frame;
    frame.size = tn_size;
    self.frame =frame;
}
- (CGSize)tn_size{
    return self.frame.size;
}

- (void)setTn_origin:(CGPoint)tn_origin{
    CGRect frame = self.frame;
    frame.origin = tn_origin;
    self.frame = frame;
}

- (CGPoint)tn_origin{
    return self.frame.origin;
}

-(void)setTn_centerX:(CGFloat)tn_centerX{
    CGPoint center = self.center;
    
    center.x = tn_centerX;
    
    self.center = center;
}
-(CGFloat)tn_centerX{
    return self.center.x;
    
}

-(void)setTn_centerY:(CGFloat)tn_centerY{
    CGPoint center = self.center;
    center.y = tn_centerY;
    self.center = center;
}
-(CGFloat)tn_centerY{
    return self.center.y;
    
}

- (CGPoint)tn_boundsCenter{
    return CGPointMake(self.tn_width*0.5, self.tn_height*0.5);
}

- (void)setTn_boundsCenter:(CGPoint)tn_boundsCenter{
}



- (UIViewController *)tn_getViewController{
    UIResponder *target = self;
    while (target) {
        target = target.nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return (UIViewController *)target;
}



- (UIImage*)tn_screenshot{
    UIGraphicsBeginImageContext(self.bounds.size);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)] ){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // hack, helps w/ our colors when blurring
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    return image;
}

// 判断View是否显示在屏幕上
- (BOOL)tn_isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}


+(instancetype)tn_getViewFromNib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)tn_setGradientBackgroundWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    CAGradientLayer *layer = [[CAGradientLayer alloc]init];
    layer.frame = self.bounds;
    layer.colors = colorsM.copy;
    layer.locations = locations;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    
    [self.layer addSublayer:layer];
}

- (void)tn_removeAllSubviews{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}


//- (UIView *)bottomLineView{
//    UIView *view = objc_getAssociatedObject(self, BottomLineView);
//    if (!view) {
//        view = [[UIView alloc]init];
//        [self addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.right.equalTo(self);
//            make.height.mas_equalTo(0.5);
//        }];
//        self.bottomLineView = view;
//    }
//    return view;
//}
//
//- (void)setBottomLineView:(UIView *)bottomLineView{
//    objc_setAssociatedObject(self, BottomLineView, bottomLineView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (void)tn_showBottomLine:(BOOL)show withTintColor:(UIColor *)tintColor{
//    self.bottomLineView.hidden = !show;
//    self.bottomLineView.backgroundColor = tintColor;
//}
//
//- (void)tn_showBottomLine:(BOOL)show{
//    [self tn_showBottomLine:show withTintColor:tnLineDefaultColor];
//}





@end
