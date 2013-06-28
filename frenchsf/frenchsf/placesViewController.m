//
//  placesViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/14/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "placesViewController.h"
#import "detailPlacesViewController.h"

@interface placesViewController ()
{
    NSArray *places;
    
}

@end

@implementation placesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


// we write this in

- (void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    
    
    self.title = @"Places";
    
    
    // get file path
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"places" ofType:@"plist"];
    // use to import plist and read into array
    
        
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    places = [dict valueForKey:@"Places"];
 
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
      return [places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"placesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [[places objectAtIndex:indexPath.row] valueForKey:@"Name"];
    cell.textLabel.numberOfLines = 2;
    cell.detailTextLabel.text = [[places objectAtIndex:indexPath.row] valueForKey:@"Weblink"];
    cell.detailTextLabel.numberOfLines = 2;
    
 //   cell.imageView.autoresizingMask = ( UIViewAutoresizingNone );
 //   cell.imageView.autoresizesSubviews = NO;
 //   cell.imageView.contentMode = UIViewContentModeCenter;
 //   cell.imageView.bounds = CGRectMake(0, 0, 50, 50);
 //   cell.imageView.frame = CGRectMake(0, 0, 50, 50);
    
    cell.imageView.image = [UIImage imageNamed:[[places objectAtIndex:indexPath.row] valueForKey:@"ImageFile"]];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Heavy" size:18.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir" size:14.0f];
    
    
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlacesDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailPlacesViewController *destViewController = segue.destinationViewController;
     
        destViewController.placeDescription = [[places objectAtIndex:indexPath.row] valueForKey:@"Description"];
        destViewController.placeDescriptionFr = [[places objectAtIndex:indexPath.row] valueForKey:@"DescriptionFrench"];
        destViewController.placeLatitude = [[[places objectAtIndex:indexPath.row] valueForKey:@"Latitude"] doubleValue];
        destViewController.placeLongitude = [[[places objectAtIndex:indexPath.row] valueForKey:@"Longitude"] doubleValue];
        destViewController.placeTitle = [[places objectAtIndex:indexPath.row] valueForKey:@"Name"] ;
        destViewController.audioFile = [[places objectAtIndex:indexPath.row] valueForKey:@"AudioFile"] ;
     
        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
