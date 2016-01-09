//
// Created by Joseph Daniels on 7/26/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

#import "NSView+FullScreenAdditions.h"


@implementation NSView (FullScreenAdditions)
+ (instancetype)expandableView{
    NSView * vview = [[self alloc] initWithFrame:CGRectZero];
    [vview setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    return vview;
}

@end