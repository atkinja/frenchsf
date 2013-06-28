//
//  linksViewController.h
//  frenchsf
//
//  Created by Joshua Atkin on 6/20/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DejalActivityView.h"

@interface linksViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *linksWebsite;
- (IBAction)backToLinks:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *linksNavBar;


@end
