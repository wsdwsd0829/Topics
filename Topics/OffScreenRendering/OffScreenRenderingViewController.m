//
//  OffScreenRenderingViewController.m
//  Topics
//
//  Created by Max Wang on 10/29/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "OffScreenRenderingViewController.h"

@interface OffScreenRenderingViewController ()

@end

@implementation OffScreenRenderingViewController

//https://medium.com/@ninja31312/what-is-offscreen-rendering-636df95225be
- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  UIImage *img = [UIImage imageNamed:@"dog.jpg"];
  UIImageView *imgView = [[UIImageView alloc] initWithImage:img];

  UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 800)];
  subview.backgroundColor = [UIColor grayColor];
  // Option1
  // Should have to framebuffer.
  // Draw in RenderServer
  imgView.layer.masksToBounds = YES;
  imgView.layer.cornerRadius = 100;


  // Option2 ???
  // Draw in our code.
  UIGraphicsBeginImageContextWithOptions(img.size, NO, UIScreen.mainScreen.scale);
  CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:img.size.width/2];
  [path addClip];
  [img drawInRect:rect];
  UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  UIImageView *imgView2 = [[UIImageView alloc] initWithImage:result];

  // Option 3 Wedge.

  imgView.frame = CGRectMake(100, 100, 200, 200);
  imgView2.frame = CGRectMake(100, 350, 200, 200);
  [self.view addSubview:subview];
  [subview addSubview:imgView];
  [subview addSubview:imgView2];
}

@end
