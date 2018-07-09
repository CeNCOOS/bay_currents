//
//  SfsuViewController.m
//  Sfsu
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import "SfsuViewController.h"
#import <AudioToolbox/AudioServices.h> 

@implementation SfsuViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (![RMSTracker existRecordstore:@"accepted_use"])
	{
		UIAlertView* disclaimerView = [[UIAlertView alloc] initWithTitle:@"SF Bay Currents Disclaimer"
															message:@"This app is for informational purposes only, and is not to be used for navigation."  
														   delegate:self 
												  cancelButtonTitle:@"I disagree"
												  otherButtonTitles:@"I agree" , nil];
		[disclaimerView show];
	}

	screen = -1;
	
	mView = [[MapView alloc] init];
	aView = [[AboutView alloc] init];
	
	[self updateData];
	
	//cria o timer
	[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateData) userInfo:nil repeats:YES];
	
}

	
-(void)updateData
{
	lastUpdate = [RMSTracker loadSafeString:@"last_update"];
	
	NSURL* url = [NSURL URLWithString:@"http://www.jumpfox.com:8080/sfsu/gl"];
	
	NSString* currentUpdate = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	
	if ((lastUpdate == nil) || (![lastUpdate isEqualToString:currentUpdate]))
	{
		[RMSTracker saveString:@"last_update":currentUpdate];
		
		//get the xml
		NSURL *url = [ NSURL URLWithString:@"http://www.jumpfox.com/data_sea.zip"];
		
		NSString *pathZip = [NSTemporaryDirectory() stringByAppendingPathComponent:@"data_sea.zip"];
		NSString *pathXml = [NSTemporaryDirectory() stringByAppendingPathComponent:@"data_sea.xml"];
		
		[[NSData dataWithContentsOfURL:url] writeToFile:pathZip atomically:TRUE];
		
		ZipArchive* zip = [[ZipArchive alloc] init];
		[zip UnzipOpenFile:pathZip];
		[zip UnzipFileTo:NSTemporaryDirectory() overWrite:TRUE];
		[zip UnzipCloseFile];
		
		NSString* xml = [NSString stringWithContentsOfFile:pathXml encoding:NSUTF8StringEncoding error:nil];
		
		[RMSTracker saveString:@"last_xml":xml];
		
		[seaSpeed release];
	
		//get the XML and parse
		seaSpeed = [SfsuXMLParser getData:xml];
	}
	
	if ((seaSpeed == nil) && ([RMSTracker existRecordstore:@"last_xml"]))
	{
		NSString* xml = [RMSTracker loadSafeString:@"last_xml"];
		
		[seaSpeed release];
		
		//get the XML and parse
		seaSpeed = [SfsuXMLParser getData:xml];		
	}
	
	if (seaSpeed == nil)
	{
		UIAlertView* errorView = [[UIAlertView alloc] initWithTitle:@"SF Bay Currents could not access the intertet"
															message:@"Make sure you have an internet connection and try again."  
														   delegate:self 
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil , nil];
		
		[errorView show];
	}
	
	if (screen == -1)
		[self setScreen:0];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(SeaSpeed*) getSeaSpeed
{
	return seaSpeed;
}

-(void)setScreen:(int) newScreen
{
	screen = newScreen;
	
	if (screen == 0)
	{
		[mView configure:self];
	}
	else if (screen == 1)
	{
		[aView configure:self];
	}
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	if ([item.title isEqualToString: @"Map"])
		[self setScreen:0];
	else if ([item.title isEqualToString: @"About"]) 
		[self setScreen:1];	
}



-(void) alertView:(UIAlertView*) alertView clickedButtonAtIndex: (NSInteger) buttonIndex
{
	if (buttonIndex == 0)
		exit(0);
	else
		[RMSTracker saveString:@"accepted_use" :@"yes"];
}

@end
