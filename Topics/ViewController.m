//
//  ViewController.m
//  Topics
//
//  Created by Max Wang on 5/6/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "ViewController.h"
#import "RunLoop/RunLoopViewController.h"
#import "Orientation/OrientationViewController.h"
#import "GCD/GCDViewController.h"
#import "BaseViewController.h"
#import "Performance/PerfViewController.h"
#import "CoreText/CoreTextViewController.h"
#import "AutoReleaseViewController/AutoReleaseViewController.h"
#import "HitTest/HitTestViewController.h"
#import "UI/KeyboardTypeViewController.h"
#import "DisplayLink/DisplayLinkViewController.h"
#import "IGListKitViewController.h"
#import "OffScreenRendering/OffScreenRenderingViewController.h"
#import "Collection/WSDCollectionTestViewController.h"
#import "WSDCoreGraphicsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;

@end

@implementation ViewController {
  NSArray *_topicTitles;
  NSArray *_topicViewControllerClasses;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Topics";
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.view addSubview:self.tableView];

  [self setupTable];

}

// To add item: 1. add to enum, 2. add _topicTitles, _topicViewControllerClasses, 3 impl ViewController
- (void)setupTable {
  _topicTitles = @[@"RunLoop", @"Orientation", @"GCD",  @"Performance", @"AutoRelease", @"CoreText", @"HitTest", @"KeyboardType", @"DisplayLink", @"IGListKit", @"OffScreenRendering", @"Collection", @"CoreGraphics"];
  _topicViewControllerClasses = @[ [RunLoopViewController class],
                                   [OrientationViewController class],
                                   [GCDViewController class],
                                   [PerfViewController class],
                                   [AutoReleaseViewController class],
                                   [CoreTextViewController class],
                                   [HitTestViewController class],
                                   [KeyboardTypeViewController class],
                                   [DisplayLinkViewController class],
                                   [IGListKitViewController class],
                                   [OffScreenRenderingViewController class],
                                   [WSDCollectionTestViewController class],
                                   [WSDCoreGraphicsViewController class],
                                ];
//  NSAssert(_topicTitles.count == TopicAll, @"_topicTitles should match all Topic except 'TopicAll'");
//  NSAssert(_topicViewControllerClasses.count == TopicAll, @"_topicTitles should match all Topic except 'TopicAll'");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
  switch (indexPath.row) {
      default:
      cell.textLabel.text = _topicTitles[indexPath.row];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  BaseViewController *vc;
  switch (indexPath.row) {
    default:
      vc = [[_topicViewControllerClasses[indexPath.row] alloc] init];
      [vc setTitle:_topicTitles[indexPath.row]];
      break;
  }
  [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _topicTitles.count;
}

@end
