//
//  DefaultHandler.h
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsHandler.h"

@interface DefaultHandler : NSObject <JsHandler>

+ (instancetype)sharedInstance;

@end
