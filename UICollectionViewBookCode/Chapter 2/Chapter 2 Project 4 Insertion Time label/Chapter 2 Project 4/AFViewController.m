//
//  AFViewController.m
//  Chapter 2 Project 4
//
//  Created by Ash Furrow on 2012-12-17.
//  Copyright (c) 2012 Ash Furrow. All rights reserved.
//

#import "AFViewController.h"

#import "AFCollectionView.h"
#import "AFCollectionViewCell.h"
#import "AFCollectionViewFlowLayout.h"

@interface AFViewController () <UICollectionViewDelegateFlowLayout>

@end

static NSString *CellIdentifier = @"Cell Identifier";

@implementation AFViewController
{
    //This is our model
    NSMutableArray *datesArray;
  NSMutableArray *dataArray;

    NSDateFormatter *dateFormatter;
}

- (void)loadView {
  UICollectionViewFlowLayout *flowLayout = [[AFCollectionViewFlowLayout alloc] init];
  self.collectionView = [[AFCollectionView alloc] initWithFrame: [[UIScreen mainScreen] bounds] collectionViewLayout:flowLayout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //instantiate our model
    datesArray = [NSMutableArray array];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"h:mm:ss a" options:0 locale:[NSLocale currentLocale]]];
  dataArray = @[@"aaaaaaaaaaaaa aaaaaaaaaaaaa very long string, a very long string, a very long string, a very long string,  a very long string, a very long string, a very long string", @"bbbbbbbbb, bbbbbbbb a very long string, a very long string, a very long string, a very long string, a very long string, a very long string, a very long string", @"a very long string, a very long string, a very long string, a very long string, a very long string, a very long string, a very long string", @"a very long string, a very long string, a very long string, a very long string, a very long string, a very long string, a very long string", @"a", @"b", @"c", @"d", @"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d",@"a", @"b", @"c", @"d"];
    //configure our collection view layout
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.minimumInteritemSpacing = 40.0f;
    flowLayout.minimumLineSpacing = 40.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(200, 200);
    
    //configure our collection view
    [self.collectionView registerClass:[AFCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    //configure our navigation item
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(userTappedAddButton:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.title = @"Our Time Machine";

  UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(userTappedRefreshButton:)];
  self.navigationItem.leftBarButtonItem = refreshButton;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//  return CGSizeMake(200 + 5*indexPath.item, 200*(indexPath.item+1)/2);
//}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return datesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AFCollectionViewCell *cell = (AFCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  id item = datesArray[indexPath.row];
  NSString * str;
  if ([item isKindOfClass:[NSDate class]]) {
    str = [dateFormatter stringFromDate:datesArray[indexPath.row]];
  } else {
    str = item;
  }
    cell.text = str;//
    NSLog(@"indexPath %@", indexPath);
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//  ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumInteritemSpacing = 200;
  AFCollectionViewFlowLayout *layout = (AFCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
  [layout.invalidatedIndexPaths addObject:indexPath];

  UICollectionViewFlowLayoutInvalidationContext *context = [[UICollectionViewFlowLayoutInvalidationContext alloc] init];
  [context invalidateItemsAtIndexPaths:@[indexPath]];
//  [self.collectionView.collectionViewLayout invalidateLayoutWithContext:context];
  [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - User Interface Interaction Methods

-(void)userTappedAddButton:(id)sender
{
    [self addNewDate];
}

-(void)userTappedRefreshButton:(id)sender {
//  [self.collectionView performBatchUpdates:^{
//  } completion:nil];

  UICollectionViewFlowLayoutInvalidationContext * context = [[UICollectionViewFlowLayoutInvalidationContext alloc] init];
  NSIndexPath *first = [NSIndexPath indexPathForItem:0 inSection:0];
  [context invalidateItemsAtIndexPaths:@[first]];
//  [self.collectionView.collectionViewLayout invalidateLayoutWithContext:context];
  [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Private, Custom methods

-(void)addNewDate
{
//    [self.collectionView performBatchUpdates:^{
//        //create a new date object and update our model
//        NSDate *newDate = [NSDate date];
//        [datesArray insertObject:newDate atIndex:0];
//
//        //update our collection view
//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
//    } completion:nil];

  //create a new date object and update our model
  NSDate *newDate = [NSDate date];
  [datesArray insertObject:newDate atIndex:0];

  //update our collection view
  [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];



  //update our collection view
  // ??? over insertion will not work.
  if (datesArray.count > 0) {
  [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:datesArray.count - 1 inSection:0]]];
  [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
  [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
  [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
  }

//  [self.collectionView reloadData];
}

@end
