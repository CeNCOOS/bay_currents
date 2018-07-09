//
//  LocalTeam.m
//  Sfsu
//
//  Created by Guilherme Carvalho on 27/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "SeaSpeed.h"


@implementation SeaSpeed


-(NSMutableArray*) getFiles
{
	if (files == nil)
		files = [[NSMutableArray alloc] init];
	
	return files;
}

@end
