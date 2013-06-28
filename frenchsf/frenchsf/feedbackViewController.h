//
//  feedbackViewController.h
//  frenchsf
//
//  Created by Joshua Atkin on 6/27/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import <MessageUI/MessageUI.h> 

@interface feedbackViewController : UIViewController <MFMailComposeViewControllerDelegate>


- (IBAction)submitForm:(UIButton *)sender;

- (IBAction)cancelForm:(UIButton *)sender;

- (IBAction)facebookAutoLoad:(UIButton *)sender;

- (IBAction)getFeedback:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@property (weak, nonatomic) IBOutlet UITextField *nameOutlet;

@property (weak, nonatomic) IBOutlet UITextField *emailOutlet;

@property (weak, nonatomic) IBOutlet UITextField *locationOutlet;

@property (weak, nonatomic) IBOutlet UITextField *birthdayOutlet;

@property (weak, nonatomic) IBOutlet UITextField *genderOutlet;


@end
