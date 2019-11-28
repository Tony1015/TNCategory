//
//  NSString+TNAdd.m
//  BaseProject
//
//  Created by Tony on 2017/8/14.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "NSString+TNAdd.h"

@implementation NSString (TNAdd)

- (NSString *)tn_stringWithScale:(int)scale{
    NSString *str = self;
    NSArray *array = [str componentsSeparatedByString:@"."];
    if(array.count<2 || [array[1] length]<scale){
        NSString *formatStr = [NSString stringWithFormat:@"%%0.%df",scale];
        str = [NSString stringWithFormat:formatStr,str.doubleValue];
        
    }else{
        str = [str substringToIndex:str.length - ([array[1] length]-scale)];
    }
    return str;
}



-(NSString*)tn_reviseString{
    //直接传入精度丢失有问题的Double类型
//    if ([self tn_isPureFloat]) {
//        NSDecimalNumber *currentStr = [NSDecimalNumber decimalNumberWithString:self];
//        currentStr = [currentStr decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
//
//        NSString*doubleString = [NSString stringWithFormat:@"%lf", currentStr.doubleValue];
//
//        NSDecimalNumber*decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
//
//        decNumber=[decNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
//
//        return [decNumber stringValue];
//
//    }
//    double conversionValue = [self doubleValue];
//    NSString*doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
//    if ([self containsString:@"e"]) {
        NSDecimalNumber*decNumber = [NSDecimalNumber decimalNumberWithString:self];
        return [decNumber stringValue];
//    }
    
//    NSDecimalNumber*decNumber = [NSDecimalNumber decimalNumberWithString:self];
    //[NSString stringWithFormat:@"%0.4lf",[self doubleValue]];//;
    
}

- (NSString *)tn_truncateByCharLength:(NSUInteger)charLength
{
    __block NSUInteger length = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              
                              if ( length+substringRange.length > charLength )
                              {
                                  *stop = YES;
                                  return;
                              }
                              
                              length+=substringRange.length;
                          }];
    
    return [self substringToIndex:length];
}

+ (BOOL)tn_isEmptyString:(NSString *)string{
    if (!string) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    return NO;
}

- (CGSize)tn_calculateSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}




- (BOOL)tn_verifyPriceNumber{
    if (self.length==0) {
        return YES;
    }
    NSPredicate *floatPrediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+[.][0-9]{0,2}"];
    NSPredicate *integerPrediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+"];
    if (![floatPrediate evaluateWithObject:self]&&![integerPrediate evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}

- (BOOL)tn_verifyIdentityCardNumber{
    if (self.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

- (BOOL)tn_verifyBankNumber{
    NSString *telRegex = @"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self];
}

- (BOOL)tn_verifyPhoneNumber{
    //手机号码的正则表达式:
    if (self.length != 11) return NO;
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (BOOL)tn_isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)tn_isPureUInt{
    if (self == nil || [self length] <= 0)
    {
        return NO;
    }
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]+$"];
    return [test evaluateWithObject:self];
}

//浮点形判断：
- (BOOL)tn_isPureFloat{
    if (self == nil || [self length] <= 0)
    {
        return NO;
    }
    NSString *floatRegex = @"^\\-?[0-9]+(?:\\.[0-9]*)?$";
    NSPredicate *floatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", floatRegex];
    return [floatTest evaluateWithObject:self];
}

- (BOOL)tn_isPureUFloat{
    if (self == nil || [self length] <= 0)
    {
        return NO;
    }
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]+(?:\\.[0-9]*)?$"];
    return [test evaluateWithObject:self];
}


////查看是否为两种组合
//- (BOOL)tn_verifyPsw{
//    if (self == nil || [self length] <= 0)
//    {
//        return NO;
//    }
//    NSPredicate *pswTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![A-Z]+$)(?![a-z]+$)(?!\\d+$)\\S+$"];
//    return [pswTest evaluateWithObject:self];
//}
//查看是否包含数字和字母
- (BOOL)tn_verifyPsw{
    if (self == nil || [self length] <= 0)
    {
        return NO;
    }
//    NSPredicate *pswTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![A-Z]+$)(?![a-z]+$)(?!\\d+$)\\S+$"];
    
    BOOL a = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*[0-9]+.*"] evaluateWithObject:self];
    
    BOOL check = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*[A-Za-z]+.*"] evaluateWithObject:self];
    
    
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*[0-9]+.*"] evaluateWithObject:self]) {
        return NO;
    }else{
        return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*[A-Za-z]+.*"] evaluateWithObject:self];
    }
}

//邮箱
- (BOOL)tn_verifyEmailAddress{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}



//URL code
- (NSString *)tn_URLDecode
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)tn_URLEncode
{
    return [self tn_urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)tn_urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end
