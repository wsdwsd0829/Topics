//
//  AFCollectionViewFlowLayout.m
//  Survey
//
//  Created by Ash Furrow on 2013-01-12.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewFlowLayout.h"

#import "AFDecorationView.h"

NSString * const AFCollectionViewFlowLayoutBackgroundDecoration = @"DecorationIdentifier";

@implementation AFCollectionViewFlowLayout
{
    NSMutableSet *insertedSectionSet;
}

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.sectionInset = UIEdgeInsetsMake(30.0f, 80.0f, 30.0f, 20.0f);
    self.minimumInteritemSpacing = 20.0f;
    self.minimumLineSpacing = 20.0f;
    self.itemSize = kMaxItemSize;
    self.headerReferenceSize = CGSizeMake(60, 70);
    [self registerClass:[AFDecorationView class] forDecorationViewOfKind:AFCollectionViewFlowLayoutBackgroundDecoration];
    
    insertedSectionSet = [NSMutableSet set];
    
    return self;
}

#pragma mark - Private Helper Methods

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes
{
    // Check for representedElementKind being nil, indicating this is a cell and not a header or decoration view
    if (attributes.representedElementKind == nil)
    {
        CGFloat width = [self collectionViewContentSize].width;
        CGFloat leftMargin = [self sectionInset].left;
        CGFloat rightMargin = [self sectionInset].right;
        
        NSUInteger itemsInSection = [[self collectionView] numberOfItemsInSection:attributes.indexPath.section];
        // TODO: calculate firstXPosition and xPosition
        attributes.center = CGPointMake(leftMargin + xPosition, attributes.center.y);
        attributes.frame = CGRectIntegral(attributes.frame);
    }
}

#pragma mark - Overridden Methods

#pragma mark Cell Layout

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *newAttributesArray = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attributes in attributesArray)
    {
        [self applyLayoutAttributes:attributes];
        
        if (attributes.representedElementCategory == UICollectionElementCategorySupplementaryView)
        {
            // TODO: create attribute for Decoration view using AFCollectionViewFlowLayoutBackgroundDecoration and add to array.
        }
    }
    
    attributesArray = [attributesArray arrayByAddingObjectsFromArray:newAttributesArray];
    
    return attributesArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    [self applyLayoutAttributes:attributes];
    
    return attributes;
}

#pragma mark Decoration View Layout

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    if ([decorationViewKind isEqualToString:AFCollectionViewFlowLayoutBackgroundDecoration])
    {
        UICollectionViewLayoutAttributes *tallestCellAttributes;
        NSInteger numberOfCellsInSection = [self.collectionView numberOfItemsInSection:indexPath.section];
        
        // TODO: Calculate tallestCellAttributes
        
        CGFloat decorationViewHeight = CGRectGetHeight(tallestCellAttributes.frame) + self.headerReferenceSize.height;
        
        layoutAttributes.size = CGSizeMake([self collectionViewContentSize].width, decorationViewHeight);
        layoutAttributes.center = CGPointMake([self collectionViewContentSize].width / 2.0f, tallestCellAttributes.center.y);
        layoutAttributes.frame = CGRectIntegral(layoutAttributes.frame);
        // TODO: Place the decoration view behind all the cells: zIndex = -1;
        
    }
    
    return layoutAttributes;
}

#pragma mark Animation Support

-(void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    // TODO: enumerate updateItems for insertion and add to insertedSectionSet

}

-(void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // TODO: remvoe all objets from insertedSectionSet.
}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath
{
    //returning nil will cause a crossfade
    
    UICollectionViewLayoutAttributes *layoutAttributes;
    
    if ([elementKind isEqualToString:AFCollectionViewFlowLayoutBackgroundDecoration])
    {
        if ([insertedSectionSet containsObject:@(decorationIndexPath.section)])
        {
            layoutAttributes = [self layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:decorationIndexPath];
            layoutAttributes.alpha = 0.0f;
            // TODO: set transfrom3D with x translation to -width using CATransform3DMakeTranslation.
        }
    }
    
    return layoutAttributes;
}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    //returning nil will cause a crossfade
    
    UICollectionViewLayoutAttributes *layoutAttributes;
    
    if ([insertedSectionSet containsObject:@(itemIndexPath.section)])
    {
        layoutAttributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        // TODO: set transfrom3D with x translation to width using CATransform3DMakeTranslation.
    }
    
    return layoutAttributes;
}

@end
