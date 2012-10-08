//
//  ImageDetailView.m
//  InklingChallenge
//
//  Created by Brandon Millman on 10/4/12.
//  Copyright (c) 2012 Inkling. All rights reserved.
//

#import "ImageDetailView.h"

@interface ImageDetailView () <UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *container;
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation ImageDetailView

@synthesize image = _image;
@synthesize container = _container;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.container = [[[UIScrollView alloc] initWithFrame:frame] autorelease];
        [self addSubview:self.container];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    [image retain];
    [_image release];
    _image = image;
    
    if (!self.imageView) {
        self.imageView = [[[UIImageView alloc] initWithImage:_image] autorelease];
        
    } else {
        self.imageView.image = _image;
    }
    [self.container addSubview:self.imageView];
    [self.container setContentSize:CGSizeMake(_image.size.height, _image.size.width)];
}

#pragma mark - UIScrollViewDelegate

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
