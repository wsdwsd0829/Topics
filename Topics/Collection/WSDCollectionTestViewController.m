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

#define ACTIVE_DISTANCE         100
#define TRANSLATE_DISTANCE      100
#define ZOOM_FACTOR             0.2f
#define FLOW_OFFSET             40
#define INACTIVE_GREY_VALUE     0.6f

@interface WSDCarouselFlowLayout : UICollectionViewFlowLayout

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect;

@end

@implementation WSDCarouselFlowLayout

- (void)prepareLayout {
  [super prepareLayout];
}

- (BOOL)flipsHorizontallyInOppositeLayoutDirection {
  return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  // get cell that closest to center.
  CGRect visibleRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
  NSArray<UICollectionViewLayoutAttributes *> *attrsArray = [self layoutAttributesForElementsInRect:visibleRect];
  CGFloat closestX = CGFLOAT_MAX;
  CGFloat midX = CGRectGetMidX(visibleRect);
  NSLog(@"proposedContentOffset: %@", NSStringFromCGPoint(proposedContentOffset));
  NSLog(@"visibleRect:%@ midX: %f", NSStringFromCGRect(visibleRect), midX);
  UICollectionViewLayoutAttributes *centerAttrs;
  for (UICollectionViewLayoutAttributes *attrs in attrsArray) {
    NSLog(@"each attr: %@", NSStringFromCGPoint(attrs.center));
    if (ABS(attrs.center.x - midX) < closestX) {
      closestX = ABS(attrs.center.x - midX);
      centerAttrs = attrs;
    }
  }
  CGPoint result = proposedContentOffset;
  result.x = proposedContentOffset.x + (centerAttrs.center.x - midX);
  NSLog(@"indexPath: %@", centerAttrs.indexPath);
  NSLog(@"center: %@",  NSStringFromCGPoint(centerAttrs.center));
  NSLog(@"result: %@",  NSStringFromCGPoint(result));
  return result;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes *attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
  CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
  NSLog(@"Inside forItem applyLayoutAttributes:%@ attrs: %@", NSStringFromCGPoint(self.collectionView.contentOffset), attrs);
  [self applyLayoutAttributes:attrs forVisibleRect:visibleRect];
  return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray<UICollectionViewLayoutAttributes *> *attrsArray = [super layoutAttributesForElementsInRect:rect];
  CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
  for (UICollectionViewLayoutAttributes *attrs in attrsArray) {
    if (CGRectIntersectsRect(attrs.frame, visibleRect)) {
      NSLog(@"Inside forElements applyLayoutAttributes:%@ attrs:%@", NSStringFromCGPoint(self.collectionView.contentOffset), attrs);
      [self applyLayoutAttributes:attrs forVisibleRect:visibleRect];
    }
  }
  return attrsArray;
}


-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect
{

    // Applies the cover flow effect to the given layout attributes.
    // We want to skip supplementary views.
    if (attributes.representedElementKind) return;

    // Calculate the distance from the center of the visible rect to the center of the attributes.
    // Then normalize it so we can compare them all. This way, all items further away than the
    // active get the same transform.
    CGFloat distanceFromVisibleRectToItem = CGRectGetMidX(visibleRect) - attributes.center.x;
    CGFloat normalizedDistance = distanceFromVisibleRectToItem / ACTIVE_DISTANCE;
    BOOL isLeft = distanceFromVisibleRectToItem > 0;
    CATransform3D transform = CATransform3DIdentity;


    if (fabsf(distanceFromVisibleRectToItem) < ACTIVE_DISTANCE)
    {
        // We're close enough to apply the transform in relation to
        // how far away from the center we are.

        transform = CATransform3DTranslate(CATransform3DIdentity, (isLeft? - FLOW_OFFSET : FLOW_OFFSET)*ABS(distanceFromVisibleRectToItem/TRANSLATE_DISTANCE), 0, (1 - ABS(normalizedDistance)) * 40000 + (isLeft? 200 : 0));

        // Set the perspective of the transform.
        transform.m34 = -1/(4.6777 * 150);

        // Set the zoom factor.
        CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
        transform = CATransform3DScale(transform, zoom, zoom, 1);
        attributes.zIndex = 1;

    }
    else
    {
        // We're too far away - just apply a standard perspective transform.

        transform.m34 = -1/(4.6777 * 150);
        transform = CATransform3DTranslate(transform, isLeft? -FLOW_OFFSET : FLOW_OFFSET, 0, 0);
        attributes.zIndex = 0;
    }
    attributes.transform3D = transform;
}




@end


@interface WSFlowLayout : UICollectionViewFlowLayout

@end

@implementation WSFlowLayout

- (void)prepareLayout {
  [super prepareLayout];
}

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

static int counter = 0;

@interface WSDCollectionTestViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@end

@implementation WSDCollectionTestViewController {
  UICollectionView *_collectionView;
  UICollectionViewFlowLayout *_flowLayout;
  WSDCarouselFlowLayout *_carouselFlowLayout;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _flowLayout = [[WSFlowLayout alloc] init];
  _carouselFlowLayout = [[WSDCarouselFlowLayout alloc] init];
  // Do any additional setup after loading the view.
  CGRect f = CGRectMake(0, 100, self.view.bounds.size.width, 200);
  _collectionView = [[UICollectionView alloc] initWithFrame:f collectionViewLayout:_carouselFlowLayout];
  _collectionView.dataSource = self;
  _collectionView.delegate = self;
  [self.view addSubview:_collectionView];
  self->_collectionView.contentInset = UIEdgeInsetsMake(0, 150, 0, 150);
  [_collectionView registerClass:[WSCell class] forCellWithReuseIdentifier:@"id"];
//  _flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
//  _flowLayout.itemSize = CGSizeMake(200, 200);

  [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
  [_carouselFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
  _flowLayout.minimumLineSpacing = 50;
  _carouselFlowLayout.minimumLineSpacing = 50;

  UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"Carousel", @"Normal"]];
  self.navigationItem.titleView = control;
  [control addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];

//  int total = [self collectionView:_collectionView numberOfItemsInSection:0];
//  [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//    [self->_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:counter inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    counter++;
//    if (counter == total) {
//      [timer invalidate];
//    }
//  }];
}


- (void)segmentedControlChanged:(UISegmentedControl *)control {
  if (control.selectedSegmentIndex == 0) {
    [_collectionView.collectionViewLayout invalidateLayout];
    _collectionView.collectionViewLayout = _carouselFlowLayout;
  } else {
    [_collectionView.collectionViewLayout invalidateLayout];
    _collectionView.collectionViewLayout = _flowLayout;
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
//    int total = [self collectionView:_collectionView numberOfItemsInSection:0];
//
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//      [self collectionView:self->_collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:counter inSection:0]];
////      [self->_collectionView scrollToItemAtIndexPath: atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//      counter++;
//      if (counter == total) {
//        [timer invalidate];
//      }
//    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  WSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
  cell.label.text = [NSString stringWithFormat:@"Cell %lu", indexPath.item];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item % 2 == 0) {
    return CGSizeMake(150, 200);
  } else {
    return CGSizeMake(150, 200);
  }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
  CGPoint center = [_collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath].center;
  CGFloat proposedPointX = _collectionView.contentOffset.x + center.x - (collectionView.contentOffset.x +  _collectionView.frame.size.width/2);
  CGPoint targetPoint = [_collectionView.collectionViewLayout targetContentOffsetForProposedContentOffset:CGPointMake(proposedPointX, 0) withScrollingVelocity:CGPointZero];
  [_collectionView setContentOffset:targetPoint animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  NSLog(@"didScroll offset: %@", NSStringFromCGPoint(_collectionView.contentOffset));
    CGRect visibleRect = CGRectMake(_collectionView.contentOffset.x,_collectionView.contentOffset.y, CGRectGetWidth(_collectionView.bounds), CGRectGetHeight(_collectionView.bounds));
  CGRect queryRect = CGRectMake(visibleRect.origin.x - _collectionView.bounds.size.width, 0, _collectionView.bounds.size.width * 3, CGRectGetHeight(_collectionView.bounds));
  NSLog(@"Before!!!!!!");
  NSArray<UICollectionViewLayoutAttributes *>* attrsArray = [_collectionView.collectionViewLayout layoutAttributesForElementsInRect:visibleRect];
  NSLog(@"After!!!!!!");
  for (UICollectionViewLayoutAttributes *attrs in attrsArray) {
    if ([_collectionView.collectionViewLayout isKindOfClass: [WSDCarouselFlowLayout class]]) {


    // Note: order of calling: scrollViewDidScroll then layoutForElements the returned attrs may be different so that the result get from didScroll is different from layoutForElements.
      NSLog(@"visibleRect: %@", NSStringFromCGRect(visibleRect));
      NSLog(@"applyLayoutAttributes:%@ attrs: %@", NSStringFromCGPoint(_collectionView.contentOffset), attrs);
//      [((WSDCarouselFlowLayout *)_collectionView.collectionViewLayout) applyLayoutAttributes:attrs forVisibleRect:visibleRect];
    }
  }
}

@end

