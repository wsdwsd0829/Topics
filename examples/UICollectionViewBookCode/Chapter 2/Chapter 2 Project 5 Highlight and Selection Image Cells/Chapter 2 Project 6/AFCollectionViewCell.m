//
//  AFCollectionViewCell.m
//  Chapter 2 Project 6
//
//  Created by Ash Furrow on 2012-12-17.
//  Copyright (c) 2012 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewCell.h"

@implementation AFCollectionViewCell
{
    UIImageView *imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    // TODO: while background color.
    // TODO: create image view with inset 10.
    // TODO: set selectedBackgroundView with whit color and alpha 0.8.
    
    return self;
}

#pragma mark - Overriden UICollectionViewCell methods

- (void)setSelectedBackgroundView:(UIView *)selectedBackgroundView {
  [super setSelectedBackgroundView:selectedBackgroundView];
  NSLog(@"calling");
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    // TODO: clear background color and set image to nil.
}

// TODO: override setHighlight when highlighted imageView's alpha to 0.8.


#pragma mark - Overridden Properties

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    imageView.image = image;
}

@end
