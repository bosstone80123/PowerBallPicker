//
//  TodayViewController.h
//  Powerball Jackpot
//
//  Created by Jon Slaughter on 1/21/15.
//  Copyright (c) 2015 Jon Slaughter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TodayViewController : UIViewController{
        //For Connecting to Webservice start
    IBOutlet UILabel *greeting;
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    BOOL *recordResults;
        //For Connecting to Webservice end
}
    //For Connecting to Webservice start
@property(nonatomic, retain) IBOutlet UILabel *greeting;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
    //For Connecting to Webservice end

@end
