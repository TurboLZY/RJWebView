//
//  JsFrameworkTool.m
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import "JsFrameworkTool.h"

@implementation JsFrameworkTool
//根据view获取持有的controller
+ (UIViewController <JsCoadjutantDelegate>*)getViewControllerWithView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]] && [nextResponder conformsToProtocol:@protocol(JsCoadjutantDelegate)]) {
            return (UIViewController <JsCoadjutantDelegate>*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 图片相关
// 图片转 base64
+ (NSString *)imageToNSString:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

// 图片转 base64
+ (UIImage *)stringToUIImage:(NSString *)string {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string
                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

// 压缩图片
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToWidth:(float)i_width {
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 转译相关
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
