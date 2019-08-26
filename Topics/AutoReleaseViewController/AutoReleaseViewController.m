//
//  AutoReleaseViewController.m
//  Topics
//
//  Created by Max Wang on 5/19/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "AutoReleaseViewController.h"

@interface AutoReleaseViewController ()

@end

@implementation AutoReleaseViewController

- (NSString *)hello {
  return @"hello";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  // according to https://www.mikeash.com/pyblog/friday-qa-2011-09-30-automatic-reference-counting.html
  // __bridge will make string to be released immediately before it's assigned to CFStringRef.
  CFStringRef hello = (__bridge_retained  CFStringRef)[self hello];
  printf("Printing few things = %s\n",CFStringGetCStringPtr(hello, kCFStringEncodingMacRoman));
  CFRelease(hello);
}

- (void)useHello:(CFStringRef)hello {
  printf("Printing few things = %s\n",CFStringGetCStringPtr(hello, kCFStringEncodingMacRoman));
}

@end
