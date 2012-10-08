//
//  MainViewController.m
//  InklingChallenge
//
//  Copyright (c) 2011 Inkling Systems, Inc. All rights reserved.
//

#import "MainViewController.h"

#import "UIColor+ICAdditions.h"
#import "UIView+ICAdditions.h"
#import "ImageDetailView.h"
#import "SearchQueryViewController.h"

@interface MainViewController ()
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) ImageSearchController *imageSearchController;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) ImageDetailView *imageDetailView;
@property (nonatomic, retain) SearchQueryViewController *searchQueryViewController;
@end

@implementation MainViewController

@synthesize searchBar = _searchBar;
@synthesize imageSearchController = _imageSearchController;
@synthesize backgroundView = _backgroundView;
@synthesize imageDetailView = _imageDetailView;
@synthesize searchQueryViewController = _searchQueryViewController;

- (void)dealloc
{
    [_searchBar release];
    [_imageSearchController release];
    [_backgroundView release];
    [_imageDetailView release];
    [_searchQueryViewController release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.imageSearchController = [[[ImageSearchController alloc] init] autorelease];
//        self.imageSearchController.delegate = self;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    // Set up background
    self.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.backgroundView.backgroundColor = [UIColor gridColor];
    [self.view addSubview:self.backgroundView];
    
    // Set up search bar
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width/4, 60.0f)] autorelease];
    self.searchBar.barStyle = UIBarStyleBlackTranslucent;
    [[self.searchBar.subviews objectAtIndex:0] removeFromSuperview];
    self.searchBar.alpha = 0;
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    // Set up query table
    self.searchQueryViewController = [[[SearchQueryViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [self addChildViewController:self.searchQueryViewController];
    [self.searchQueryViewController didMoveToParentViewController:self];
    //self.searchQueryViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width/4, 60.0f);
    [self.searchQueryViewController.view setShadow];
    [self.view addSubview:self.searchQueryViewController.view];

     
    
    // Set up image detail
    self.imageDetailView = [[[ImageDetailView alloc] initWithFrame:CGRectMake(300, 0, self.view.bounds.size.width/4, 350)] autorelease];
    self.imageDetailView.image = [UIImage imageNamed:@"list-icon"];
    [self.imageDetailView setShadow];
    [self.view addSubview:self.imageDetailView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [UIView beginAnimations: @"Fade In" context:nil];
    
    [UIView setAnimationDelay:1];
    [UIView setAnimationDuration:1];
    self.searchBar.alpha = 1;
    [UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // TODO: Make sure everything resizes and/or reflows correctly on rotation.
	return YES;
}

#pragma mark UISearchBar Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.imageSearchController performSearch:searchBar.text];
}

#pragma mark ImageSearchController Delegate Methods

- (void)imageSearchController:(id)searchController gotResults:(NSArray *)results
{
    // TODO: Load each image listed in results and display them nicely.

    // TODO: Google only sends a few images at a time.  Add a control to allow the user to fetch more images.
    // You will need to append the parameter "start" to the request made by the ImageSearchController.
    // Results are zero-indexed.  Be careful not to violate the Google API TOS!  The user must initiate
    // fetching each set of results with a "user action."  Automated requests are not allowed.
}

#pragma mark Accessors

- (void)setBackgroundView:(UIView *)backgroundView
{
    [backgroundView retain];
    [_backgroundView release];
    
    backgroundView.frame = self.view.bounds;
    _backgroundView = backgroundView;
}

@end
