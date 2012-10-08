//
//  ImageSearchController.m
//  InklingChallenge
//
//  Copyright (c) 2011 Inkling Systems, Inc. All rights reserved.
//

#import "ImageSearchController.h"

@interface ImageSearchController ()
@property (nonatomic, retain) NSMutableData *searchResultsData;
@property (nonatomic, retain) NSMutableDictionary *searchResultsCache;
@end

@implementation ImageSearchController

@synthesize delegate = _delegate;
@synthesize searchResultsData = _searchResultsData;
@synthesize searchResultsCache = _searchResultsCache;


- (void)dealloc
{
    [_searchResultsData release];
    [_searchResultsCache release];
    [super dealloc];
}

#pragma mark singleton class method

+ (id)sharedController {
    static ImageSearchController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark instance methods

- (void)performSearch:(NSString *)searchTerm
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@&resultFormat=text", searchTerm]]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (NSInteger)numberOfCachedQueries
{
    //return [self.searchResultsCache count];
    return 5;
}

- (void)clearCache
{
    [self.searchResultsCache removeAllObjects];
}

#pragma mark NSURLConnnection Delegate Methods

// TODO: Handle errors and bad responses in a sensible way.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.searchResultsData = [[[NSMutableData alloc] initWithCapacity:1024] autorelease];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.searchResultsData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:self.searchResultsData options:NSJSONReadingAllowFragments error:&error];
    if (!JSONObject) {
        NSLog(@"There was an error: %@", error);
    }
    id responseData = [JSONObject objectForKey:@"responseData"];
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        id results = [responseData objectForKey:@"results"];
        if ([results isKindOfClass:[NSArray class]]) {
            [self.delegate imageSearchController:self gotResults:results];
        }
    }
}

#pragma mark accessors

- (NSMutableDictionary *)searchResultsCache
{
    if (!_searchResultsCache) {
        [self setSearchResultsCache:[[NSMutableDictionary alloc] initWithCapacity:1]];
    }
    return _searchResultsCache;
}


#pragma mark overriden methods for singleon

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedController] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX; //denotes an object that cannot be released
}

- (oneway void)release
{
    // never release
}

- (id)autorelease
{
    return self;
}

@end
