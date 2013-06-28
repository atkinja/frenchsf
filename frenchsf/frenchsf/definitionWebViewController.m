//
//  definitionWebViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 6/23/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "definitionWebViewController.h"


@interface definitionWebViewController ()

@end

@implementation definitionWebViewController

@synthesize  definitionUIWebView;

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
    
    definitionUIWebView.delegate = self;
    

    /// To remove accents
    NSString *unaccentedString = [_definitionWord stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];

    


    
    
    
    // Create full URL string
    NSString *myURL = [@"http://www.wordreference.com/fren/" stringByAppendingString:unaccentedString];
 
    //Remove any whitespaces
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *tempString = [myURL stringByTrimmingCharactersInSet:characterSet];
    
    //NSLog(@"%@", tempString);
    
    //  Defining the URL
    NSURL *url = [NSURL URLWithString:tempString];
    
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.definitionUIWebView setScalesPageToFit:YES];
    [self.definitionUIWebView loadRequest:requestObj];


    
    
}



- (void) webViewDidStartLoad:(UIWebView *)webView {
    
    [DejalBezelActivityView activityViewForView:self.view];

    
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
   // webView = definitionUIWebView;
    [DejalBezelActivityView removeViewAnimated:YES];
    
    
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [DejalBezelActivityView removeViewAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
