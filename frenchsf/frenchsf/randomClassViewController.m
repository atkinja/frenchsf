//
//  randomClassViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/15/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "randomClassViewController.h"

@interface randomClassViewController ()

@end

@implementation randomClassViewController

@synthesize randomClassTitle, randomClassDescription, randomClassWeblink, randomClassDescrOutlet, randomClassOutlet;

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
    
    randomClassOutlet.text = randomClassTitle;
    randomClassDescrOutlet.text = randomClassDescription;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)goToRandomClassWebPage:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:randomClassWeblink]];
}

- (IBAction)contactAFSF:(UIButton *)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        // Email Subject
        NSString *emailTitle =   [@"From FrenchSF iPhone App:  Question about " stringByAppendingString:randomClassTitle];
        // Email Content
        NSString *messageBody = @"Please enter your questions and comments about the class here.";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"afsf@afsf.com"];
    
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
    
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    } else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://docs.google.com/spreadsheet/embeddedform?formkey=dFJzaFFfdUdKQXBLVU9uUkpyZmREdUE6MA"]];
        
    }
        
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
