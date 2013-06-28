//
//  twitterViewController.h
//  frenchsf
//
//  Created by Joshua Atkin on 6/13/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface twitterViewController : UITableViewController {
    NSArray *tweets;
}

- (void)fetchTweets;

@end
