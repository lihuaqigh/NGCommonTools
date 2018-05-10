//
//  UIView+Extension.m
//  NGCommonTools
//
//  Created by lhq on 2018/5/10.
//  Copyright © 2018年 lhq. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(CGFloat)x {
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

-(CGFloat)y {
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

-(CGFloat)width {
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

-(CGFloat)height {
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

-(CGFloat)centerX {
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setTop:(CGFloat)t {
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)l {
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)b {
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (void)setRight:(CGFloat)r {
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

@end
