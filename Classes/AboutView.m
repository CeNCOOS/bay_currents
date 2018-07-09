//
//  PastView.m
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "AboutView.h"
#import "SfsuViewController.h"

@implementation AboutView

-(void) configure:(UIViewController*) parent
{
	controller = parent;
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[UIScrollView alloc]init];
		mother.frame = [SizePositionConstants getMotherFrame];
		mother.backgroundColor = [UIColor clearColor];
		
		bg = [[UIImageView alloc] initWithFrame: [SizePositionConstants getMotherFrame]];
		bg.image = [UIImage imageNamed:@"about.png"];
		[mother addSubview:bg];
		
		link = [[UIButton alloc] initWithFrame: [SizePositionConstants getAboutLinkFrame]];
		//link.backgroundColor = [UIColor yellowColor];
		//link.alpha = 0.5;
		[link addTarget:self action:@selector(openLink)  forControlEvents:UIControlEventTouchUpInside]; 
		[mother addSubview:link];
		
		menuBar = [[UITabBar alloc]initWithFrame:[SizePositionConstants getMenuBarFrame]];
		menuBar.delegate = (SfsuViewController*)controller;
		menuBar.alpha = 0.8;
		
		NSMutableArray* items = [[NSMutableArray alloc] init];
		
		item = [[UITabBarItem alloc]init];
		item.image = [UIImage imageNamed:@"globe.png"];  
		item.title = @"Map";
		[items addObject:item];
		
		item2 = [[UITabBarItem alloc]init];
		item2.image = [UIImage imageNamed:@"info.png"];
		item2.title = @"About";
		[items addObject:item2];
		
		menuBar.items = items;
		
		[mother addSubview:menuBar];
	}
	
	menuBar.selectedItem = item2;
	
	if ([[controller.view subviews] count] > 0)
		[[[controller.view subviews] objectAtIndex:0] removeFromSuperview];
	
	[controller.view addSubview:mother];
}

-(void) openLink
{
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"http://www.norcalcurrents.org/COCMP/Real-Time%20Currents.html"]];
}

@end
