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




@implementation eventsViewController;
@synthesize dataArray = _dataArray;




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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    // Set tableview row height
    self.tableView.rowHeight = 65;
    
    /* Create the parser and initialize with the feed URL. The URL must start with http:// . If it starts
     with feed:// change it to http:// */

    NSURL *feedURL = [NSURL URLWithString:@"https://www.google.com/calendar/feeds/d2uvsthk39g288vvdvbl42uppo%40group.calendar.google.com/public/basic"];
 //   NSURL *feedURL = [NSURL URLWithString:@"https://www.google.com/calendar/embed?src=afsf2009@gmail.com"];
    
    
    
    
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
    cell.detailTextLabel.text =   [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"summary"];
    
    cell.detailTextLabel.numberOfLines = 2;
  
 
    
    
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Add Event"];
    
    clickedEventTitle =    [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    [alert setMessage:clickedEventTitle];
    
 
    
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
   
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // creave event
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        event.title     = clickedEventTitle;
        
        
        event.startDate = [[NSDate alloc] init];
        event.endDate   = [[NSDate alloc] initWithTimeInterval:600 sinceDate:event.startDate];
        
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
 
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        NSLog(@" start date %@", event.startDate);
        NSLog(@"Successfully added to the calendar");
        
        
        
        
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
