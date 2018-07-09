//
//  untitled.m
//  Sfsu
//
//  Created by Guilherme Carvalho on 27/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "SfsuXMLParser.h"

@implementation SfsuXMLParser

+(SeaSpeed*) getData:(NSString*) xml
{	
	XMLParser* parser = [[XMLParser alloc]init];
	TreeNode* element = [parser parseXMLfromString:xml];
	
	SeaSpeed* seaSpeed = [[SeaSpeed alloc]init];
	
	//this is to get the data and understand it in gmt-8
	//remember if printing, you need to do the same
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy_MM_dd_HHmm"];
	[df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	
	NSMutableArray* files = [seaSpeed getFiles];	
	
	for (int i = 0; i< [element.children count]; i++)
	{
		TreeNode* fileElement = [element.children objectAtIndex:i];
		
		SeaFile* file = [[SeaFile alloc]init];
		file.index = [[fileElement objectForKey:@"index"].text intValue];
		file.time = [[df dateFromString: [fileElement objectForKey:@"time"].text]retain];	
			
		NSMutableArray* buoys = [file getBuoys];	
		
		NSString* data = [[fileElement objectForKey:@"data"].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		NSArray* listData = [data componentsSeparatedByString:@"\n"];
		
		for (int j=0; j<[listData count]; j++)
		{
			Buoy* b = [[Buoy alloc] initWithString: [listData objectAtIndex:j]];
			[buoys addObject:b];
		}
		
		[files addObject:file];
	}

	return seaSpeed;
}

@end 
