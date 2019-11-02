//
//  AFCollectionViewCell.m
//  Dimensions
//
//  Created by Ash Furrow on 2013-01-13.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewCell.h"
#import "AFCollectionViewLayoutAttributes.h"

@implementation AFCollectionViewCell
{
    UIImageView *imageView;
    AFCollectionViewFlowLayoutMode layoutMode;
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    // Set up our image view
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    
    // This will make the rest of our cell, outside the image view, appear transparent against a black background.
    self.backgroundColor = [UIColor blackColor];
    
    return self;
}

#pragma mark - Overridden Methods

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    // Important! Check to make sure we're actually this special subclass.
    // Failing to do so could cause the app to crash!
    if (![layoutAttributes isKindOfClass:[AFCollectionViewLayoutAttributes class]])
    {
        return;
    }
    
    AFCollectionViewLayoutAttributes *castedLayoutAttributes = (AFCollectionViewLayoutAttributes *)layoutAttributes;
    layoutMode = castedLayoutAttributes.layoutMode;
    
    [self setImageViewFrame];
}

-(void)setImageViewFrame {
    //start out with the detail image size of the maximum size
    CGSize imageViewSize = self.bounds.size;
    
    if (layoutMode == AFCollectionViewFlowLayoutModeAspectFit)
    {
        //Determine the size and aspect ratio for the model's image
        CGSize photoSize = imageView.image.size;
        CGFloat aspectRatio = photoSize.width / photoSize.height;
        
        //this will have animation effect than setting imageView's contentMode directly
        if (aspectRatio < 1)
        {
            //The photo is taller than it is wide, so constrain the width
            imageViewSize = CGSizeMake(CGRectGetWidth(self.bounds) * aspectRatio, CGRectGetHeight(self.bounds));
        }
        else if (aspectRatio > 1)
        {
            //The photo is wider than it is tall, so constrain the height
            imageViewSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / aspectRatio);
        }
    }
    
    // Set the size of the imageView ...
    imageView.bounds = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
    // And the center, too.
    imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    [self setImage:nil];
}

#pragma mark - Public Methods

-(void)setImage:(UIImage *)image
{
    [imageView setImage:image];
    [self setImageViewFrame];
}

@end
