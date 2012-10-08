//
//  UIColor+ICAdditions.m
//  InklingChallenge
//
//  Created by Brandon Millman on 10/4/12.
//  Copyright (c) 2012 Inkling. All rights reserved.
//

#import "UIColor+ICAdditions.h"

#define kBackgroundImageName @"grid"

@implementation UIColor (ICAdditions)

+ (UIColor *)gridColor
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageName]];
}

@end
