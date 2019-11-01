//
//  IGListKitViewController.m
//  Topics
//
//  Created by Max Wang on 10/14/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "IGListKitViewController.h"
#import <IGListKit/IGListKit.h>

@interface IGListKitViewController ()

@end

@implementation IGListKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  // Override point for customization after application launch.
  NSArray* arr1 = @[@2, @1, @3, @4, @5]; // ???
  NSArray* arr2 = @[@1, @2, @3, @4, @5, @6, @7]; // new

  IGListIndexSetResult *result = IGListDiff(arr1, arr2, IGListDiffEquality);

  NSLog(@"\ninserts %@, \ndeletes %@, \nupdates %@, \nmoves %@", result.inserts, result.deletes, result.updates, result.moves);

  NSLog(@"^^^^^^ results: %@", result);
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
