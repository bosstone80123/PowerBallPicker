//
//  PBWViewController.m
//  Powerball Winner
//
//  Created by Jon Slaughter on 9/10/13.
//  Copyright (c) 2013 Jon Slaughter. All rights reserved.
//

#import "PBWViewController.h"

@interface PBWViewController ()

@end

@implementation PBWViewController
@synthesize greeting, webData, soapResults, xmlParser;

- (IBAction)randomnumber {
    int rNumber1 = 1 + rand() % 69;
    int rNumber2 = 1 + rand() % 69;
    int rNumber3 = 1 + rand() % 69;
    int rNumber4 = 1 + rand() % 69;
    int rNumber5 = 1 + rand() % 69;
    int rNumber6 = 1 + rand() % 26;
    textviewquickpick1.text  = [[NSString alloc] initWithFormat:@"%d", rNumber1];
    textviewquickpick2.text  = [[NSString alloc] initWithFormat:@"%d", rNumber2];
    textviewquickpick3.text  = [[NSString alloc] initWithFormat:@"%d", rNumber3];
    textviewquickpick4.text  = [[NSString alloc] initWithFormat:@"%d", rNumber4];
    textviewquickpick5.text  = [[NSString alloc] initWithFormat:@"%d", rNumber5];
    textviewquickpick6.text  = [[NSString alloc] initWithFormat:@"%d", rNumber6];
}

- (IBAction)PostToFacebook:(id)sender {
    mySLComposerSheet = [[SLComposeViewController alloc] init];
    mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [mySLComposerSheet setInitialText:@"Post Winnings Here:"];
    [self presentViewController:mySLComposerSheet animated:YES completion:nil];
}

-(IBAction)SendATweet {
    TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc] init];
    [tweet setInitialText:@"Post Winnings Here:"];
    [self presentModalViewController:tweet animated:YES];
}

-(void)winningnumbers:(id)sender{
        //NSString *str = [NSString stringWithContentsOfFile:@"http://www.powerball.com/powerball/winnums-text.txt"];
        //NSString *str = [NSString stringWithContentsOfFile:@"TextTest.txt"];
        //NSArray *arr = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //WinningNums.text = @"testing";//[[NSString alloc] initWithFormat:@"%d", arr];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        //This is for Ipad app
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL
    URLWithString:@"http://www.powerball.com/powerball/winnums-text.txt"]]];
        //This is for Ipad app end
    
    
        
//get jackpot start
    recordResults = FALSE;
	
	NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             //"<soap:Body>\n"
                             //"<PBJackpotResponse xmlns="http://tempuri.org/">\n"
                             //"<PBJackpotResult>%@</PBJackpotResult>\n"
                             "</PBJackpotResponse>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n"];
    
    //NSLog(soapMessage);
	
	NSURL *url = [NSURL URLWithString:@"http://www.sceducationlottery.com/webservices/get.asmx/PBJackpot"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://www.sceducationlottery.com/webservices/get.asmx/PBJackpot" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
        {
		webData = [NSMutableData data];        }
	else
        {
		NSLog(@"theConnection is NULL");
        }
	
	[greeting resignFirstResponder];
    
    
    
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
        //[connection release];
        //[webData release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
	//NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	//NSLog(theXML);
        //[theXML release];
	
	if( xmlParser )
        {
            //[xmlParser release];
        }
	
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities: YES];
	[xmlParser parse];
	
        //[connection release];
        //[webData release];

}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	if( [elementName isEqualToString:@"string"])
        {
		if(!soapResults)
            {
			soapResults = [[NSMutableString alloc] init];
            }
		recordResults = TRUE;
        }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if( recordResults )
        {
		[soapResults appendString: string];
        }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if( [elementName isEqualToString:@"string"])
        {
		recordResults = FALSE;
		greeting.text = soapResults;
            //[soapResults release];
            //soapResults = nil;
        soapResults = greeting.text;
        }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
        // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//get Jackpot end

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

- (void)bannerView:(ADBannerView *)
banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

@end


