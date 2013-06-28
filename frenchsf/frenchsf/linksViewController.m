//
//  linksViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/20/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "linksViewController.h"



@interface linksViewController ()

@end

@implementation linksViewController

@synthesize linksWebsite;

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
    

     linksWebsite.delegate = self;
    


    NSString *linksAddress = @"http://www.frenchsf.com/links.html"; // here you put your own group
    //Create a URL object.
    NSURL *linksUrl = [NSURL URLWithString:linksAddress];
    //  NSString *webHTMLfb = [NSString stringWithContentsOfURL:fbUrl encoding:NSUTF8StringEncoding error:NULL];

    NSURLRequest *fbRequestObj = [NSURLRequest requestWithURL:linksUrl];
    //Load the request in the UIWebView.
    [self.linksWebsite setScalesPageToFit:YES];
    [self.linksWebsite loadRequest:fbRequestObj];
   
    
}


- (void) webViewDidStartLoad:(UIWebView *)webView {

    [DejalBezelActivityView activityViewForView:self.view];

}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [DejalBezelActivityView removeViewAnimated:YES];
   // [DejalBezelActivityView activityViewForView:linksWebsite withLabel:@"Failed" width:70];
    
 // self.navigationController.navigationBar.topItem.title = @"Failed";
  // _linksNavBar.topItem.title = @"Failed";
   // [webView loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
    


    
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
   [DejalBezelActivityView removeViewAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToLinks:(UIBarButtonItem *)sender {
    
 //   [[NSURLCache sharedURLCache] removeAllCachedResponses];
 
    // Load facebook data
    NSString *linksAddress = @"http://www.frenchsf.com/links.html"; // here you put your own group
    //Create a URL object.
    NSURL *linksUrl = [NSURL URLWithString:linksAddress];
    //  NSString *webHTMLfb = [NSString stringWithContentsOfURL:fbUrl encoding:NSUTF8StringEncoding error:NULL];
    
    NSURLRequest *fbRequestObj = [NSURLRequest requestWithURL:linksUrl];
    //Load the request in the UIWebView.
    [self.linksWebsite setScalesPageToFit:YES];
    [self.linksWebsite loadRequest:fbRequestObj];
    _linksNavBar.topItem.title = @"Links";
    
    

}
@end


