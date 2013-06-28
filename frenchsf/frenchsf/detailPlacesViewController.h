//
//  detailPlacesViewController.h
//  frenchsf
//
//  Created by Joshua Atkin on 6/14/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "MapPoint.h"


@interface detailPlacesViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locManager;

@property (weak, nonatomic) IBOutlet UITextView *placeDescrTextView;
@property (nonatomic, strong) NSString *placeDescription, *placeDescriptionFr, *placeTitle, *audioFile;



- (IBAction)chooseLanguage:(UISegmentedControl *)sender;


@property (nonatomic,assign) double placeLatitude, placeLongitude;


- (IBAction)playAudio:(UIBarButtonItem *)sender;

- (IBAction)pauseAudio:(UIBarButtonItem *)sender;


- (IBAction)restartAudio:(UIBarButtonItem *)sender;


@property (nonatomic, strong) NSString *selectedWord;



@end
