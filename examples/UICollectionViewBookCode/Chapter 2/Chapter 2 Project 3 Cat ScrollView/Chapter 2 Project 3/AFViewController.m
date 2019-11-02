//
//  AFViewController.m
//  Chapter 2 Project 3
//
//  Created by Ash Furrow on 2012-12-16.
//  Copyright (c) 2012 Ash Furrow. All rights reserved.
//

#import "AFViewController.h"

@interface AFViewController ()

@end

@implementation AFViewController {
  UIScrollView *_scrollView;
  UIImage *_image;
  UIImageView *_imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _image = [UIImage imageNamed:@"cat.jpg"];
    
    _imageView = [[UIImageView alloc] initWithImage:_image];
    _imageView.frame = CGRectMake(0, 0, _image.size.width, _image.size.height);
}

- (void)viewDidLayoutSubviews {
      _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
      _scrollView.contentSize = _image.size;
  //    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  //  imageView.translatesAutoresizingMaskIntoConstraints = NO;
      [_scrollView addSubview:_imageView];

      [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
