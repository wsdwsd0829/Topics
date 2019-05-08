//
//  BaseWindow.m
//  Topics
//
//  Created by Max Wang on 5/7/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "BaseWindow.h"

@implementation BaseWindow


- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  NSLog(@"Frame changed: %@", NSStringFromCGRect(frame));
}

@end
