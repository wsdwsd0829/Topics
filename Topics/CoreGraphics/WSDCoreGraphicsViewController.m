//
//  WSDCoreGraphicsViewController.m
//  Topics
//
//  Created by Max Wang on 10/18/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "WSDCoreGraphicsViewController.h"
#import "WSDDoodleView.h"

@interface WSDCoreGraphicsViewController ()

@end

@implementation WSDCoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView *containerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200, 400)];
    [self.view addSubview: containerView];
    // Do any additional setup after loading the view.
    WSDDoodleView *v = [[WSDDoodleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor grayColor];
    [containerView addSubview:v];
    
    // Get a image what drawn into a context.
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[WSDDoodleView drawnImage]];
    imgView.frame = CGRectMake(0, 100, 100, 100);
    [containerView addSubview:imgView];
    
    // Get a image from a existing view.
    UIGraphicsBeginImageContext(CGSizeMake(200, 200)); // background transparent.
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), YES, [UIScreen mainScreen].scale); // will not scale image, will crop off where image fall out of context //background black. 
    CGContextRef context = UIGraphicsGetCurrentContext();
    [containerView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithImage:img];
    imgView2.frame = CGRectMake(0, 200, 200, 200); // will scale image.
    [self.view addSubview:imgView2];
}

@end
