//
//  MainViewController.m
//  KMRSS
//
//  The MIT License
//
//  Copyright Kieran McGrady(c)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
//  Software, and to permit persons to whom the Software is furnished to do so, subject
//  to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
//  OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "eventsViewController.h"
#import <EventKit/EventKit.h>
#import "NSString+HTML.h"
#import "MWFeedParser.h"





@implementation eventsViewController;
@synthesize dataArray = _dataArray, progressInd;

double eventDuration;




/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (UIActivityIndicatorView *)progressInd {
    if (progressInd == nil)
    {
        CGRect frame = CGRectMake(self.view.frame.size.width/2-15, self.view.frame.size.height/2-15, 30, 30);
       // CGRect frame = CGRectMake(0, 0, 200, 200);
        
        progressInd = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        [progressInd startAnimating];
        progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [progressInd sizeToFit];
        progressInd.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleRightMargin |
                                        UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleBottomMargin);
        
        progressInd.tag = 1;    // tag this view for later so we can remove it from recycled table cells
    }
    return progressInd;
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Set tableview row height
  //  self.tableView.rowHeight = 65;
    
    /* Create the parser and initialize with the feed URL. The URL must start with http:// . If it starts
     with feed:// change it to http:// */

    
 
    
    /*
    
    //I create the activity indicator
    UIActivityIndicatorView *ac = [[UIActivityIndicatorView alloc]
                                   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [ac startAnimating];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(160, 160, 50, 50)];
    [view addSubview:ac]; // <-- Your UIActivityIndicatorView
    self.tableView.tableHeaderView = view;
   */
    
    
    
    
  //  [self.view addSubview:self.progressInd];
   
  //  [self.tableView addSubview:self.progressInd];
    
    
  

    //  self.tableView.tableHeaderView = view;
    
   // [self populateTable];
    
   // [self.progressInd removeFromSuperview];
    
    
   /*
    
    UIActivityIndicatorView *activityIndcator = [[UIActivityIndicatorView alloc]
                                                 initWithFrame:CGRectMake(0,0,20,20)];
    self.progressInd = activityIndcator;
    progressInd.hidesWhenStopped = YES; // this is the default, but never hurts to be sure
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:progressInd];
    self.navigationItem.rightBarButtonItem = activityItem;
    
    
    [self.progressInd startAnimating];
    */
    
   // [DejalBezelActivityView activityViewForView:self.tableView];
    [self populateTable];
  //  [DejalBezelActivityView removeViewAnimated:YES];
    
    NSLog(@"View did load");

}







-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"View did appear");
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];


     NSLog(@"View will appear");
  
    
}



- (void)populateTable {
    NSURL *feedURL = [NSURL URLWithString:@"https://www.google.com/calendar/feeds/d2uvsthk39g288vvdvbl42uppo%40group.calendar.google.com/public/basic"];
  //    NSURL *feedURL = [NSURL URLWithString:@"https://www.facebook.com/feeds/page.php?id=11510137267&format=rss20"];
   


    KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:feedURL delegate:self];
    //To get the result and store it in an array call the parser 'posts' method
    self.dataArray = [parser posts];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}







- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    

    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
   
    
  
    
    
    cell.detailTextLabel.text =   [[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"summary"] stringByConvertingHTMLToPlainText];
    
    
    cell.detailTextLabel.numberOfLines = 2;
    
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Heavy" size:18.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir" size:14.0f];
  
 
    
    
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Add Event"];
    
    clickedEventTitle =    [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    clickedEventSummary = [[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"summary"] stringByConvertingHTMLToPlainText];
    
    [alert setMessage:clickedEventTitle];
    
 
    
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
    
    // maybe
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // creave event
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        event.title     = clickedEventTitle;
        
        
        
        
        
        ///Parsing out date
        NSString *myDateString = clickedEventSummary;
        
        NSError *error = nil;
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeDate error:&error];
        
     //   NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:&error];
        NSArray *matches = [detector matchesInString:myDateString options:0 range:NSMakeRange(0, [myDateString length])];
        for (NSTextCheckingResult *match in matches) {
            NSLog(@"Detected Date: %@", match.date);           // => 2011-11-24 14:00:00 +0000
            NSLog(@"Detected Time Zone: %@", match.timeZone);  // => (null)
            NSLog(@"Detected Duration: %f", match.duration);   // => 0.000000
            //eventDuration = match.duration;
            event.startDate = match.date;
            event.timeZone = match.timeZone;
            event.endDate   = [[NSDate alloc] initWithTimeInterval:match.duration sinceDate:event.startDate];
  
            
        }
        
        
        /// end of parsing out date
        
        
          //event.startDate = [[NSDate alloc] init];
          
        
        
        
        
        
        
        
      
        
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
 
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
   
        
        
        
        
    }
    else if (buttonIndex == 1)
    {
        // No
        NSLog(@"NO was clicked");
    }
}

#pragma mark - Parser delegate

- (void)parserDidFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)parserCompletedSuccessfully
{
    NSLog(@"Parse complete. You may need to reload the table view to see the data.");
}

- (void)parserDidBegin
{
    NSLog(@"Parsing has begun");
}
 

@end
