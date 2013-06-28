//
//  detailPlacesViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/14/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "detailPlacesViewController.h"
#import "definitionWebViewController.h"


@interface detailPlacesViewController ()  {
    
    
    AVAudioPlayer *avPlayer;
    
}


@end

@implementation detailPlacesViewController {
    NSString *annotationName;
}

@synthesize placeDescription, placeDescriptionFr, placeDescrTextView, placeLatitude, placeLongitude, placeTitle, audioFile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.mapView.showsUserLocation = YES;
//    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
 //    self.locManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //  [self.locManager startUpdatingLocation];

//      self.locManager.delegate = self;
//    [self zoomMapViewToFitAnnotations:self.mapView animated:animated];
    
    self.title = placeTitle;
    
    
    
    

   
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
   
    [self zoomMapViewToFitAnnotations:self.mapView animated:animated];
    
}


- (void) defineWord: (id) sender
{
   // NSLog(@"Doing something");
   // return [self.webview stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    _selectedWord =[placeDescrTextView textInRange:[placeDescrTextView selectedTextRange] ];
    
  //  definitionWebViewController *yourViewController = [[definitionWebViewController alloc] init];
  
    
    /// we want this transition?
    /*
    UIViewController *definitionView = [self.storyboard instantiateViewControllerWithIdentifier:@"definitionID"];
   
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:definitionView animated:NO];
    */
    [self performSegueWithIdentifier:@"definitionSegue" sender:nil];
    
    
    
   // UIViewController *homeView = [self.storyboard instantiateViewControllerWithIdentifier:@"definitionID"];
  //  [self presentViewController:homeView animated:YES completion:NULL] ;
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    
    self.locManager = [[CLLocationManager alloc] init];
    
    CLLocationCoordinate2D location;
	location.latitude = (double)  placeLatitude;
	location.longitude = (double) placeLongitude;
    
    // Add the annotation to our map view
	MapPoint *newAnnotation = [[MapPoint alloc] initWithTitle:placeTitle andCoordinate:location] ;
    
    
	[self.mapView addAnnotation:newAnnotation];
    
    
    
    placeDescrTextView.text = placeDescription;
    
    
    
    NSString *stringPath = [[NSBundle mainBundle] pathForResource:audioFile ofType:@"mp3"];
    
    
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    NSError *error;
    
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    
    // Change the highlhighted menu when a word is clicked on
    // to redirect to wordreference.com
    
    
    
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *translate = [[UIMenuItem alloc] initWithTitle:@"Translate" action:@selector(defineWord:)];
    [menu setMenuItems:[NSArray arrayWithObjects:translate, nil]];
    
    [menu setTargetRect:CGRectMake(0, 0, 0.0f, 0.0f) inView:self.view];
    [menu setMenuVisible:YES animated:YES];
    
    
}




-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
 
  
    
    if (action == @selector(defineWord:))
    {
        return YES;
          NSLog(@"define....word");
    }
   
    else if (action == @selector(selectAll:))
    {
        return NO;
        NSLog(@"select all");
    }
    
   
    return [super canPerformAction:action withSender:sender];
}










- (void)viewDidUnload
{
    [self setMapView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



// Begin of showing chevron for annotation

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    
       
    MKPinAnnotationView *mypin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"current"];
    //mypin.pinColor = MKPinAnnotationColorRed;
    //mypin.backgroundColor = [UIColor clearColor];
  //  UIButton *goToDetail = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  //  mypin.rightCalloutAccessoryView = goToDetail;
    mypin.draggable = NO;
    mypin.highlighted = YES;
    mypin.animatesDrop = TRUE;
    mypin.canShowCallout = YES;
    
    
    

    
    return mypin;
}

/*
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    annotationName = view.annotation.title;
    
    [self performSegueWithIdentifier:@"showMapPointDetail" sender:self];
    
    
}
*/


//end of showing details for annotation


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    NSLog(@"Locations %@",newLocation);
}

#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360
//size the mapView region to fit its annotations
- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated
{
    NSArray *annotations = self.mapView.annotations;
    int count = [self.mapView.annotations count];
    if ( count == 0) { return; } //bail if no annotations
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 )
    {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    [self.mapView setRegion:region animated:animated];
}
// SEGUE


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"definitionSegue"]) {
        
        definitionWebViewController *destViewController = segue.destinationViewController;
        destViewController.definitionWord   =  _selectedWord;
   
    }

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAudio:(UIBarButtonItem *)sender {
    [avPlayer play];
    
}

- (IBAction)pauseAudio:(UIBarButtonItem *)sender {
    [avPlayer pause];
}

- (IBAction)restartAudio:(UIBarButtonItem *)sender {
    [avPlayer stop];
    [avPlayer setCurrentTime:0];
    [avPlayer play];
}



  

- (IBAction)chooseLanguage:(UISegmentedControl *)sender {
    
    
    if(sender.selectedSegmentIndex == 0){
        placeDescrTextView.text = placeDescription;
	}
	if(sender.selectedSegmentIndex == 1){
       placeDescrTextView.text = placeDescriptionFr;
	}
    
    
}
@end
