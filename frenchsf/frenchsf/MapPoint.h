//
//  MapPoint.h
//  CookieMapper
//
//  Created by Steve Derico on 10/12/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface MapPoint : NSObject <MKAnnotation>

@property (nonatomic,strong) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString*)ttl andCoordinate:(CLLocationCoordinate2D)c2d;


@end
