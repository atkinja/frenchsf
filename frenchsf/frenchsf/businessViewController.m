//
//  businessViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/11/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "businessViewController.h"

@interface businessViewController ()

@end

@implementation businessViewController

- (IBAction)gotoSite:(UIButton *)sender {
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.faccsf.com"]];
}



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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
