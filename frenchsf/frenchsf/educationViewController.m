//
//  educationViewController.m
//  frenchsf
//
//  Created by Joshua Atkin on 5/30/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "educationViewController.h"
#import "randomClassViewController.h"

@interface educationViewController ()

@end

@implementation educationViewController
{
    NSArray *classes;
    
}

- (IBAction)goToAFSF:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.afsf.com"]];
}


// we write this in

- (void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    
    

    
}

// get a random number between 0 and classes count  - 1






- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"getRandomClass"]) {
        
        // get file path
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"classes" ofType:@"plist"];
        // use to import plist and read into array
        
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        classes = [dict valueForKey:@"Classes"];
        
        //[classes count];
        
        randomClassViewController *destViewController = segue.destinationViewController;
        
        int myRandom = 0 + arc4random() % ([classes count] - 1);
        
        //NSLog(@"%d", myRandom);
        
        destViewController.randomClassTitle   = [[classes objectAtIndex:myRandom] valueForKey:@"Name"];
        destViewController.randomClassDescription = [[classes objectAtIndex:myRandom] valueForKey:@"Description"];
        destViewController.randomClassWeblink = [[classes objectAtIndex:myRandom] valueForKey:@"Weblink"];
        
        
    }
}


@end
