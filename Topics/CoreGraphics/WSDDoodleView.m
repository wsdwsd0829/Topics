//
//  WSDDoodleView.m
//  Topics
//
//  Created by Max Wang on 10/18/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "WSDDoodleView.h"

@implementation WSDDoodleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    CGContextRef ref = UIGraphicsGetCurrentContext();
    [[self class] drawSth];
//  CGContextRelease(ref);
}

+ (void)drawSth {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor redColor] setFill];
    [path fill];
    path.lineWidth = 2;
}

+ (UIImage *)drawnImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, [UIScreen mainScreen].scale);
    [[self class] drawSth];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



@end
