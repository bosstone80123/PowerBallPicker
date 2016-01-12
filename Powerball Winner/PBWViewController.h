//
//  PBWViewController.h
//  Powerball Winner
//
//  Created by Jon Slaughter on 9/10/13.
//  Copyright (c) 2013 Jon Slaughter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@interface PBWViewController : UIViewController
<ADBannerViewDelegate>
{

    SLComposeViewController *mySLComposerSheet;
    IBOutlet UILabel *textviewquickpick1;
    IBOutlet UILabel *textviewquickpick2;
    IBOutlet UILabel *textviewquickpick3;
    IBOutlet UILabel *textviewquickpick4;
    IBOutlet UILabel *textviewquickpick5;
    IBOutlet UILabel *textviewquickpick6;
    IBOutlet UILabel *WinningNums;
        //This control is for the Ipad app
    IBOutlet UIWebView *webview;
        //This control is for the Ipad app end
    
        //For Connecting to Webservice start
    IBOutlet UILabel *greeting;
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	bool *recordResults;
        //For Connecting to Webservice end

}

-(IBAction)randomnumber;
    //-(IBAction)winningnums;
-(IBAction)PostToFacebook:(id)sender;
-(IBAction)SendATweet;
    //For Connecting to Webservice start
@property(nonatomic, retain) IBOutlet UILabel *greeting;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
    //For Connecting to Webservice end
@end
