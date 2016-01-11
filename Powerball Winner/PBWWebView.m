//
//  PBWWebView.m
//  Powerball Winner
//
//  Created by Jon Slaughter on 11/6/13.
//  Copyright (c) 2013 Jon Slaughter. All rights reserved.
//

#import "PBWWebView.h"

@interface PBWWebView ()

@end

@implementation PBWWebView

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
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL
    URLWithString:@"http://www.powerball.com/powerball/winnums-text.txt"]]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
