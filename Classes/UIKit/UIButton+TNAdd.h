//
//  UIButton+TNAdd.h
//  AFNetworking
//
//  Created by Tony on 2019/11/29.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TNAdd)

- (void)clickedBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
