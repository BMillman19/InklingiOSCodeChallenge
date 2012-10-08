//
//  SearchQueryViewController.m
//  InklingChallenge
//
//  Created by Brandon Millman on 10/4/12.
//  Copyright (c) 2012 Inkling. All rights reserved.
//

#import "SearchQueryViewController.h"

#import "ImageSearchController.h"

@interface SearchQueryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation SearchQueryViewController

@synthesize tableView = _tableView;

#pragma mark dealloc and init

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark UIViewController

- (void)loadView
{
    [super loadView];
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[ImageSearchController sharedController] numberOfCachedQueries];
}

#pragma mark UITableViewDelegate

@end
