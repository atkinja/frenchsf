//
//  feedbackViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/27/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "feedbackViewController.h"
#import <Parse/Parse.h>

@interface feedbackViewController ()

@end

@implementation feedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_activityIndicator setHidden:TRUE];
    [_activityIndicator setHidesWhenStopped:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)submitForm:(UIButton *)sender  {
    
 
    
    [PFUser enableAutomaticUser];
    PFACL *defaultACL = [PFACL ACL];
    // Optionally enable public read access while disabling public write access.
    // [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    

  
    [[PFUser currentUser] setObject:_nameOutlet.text forKey:@"name"];
    [[PFUser currentUser] setObject:_emailOutlet.text forKey:@"email"];
    [[PFUser currentUser] setObject:_locationOutlet.text forKey:@"location"];
    [[PFUser currentUser] setObject:_birthdayOutlet.text forKey:@"birthday"];
    [[PFUser currentUser] setObject:_genderOutlet.text forKey:@"gender"];
    
  [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      if (error) {
          NSLog(@" error is %@", error);
          
          UIAlertView *alert = [[UIAlertView alloc] init] ;
          [alert setTitle:@"Error!"];
          
          [alert setMessage:@"Please double check your fields"];
          [alert setDelegate:self];
          [alert addButtonWithTitle:@"Ok"];
          [alert show];
          
      } else {
           [self dismissViewControllerAnimated:YES completion:NULL];
      }
      
      
  }];
 
   
        

    
     
    
    
    
 
}

- (IBAction)cancelForm:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)facebookAutoLoad:(UIButton *)sender {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_birthday", @"user_location", @"email"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
            
          [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        }  else {
          //  NSLog(@"User with facebook logged in!");
            
            
        //    [_facebookButton setHidden:TRUE];
            
            
            
            // Send request to Facebook
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                // handle response
                if (!error) {
                    // Parse the data received
                    NSDictionary *userData = (NSDictionary *)result;
                    NSString *facebookID = userData[@"id"];
                    NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
                    
                    if (facebookID) {
                        userProfile[@"facebookId"] = facebookID;
                    }
                    
                    
                    if (userData[@"email"]) {
                        userProfile[@"email"] = userData[@"email"];
                    }
                    
                    
                    if (userData[@"name"]) {
                        userProfile[@"name"] = userData[@"name"];
                    }
                    
                    if (userData[@"location"][@"name"]) {
                        userProfile[@"location"] = userData[@"location"][@"name"];
                    }
                    
                    if (userData[@"gender"]) {
                        userProfile[@"gender"] = userData[@"gender"];
                    }
                    if (userData[@"birthday"]) {
                        userProfile[@"birthday"] = userData[@"birthday"];
                    }
                    
                    NSString *userFBID;
                    if (facebookID) {
                        userFBID = facebookID;
                    }
                    
                    NSString *userEmail;
                    
                    if (userData[@"email"]) {
                        userEmail = userData[@"email"];
                    }
                    
                    _emailOutlet.text = userEmail;
                    
                    NSString *userName;
                    if (userData[@"name"]) {
                        userName = userData[@"name"];
                    }
                    
                    _nameOutlet.text = userName;
                    
                    NSString *userLocation;
                    if (userData[@"location"][@"name"]) {
                        userLocation = userData[@"location"][@"name"];
                    }
                    
                    _locationOutlet.text = userLocation;
                    
                    NSString *userGender;
                    if (userData[@"gender"]) {
                        userGender = userData[@"gender"];
                    }
                    
                    _genderOutlet.text = userGender;
                    
                    NSDate *userBirthday;
                    if (userData[@"birthday"]) {
                        userBirthday = userData[@"birthday"];
                    }
                    
                    _birthdayOutlet.text = (NSString*)userBirthday;
                    
                    // adding FB ID
                    
                 //   [[PFUser currentUser] setObject:userFBID forKey:@"facebookID"];
                    
                    // adding profile
                    
                 //   [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
                    
                    // adding email address
                    
                 //   [[PFUser currentUser] setObject:userEmail forKey:@"email"];
                    
                    
                    // adding name
                    
                 //   [[PFUser currentUser] setObject:userName forKey:@"name"];
                    
                    
                    // adding Location
                    
                 //   [[PFUser currentUser] setObject:userLocation forKey:@"location"];
                    
                    // adding Gender
                    
                  //  [[PFUser currentUser] setObject:userGender forKey:@"gender"];
                    
                    // adding Birthday
                    
                  //  [[PFUser currentUser] setObject:userBirthday forKey:@"birthday"];
                    
                    
                    // save in background to Parse
                    
                  //  [[PFUser currentUser] saveInBackground];
                    
                    
                } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                            isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
                    NSLog(@"The facebook session was invalidated");
                    //     [self logoutButtonTouchHandler:nil];
                } else {
                    NSLog(@"Some other error: %@", error);
                }
            }];
            
            
            
            
            
            
        }
    }];
    
    [_fbLoginButton setHidden:TRUE];
    [_activityIndicator setHidden:FALSE];
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
    
}

- (IBAction)getFeedback:(UIButton *)sender {
    
    if ([MFMailComposeViewController canSendMail])
    {
        
        // Email Subject
        NSString *emailTitle = @"Feedback to French SF iOS Application";
        // Email Content
        NSString *messageBody = @"Please enter your comments here.";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"admin@frenchsf.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
    } else
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://docs.google.com/spreadsheet/embeddedform?formkey=dFJzaFFfdUdKQXBLVU9uUkpyZmREdUE6MA"]];
}



- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
