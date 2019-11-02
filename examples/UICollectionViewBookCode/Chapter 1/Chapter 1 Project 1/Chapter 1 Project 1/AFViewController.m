//
//  AFViewController.m
//  Chapter 1 Project 1
//
//

#import "AFViewController.h"

static NSString *kCellIdentifier = @"Cell Identifier";

@implementation AFViewController
{
    NSArray *colorArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    const NSInteger numberOfColors = 0; // TODO change to 100;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:numberOfColors];
    
    for (NSInteger i = 0; i < numberOfColors; i++)
    {
        // TODO: create RGB value using arc4random
    }
    
    colorArray = [NSArray arrayWithArray:tempArray];
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return colorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = colorArray[indexPath.item];
    
    return cell;
}

@end
