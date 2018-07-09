//
//  Game.m
//  Sfsu
//
//  Created by Guilherme Carvalho on 27/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "SeaFile.h"


@implementation SeaFile

@synthesize index;
@synthesize time;

-(NSMutableArray*) getBuoys
{
	if (buoys == nil)
		buoys = [[NSMutableArray alloc] init];
	
	return buoys;
}

@end
