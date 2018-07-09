//
//  Game.h
//  Sfsu
//
//  Created by Guilherme Carvalho on 27/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeaFile : NSObject {

	int index;	
	NSDate* time;
	NSMutableArray* buoys;
}

@property(nonatomic, assign) int index;
@property(nonatomic, retain) NSDate* time;
-(NSMutableArray*) getBuoys;

@end
