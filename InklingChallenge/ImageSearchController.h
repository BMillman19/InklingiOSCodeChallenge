//
//  ImageSearchController.h
//  InklingChallenge
//
//  Copyright (c) 2011 Inkling Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageSearchControllerDelegate
- (void)imageSearchController:(id)searchController gotResults:(NSArray *)results;
@end

@interface ImageSearchController : NSObject <NSURLConnectionDataDelegate>

+ (id)sharedController;
- (void)performSearch:(NSString *)searchTerm;
- (NSInteger)numberOfCachedQueries;
- (void)clearCache;

@property (nonatomic, assign) id <ImageSearchControllerDelegate> delegate; // NOTE: Intentional weak reference

@end
