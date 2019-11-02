//
//  WSDCollectionTestViewController.m
//  Topics
//
//  Created by Max Wang on 10/31/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "WSDCollectionTestViewController.h"

//
//  ViewController.m
//  HorizontalCollection
//
//  Created by Max Wang on 10/31/19.
//  Copyright © 2019 Max Wang. All rights reserved.
//

#import "ViewController.h"


@interface WSFlowLayout : UICollectionViewFlowLayout

@end

@implementation WSFlowLayout

- (BOOL)flipsHorizontallyInOppositeLayoutDirection {
  return YES;
}

@end

@interface WSCell : UICollectionViewCell
@property (nonatomic) UILabel *label;
@end

@implementation WSCell {
}

- (void)prepareForReuse {
  [super prepareForReuse];
  _label.text = @"";
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor grayColor];
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_label];
  }
  return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  [super applyLayoutAttributes:layoutAttributes];
  _label.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height);
}

@end

@interface WSDCollectionTestViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@end

@implementation WSDCollectionTestViewController {
  UICollectionView *_collectionView;
  UICollectionViewFlowLayout *_flowLayout;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _flowLayout = [[WSFlowLayout alloc] init];
  // Do any additional setup after loading the view.
  CGRect f = CGRectMake(0, 100, self.view.bounds.size.width, 200);
  _collectionView = [[UICollectionView alloc] initWithFrame:f collectionViewLayout:_flowLayout];
  _collectionView.dataSource = self;
  [_collectionView registerClass:[WSCell class] forCellWithReuseIdentifier:@"id"];
  _collectionView.delegate = self;
//  _flowLayout.itemSize = CGSizeMake(200, 200);
  [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
  [self.view addSubview:_collectionView];
  _flowLayout.minimumLineSpacing = 10;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  WSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
  cell.label.text = [NSString stringWithFormat:@"Cell %lu", indexPath.item];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item % 2 == 0) {
    return CGSizeMake(400, 200);
  } else {
    return CGSizeMake(200, 200);
  }
}

@end

