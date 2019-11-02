//
//  AFCollectionViewFlowLayout.m
//  Chapter 2 Project 4
//
//  Created by Max Wang on 1/22/18.
//  Copyright © 2018 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewFlowLayout.h"

@implementation AFCollectionViewFlowLayout

- (instancetype)init {
  if (self = [super init]) {
    _invalidatedIndexPaths = [[NSMutableArray alloc] init];
    return self;
  }
  return nil;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray<UICollectionViewLayoutAttributes *> * attrs = [super layoutAttributesForElementsInRect:rect];
  NSLog(@"layoutAttributesForElementsInRect");

  for (UICollectionViewLayoutAttributes *attr in attrs) {
    if ([_invalidatedIndexPaths containsObject:attr.indexPath]) {
      attr.size = CGSizeMake(400,400);
    }
  }
  return attrs;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes * attr = [super layoutAttributesForItemAtIndexPath:indexPath];
  NSLog(@"layoutAttributesForItemAtIndexPath: %@", indexPath);
  if ([_invalidatedIndexPaths containsObject:attr.indexPath]) {
    attr.size = CGSizeMake(400,400);
  }
  return attr;
}

@end
