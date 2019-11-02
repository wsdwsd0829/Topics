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
    
    self.backgroundColor = [UIColor whiteColor];
    
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
    
    self.backgroundColor = [UIColor whiteColor];
    self.image = nil; //also resets imageView’s image
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (self.highlighted)
    {
        imageView.alpha = 0.8f;
    }
    else
    {
        imageView.alpha = 1.0f;
    }
}

#pragma mark - Overridden Properties

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    imageView.image = image;
}

@end
