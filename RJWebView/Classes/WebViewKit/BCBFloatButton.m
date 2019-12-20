//
//  BCBFloatButton.m
//  BCB
//
//  Created by liuhx on 2018/6/22.
//  Copyright © 2018 baicaibang. All rights reserved.
//

#import "BCBFloatButton.h"

const int kMinDistance = 10;

@interface BCBFloatButton()

@property (nonatomic) CGPoint touchDownPointInParent;
@property (nonatomic) CGPoint touchDownPointInSelf;
@property (nonatomic) CGPoint touchDownLocation;
@property (nonatomic) NSTimeInterval touchDownTime;
@property (nonatomic) CGFloat minX;
@property (nonatomic) CGFloat maxX;
@property (nonatomic) CGFloat minY;
@property (nonatomic) CGFloat maxY;

@end

@implementation BCBFloatButton

- (instancetype)init {
    CGRect bounds = [ UIScreen mainScreen ].bounds;
    
    self = [super initWithFrame:CGRectMake(bounds.size.width - 60, bounds.size.height - 250, 50, 110)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_btn_background.png"]];
        imageView.frame = CGRectMake(0, 0, 50, 110);
        [self addSubview:imageView];
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go2home.png"]];
        imageView.frame = CGRectMake(0, 0, 50, 50);
        //[self addSubview:imageView];//隐藏返回首页按钮
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh.png"]];
        imageView.frame = CGRectMake(0, 60, 50, 50);
        //[self addSubview:imageView];//隐藏刷新按钮
        
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        self.minX = 10;
        self.maxX = bounds.size.width - 50 - 10;
        self.minY = 10 + statusBarHeight;
        self.maxY = bounds.size.height - 110 - 10 - statusBarHeight;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.touchDownPointInParent = [[touches anyObject] locationInView:self.superview];
    self.touchDownPointInSelf = [[touches anyObject] locationInView:self];
    self.touchDownLocation = self.frame.origin;
    self.touchDownTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    CGPoint current = [[touches anyObject] locationInView:self.superview];
    CGFloat x = self.touchDownLocation.x + current.x - self.touchDownPointInParent.x;
    CGFloat y = self.touchDownLocation.y + current.y - self.touchDownPointInParent.y;
    if (x < self.minX) x = self.minX;
    if (x > self.maxX) x = self.maxX;
    if (y < self.minY) y = self.minY;
    if (y > self.maxY) y = self.maxY;
    self.frame = CGRectMake(x, y, 50, 110);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    if (now - self.touchDownTime > 200) {
        return;
    }
    CGPoint currentLocationInParent = [[touches anyObject] locationInView:self.superview];
    CGRect bounds = [ UIScreen mainScreen ].bounds;
    CGRect frame = self.frame;
    if (frame.origin.x <= (bounds.size.width / 2 - frame.size.width / 2)) {
        frame.origin.x = self.minX;
    } else {
        frame.origin.x = self.maxX;
    }
    self.frame = frame;
    if (fabs(self.touchDownPointInParent.x - currentLocationInParent.x) > kMinDistance ||
        fabs(self.touchDownPointInParent.y - currentLocationInParent.y) > kMinDistance) {
        return;
    }
    if (self.touchDownPointInSelf.y <= self.bounds.size.height / 2) {
        [self.delegate onClickHome];
    } else {
        [self.delegate onClickRefresh];
    }
}

@end
