//
//  randomClassViewController.h
//  frenchsf
//
//  Created by Joshua Atkin on 6/15/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 

@interface randomClassViewController : UIViewController <MFMailComposeViewControllerDelegate>


- (IBAction)goBack:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UILabel *randomClassOutlet;

@property (weak, nonatomic) IBOutlet UITextView *randomClassDescrOutlet;

- (IBAction)goToRandomClassWebPage:(id)sender;

- (IBAction)contactAFSF:(UIButton *)sender;



@property (nonatomic, strong) NSString *randomClassTitle, *randomClassDescription, *randomClassWeblink;



@end
