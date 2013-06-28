//
//  definitionWebViewController.h
//  frenchsf
//
//  Created by Joshua Atkin on 6/23/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailPlacesViewController.h"
#import "DejalActivityView.h"

@interface definitionWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *definitionUIWebView;

@property (nonatomic, strong) NSString *definitionWord;


@end
