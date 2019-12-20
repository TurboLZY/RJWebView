//
//  JsFrameworkTool.h
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsHandler.h"
@interface JsFrameworkTool : NSObject
#pragma mark - UI相关
/**
 根据view获取遵循JsCoadjutantDelegate的UIViewController

 @param view 子view
 @return (UIViewController <JsCoadjutantDelegate>*)
 */
+ (UIViewController <JsCoadjutantDelegate>*)getViewControllerWithView:(UIView *)view;

#pragma mark - 图片相关
// 图片转 base64
+ (NSString *)imageToNSString:(UIImage *)image;
// 图片转 base64
+ (UIImage *)stringToUIImage:(NSString *)string;
// 压缩图片
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToWidth:(float)i_width;

#pragma mark - 转译相关
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
