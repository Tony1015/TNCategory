//
//  NSString+TNAdd.h
//  BaseProject
//
//  Created by Tony on 2017/8/14.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TNAdd)

//返回小数点后scale 的数值字符串， 没有的补0
- (NSString *)tn_stringWithScale:(int)scale;


-(NSString*)tn_reviseString;

/**
 截取长度
 */
- (NSString *)tn_truncateByCharLength:(NSUInteger)charLength;

/**
 判断空字符串
 */
+ (BOOL)tn_isEmptyString:(NSString *)string;

/**
 计算字符串的尺寸大小
 */
- (CGSize)tn_calculateSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;




/**
 判断是否是有效金额（最小0.01）注意：@""也返回Yes
 */
- (BOOL)tn_verifyPriceNumber;
/**
 判断是否是有效的身份证号
 */
- (BOOL)tn_verifyIdentityCardNumber;
/**
 判断是否是有效的银行卡号
 */
- (BOOL)tn_verifyBankNumber;
/**
 判断是否是正确的手机号
 */
- (BOOL)tn_verifyPhoneNumber;


/**
 是否是 整形
 */
- (BOOL)tn_isPureInt;

/**
 是否是无符号整形
 */
- (BOOL)tn_isPureUInt;

/**
 是否是浮点型
 */
- (BOOL)tn_isPureFloat;
/**
 是否是无符号浮点型
 */
- (BOOL)tn_isPureUFloat;


/**
 是否是邮箱
 */
- (BOOL)tn_verifyEmailAddress;

//查看是否为两种组合
- (BOOL)tn_verifyPsw;

/**
 URL code
 */
- (NSString *)tn_URLDecode;
- (NSString *)tn_URLEncode;
- (NSString *)tn_urlEncodeUsingEncoding:(NSStringEncoding)encoding;



@end

