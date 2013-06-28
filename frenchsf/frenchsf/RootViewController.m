//
//  RootViewController.m
//  MWFeedParser
//
//  Copyright (c) 2010 Michael Waterfall
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//  
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the 
//     purpose of any concept relating to diary/journal keeping.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RootViewController.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "DetailTableViewController.h"
#import <EventKit/EventKit.h>

@implementation RootViewController

@synthesize itemsToDisplay;




#pragma mark -
#pragma mark View lifecycle



- (void)viewDidLoad {
		
	// Super
	[super viewDidLoad];
	
    [DejalBezelActivityView activityViewForView:self.view];
    
    
	// Setup
	//self.title = @"Loading...";
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	parsedItems = [[NSMutableArray alloc] init];
	self.itemsToDisplay = [NSArray array];
	
	// Refresh button
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																							target:self 
																							action:@selector(refresh)];
	
    
     // Parse
	//NSURL *feedURL = [NSURL URLWithString:@"http://afsanfrancisco.wordpress.com/feed/"];
 
	//NSURL *feedURL = [NSURL URLWithString:@"https://www.google.com/calendar/feeds/d2uvsthk39g288vvdvbl42uppo%40group.calendar.google.com/public/basic"];
//    NSURL *feedURL = [NSURL URLWithString:@"https://www.facebook.com/feeds/page.php?id=208525485883563&format=rss20"];
    
    // AFSF calendar
    //	NSURL *feedURL = [NSURL URLWithString:@"https://www.google.com/calendar/feeds/afsf2009%40gmail.com/public/basic"];

    
    // My own event list
    NSURL *feedURL = [NSURL URLWithString:@"https://www.google.com/calendar/feeds/np0fv05nqu957c0dobuaj19se4%40group.calendar.google.com/public/basic"];

    
    

	
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
	feedParser.delegate = self;
	feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
	feedParser.connectionType = ConnectionTypeAsynchronously;
	[feedParser parse];
    
    

}

#pragma mark -
#pragma mark Parsing

 
// Reset and reparse
- (void)refresh {
	//self.title = @"Refreshing...";
	[parsedItems removeAllObjects];
	[feedParser stopParsing];
	[feedParser parse];
	self.tableView.userInteractionEnabled = NO;
	//self.tableView.alpha = .3;
   // self.tableView.backgroundColor = [UIColor lightGrayColor];
    [DejalBezelActivityView activityViewForView:self.view];
}

- (void)updateTableWithParsedItems {
	self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date" 
																				 ascending:NO]]];
	self.tableView.userInteractionEnabled = YES;
	//self.tableView.alpha = 1;
    self.tableView.backgroundColor = [UIColor whiteColor];
	[self.tableView reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
}
 
 

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
	//NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
	//NSLog(@"Parsed Feed Info: “%@”", info.title);
	//self.title = info.title;
   
    [DejalBezelActivityView removeViewAnimated:YES];
    self.title =  @"Events";
    
    

    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	//NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item) [parsedItems addObject:item];

}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
	//NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
  [self updateTableWithParsedItems];

}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	//NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                         message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                        delegate:nil
                                               cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles:nil] ;
        [alert show];
    }
 [self updateTableWithParsedItems];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsToDisplay.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
     //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	// Configure the cell.
	MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    

    
	if (item) {
		
		// Process
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
     //   NSString *itemContent = item.content ? [item.content stringByConvertingHTMLToPlainText] : @"[No Content]";
        
     
		
		// Set
		cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
		cell.textLabel.text = itemTitle;
	//	NSMutableString *subtitle = [NSMutableString string];
	//	if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
	//	[subtitle appendString:itemSummary];
	//	cell.detailTextLabel.text = subtitle;
        
        cell.detailTextLabel.numberOfLines = 2;
      	cell.detailTextLabel.text = itemSummary;
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Heavy" size:18.0f];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir" size:14.0f];
        
       // NSLog(@"%@",itemSummary);
        
        // if date is prior to today then gray it out
        
        ///Parsing out date
        NSString *myDateString = itemSummary;
        
        NSError *error = nil;
        
       
        
        NSDataDetector *detector =  [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeDate error:&error];
      //  NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:&error];

        
        NSArray *matches = [detector matchesInString:myDateString options:0 range:NSMakeRange(0, [myDateString length])];
        for (NSTextCheckingResult *match in matches) {
            NSDate *today = [NSDate date]; // it will give you current date
            NSComparisonResult result;
            //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
            result = [today compare:match.date]; // comparing two dates
            
            if(result==NSOrderedAscending) {
            //    NSLog(@"today is less");
                cell.userInteractionEnabled = YES;
                cell.textLabel.enabled = YES;
            }
            else if(result==NSOrderedDescending) {
            //    NSLog(@"newDate is less");
               cell.userInteractionEnabled = NO;
               cell.textLabel.enabled = NO;
            }
            else
                NSLog(@"Both dates are same");
            
            
        }
        
		
	}
    return cell;
}

//#pragma mark -
//#pragma mark Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	// Show detail
	DetailTableViewController *detail = [[DetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	detail.item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:detail animated:YES];
	
	
	// Deselect


	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Add Event"];

    
    
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
	
		

    
    clickedEventTitle =    item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
    clickedEventSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
    clickedEventContent = item.content ? [item.content stringByConvertingHTMLToPlainText] : @"[No Content]";
    
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
        event.notes = clickedEventContent;

        ///Parsing out date
      
        
        NSError *error = nil;
        
        NSDataDetector *dateDetector =[NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeDate error:&error];
      //  NSDataDetector *dateDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:&error];
  
        NSArray *matches = [dateDetector matchesInString:clickedEventSummary options:0 range:NSMakeRange(0, [clickedEventSummary length])];
        for (NSTextCheckingResult *match in matches) {
            NSLog(@"Detected Date: %@", match.date);           // => 2011-11-24 14:00:00 +0000
    //        NSLog(@"Detected Time Zone: %@", match.timeZone);  // => (null)
    //        NSLog(@"Detected Duration: %f", match.duration);   // => 0.000000
            
            //eventDuration = match.duration;
            event.startDate = match.date;
            event.timeZone = match.timeZone;
            event.endDate   = [[NSDate alloc] initWithTimeInterval:match.duration sinceDate:event.startDate];
            
            
        }
        
       // NSDataDetector *addressDectetor = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress error:&error];
       
        
        // Lets leave out the adress right now utnil I figure it out
        /*
        
        NSDataDetector *addressDetector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeLink error:&error];
        
        NSArray *matchAddress = [addressDetector matchesInString:clickedEventContent options:0 range:NSMakeRange(0, [clickedEventContent length])];
        for (NSTextCheckingResult *match in matchAddress) {
            NSLog(@"Detected Address: %@", match.addressComponents);
            event.location = match.addressComponents;
        }
        
        */
     
        
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



@end
