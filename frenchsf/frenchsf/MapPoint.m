//
//  MapPoint.m
//  CookieMapper
//
//  Created by Steve Derico on 10/12/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

@synthesize title = _title;
@synthesize coordinate = _coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d{
   self = [super init];
    
    self.title = ttl;
    _coordinate = c2d;
    
    return self;

}

@end
