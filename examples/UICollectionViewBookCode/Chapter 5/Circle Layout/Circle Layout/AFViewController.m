//
//  AFViewController.m
//  Circle Layout
//
//  Created by Ash Furrow on 2013-01-30.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFViewController.h"

#import "AFCollectionViewCircleLayout.h"
#import "AFCollectionViewFlowLayout.h"

#import "AFCollectionViewCell.h"

@interface AFViewController ()

@property (nonatomic, assign) NSInteger cellCount;

@property (nonatomic, strong) AFCollectionViewCircleLayout *circleLayout;
@property (nonatomic, strong) AFCollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UISegmentedControl *layoutChangeSegmentedControl;

@end

@implementation AFViewController

#pragma mark - View Controller Lifecycle

//Static identifier for cells
static NSString *CellIdentifier = @"CellIdentifier";

-(void)loadView
{
    // Create our view
    
    // Create instances of our layouts
    self.circleLayout = [[AFCollectionViewCircleLayout alloc] init];
    self.flowLayout = [[AFCollectionViewFlowLayout alloc] init];
    
    // Create a new collection view with our flow layout and set ourself as delegate and data source.
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.circleLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // Register our classes so we can use our custom subclassed cell and header
    [collectionView registerClass:[AFCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    // Set up the collection view geometry to cover the whole screen in any orientation and other view properties.
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Finally, set our collectionView (since we are a collection view controller, this also sets self.view)
    self.collectionView = collectionView;
    
    // Setup our model
    self.cellCount = 12;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteItem)];
    
    self.layoutChangeSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Circle", @"Flow"]];
    self.layoutChangeSegmentedControl.selectedSegmentIndex = 0;
    self.layoutChangeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.layoutChangeSegmentedControl addTarget:self action:@selector(layoutChangeSegmentedControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.layoutChangeSegmentedControl;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - User Interaction Methods

-(void)layoutChangeSegmentedControlDidChangeValue:(id)sender
{
    // We need to explicitly tell the collection view layout that we want the change animated.
    if (self.collectionView.collectionViewLayout == self.circleLayout)
    {
        [self.flowLayout invalidateLayout];
        [self.collectionView setCollectionViewLayout:self.flowLayout animated:YES];
    }
    else
    {
        [self.circleLayout invalidateLayout];
        [self.collectionView setCollectionViewLayout:self.circleLayout animated:YES];
    }
}

#pragma mark - Private Methods

-(void)addItem
{
    // TODO: insert at index before data source changes.
}

-(void)deleteItem
{
    // TODO: Always have at least once cell in our collection view
    
    // TODO: batch update: data source, and delete at the index before date source changes

}

#pragma mark - UICollectionView Delegate & DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    AFCollectionViewCell *cell = (AFCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setLabelString:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    return cell;
}

-(CGFloat)rotationAngleForSupplmentaryViewInCircleLayout:(AFCollectionViewCircleLayout *)circleLayout
{
    CGFloat timeRatio = 0.0f;
    
    NSDate *date = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:date];
    timeRatio = (CGFloat)(components.minute) / 60.0f;
    
    return (2 * M_PI * timeRatio);
}

@end
