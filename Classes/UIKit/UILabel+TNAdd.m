//
//  UILabel+TNAdd.m
//  AFNetworking
//
//  Created by Tony on 2019/12/7.
//

#import "UILabel+TNAdd.h"


@implementation UILabel (TNAdd)

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]init];
    if(text)label.text = text;
    if(textColor)label.textColor = textColor;
    if(font)label.font = font;
    return label;
}

@end
