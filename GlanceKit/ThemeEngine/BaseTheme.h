//
//  BaseTheme.h
//  Glance
//
//  Created by Joseph Daniels on 7/12/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTheme : NSObject <NSCoding>


- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder; // NS_DESIGNATED_INITIALIZER


@end
