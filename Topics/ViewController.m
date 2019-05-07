//
//  ViewController.m
//  Topics
//
//  Created by Max Wang on 5/6/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "ViewController.h"
#import "RunLoop/RunLoopViewController.h"

typedef NS_ENUM(NSInteger, Topic)  {
  TopicRunLoop, TopicAll
};

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
  switch (indexPath.row) {
    case TopicRunLoop:
      cell.textLabel.text = @"RunLoop";
      return cell;
  }
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return TopicAll;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UIViewController *vc;
  switch (indexPath.row) {
    case TopicRunLoop:
      vc = [[RunLoopViewController alloc] init];
      break;

    default:
      break;
  }
  [self.navigationController pushViewController:vc animated:YES];
}

@end
