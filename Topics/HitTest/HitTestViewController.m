//
//  HitTestViewController.m
//  Topics
//
//  Created by Max Wang on 8/26/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "HitTestViewController.h"
#import "HitTestView.h"

@interface HitTestViewController ()

@end

@implementation HitTestViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.edgesForExtendedLayout = UIRectEdgeNone;
  HitTestView *ht1 = [[HitTestView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
  ht1.backgroundColor = [UIColor greenColor];
  ht1.tag = 1;

  HitTestView *ht2 = [[HitTestView alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
  ht2.backgroundColor = [UIColor blueColor];
  ht2.alpha = 0.5;
  ht2.tag = 2;

  [self.view addSubview:ht1];
  [self.view addSubview:ht2];
}

@end
