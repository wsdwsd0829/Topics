//
//  HitTestView.m
//  Topics
//
//  Created by Max Wang on 8/26/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "HitTestView.h"

@implementation HitTestView

// ?? why call hitTest so many times.
// subviews:                      1, 2, 3, 4, 5
// hitTest call counts for tag2 : 2, 2, 4, 6, 8
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  if (self.tag == 1) {
    NSLog(@"hitTest 1");
  } else {
    NSLog(@"hitTest 2");
  }

  return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  if (self.tag == 1) {
    NSLog(@"pointInside 1");
  } else {
    NSLog(@"pointInside 2");
  }

  // This will make view with tag1 receive touch event though by default will from tag2.
  if (self.tag == 1 && (point.y < 200 && point.y > 0)) {
    return YES;  // full x axis will receive touch event for tag1.
  } else if (self.tag == 2 && (point.y < 100 && point.y > 0)) {
    return NO;
  } else if (self.tag == 2 && point.y > 100) {
    return YES; // all purple and it's below will receive touch for tag2
  }

  return [super pointInside:point withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  NSLog(@"Touches Ended On View with Tag %d", self.tag);
}

@end
