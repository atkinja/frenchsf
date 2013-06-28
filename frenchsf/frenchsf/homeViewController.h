//
//  homeViewController.h
//  frenchsf
//
//  Created by Joshua Atkin on 6/4/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 

@interface homeViewController : UIViewController <MFMailComposeViewControllerDelegate>

// Added for Facebook

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)loginButtonTouchHandler:(id)sender;


- (IBAction)getFeedback:(UIButton *)sender;


@end
