//
//  facebookViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/18/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "facebookViewController.h"

@interface facebookViewController ()

@end

@implementation facebookViewController

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

    // Load facebook data
    NSString *fbUrlAddress = @"https://m.facebook.com/pages/Alliance-Fran%C3%A7aise-de-San-Francisco/208525485883563?ref=br_tf"; // here you put your own group
    //Create a URL object.
    NSURL *fbUrl = [NSURL URLWithString:fbUrlAddress];
  //  NSString *webHTMLfb = [NSString stringWithContentsOfURL:fbUrl encoding:NSUTF8StringEncoding error:NULL];
    //NSLog(@"webHTML of facebook: %@", webHTMLfb);
    //URL Requst Object
    NSURLRequest *fbRequestObj = [NSURLRequest requestWithURL:fbUrl];
    //Load the request in the UIWebView.
    [self.fbWebView setScalesPageToFit:YES];
    [self.fbWebView loadRequest:fbRequestObj];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
