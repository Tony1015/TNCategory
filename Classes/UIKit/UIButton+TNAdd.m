//
//  UIButton+TNAdd.m
//  AFNetworking
//
//  Created by Tony on 2019/11/29.
//

#import "UIButton+TNAdd.h"
#import <objc/runtime.h>

#define UIButtonBlockKey @"UIButtonBlockKey"

@implementation UIButton (TNAdd)


- (void)setClickBlock:(void(^)(void))block{
    objc_setAssociatedObject(self, UIButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void(^)(void))clickBlock{
    return objc_getAssociatedObject(self, UIButtonBlockKey);
}


- (void)clickedBlock:(void(^)(void))block{
    [self addTarget:self action:@selector(clickedBtn) forControlEvents:UIControlEventTouchUpInside];
}


- (void)clickedBtn{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
