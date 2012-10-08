//
//  UIView+ICAdditions.m
//  InklingChallenge
//
//  Created by Brandon Millman on 10/4/12.
//  Copyright (c) 2012 Inkling. All rights reserved.
//

#import "UIView+ICAdditions.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIView (ICAdditions)

- (void)setShadow
{
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(10.0f,10.0f);
    self.layer.shadowOpacity = .5f;
    self.layer.shadowRadius = 10.0f;
}

@end
