//
//  BCBFloatButton.h
//  BCB
//
//  Created by liuhx on 2018/6/22.
//  Copyright © 2018 baicaibang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCBFloatButtonDelegate
- (void)onClickHome;
- (void)onClickRefresh;
@end

@interface BCBFloatButton : UIView

@property (nonatomic, weak) id<BCBFloatButtonDelegate> delegate;

@end
