//
//  MkAnnotationArrow.m
//  Sfsu
//
//  Created by Guilherme Carvalho on 18/02/11.
//  Copyright 2011 Konkix. All rights reserved.
//

#import "Buoy.h"


@implementation Buoy

@synthesize u, v, longitude, latitude, red, green, path;

- (CLLocationCoordinate2D)coordinate
{
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

-(Buoy*) initWithString:(NSString*) contents;
{
	[super init];
	
	if (contents != nil)
	{		
		contents = [contents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		NSArray* lines = [contents componentsSeparatedByString:@"  "]; 
		
		longitude = [[lines objectAtIndex:0] doubleValue];
		latitude = [[lines objectAtIndex:1] doubleValue];
		u = [[lines objectAtIndex:2] doubleValue];
		v = [[lines objectAtIndex:3] doubleValue];
		
		//calculating the angles
		angle = atan2(u,v);
		angle1 = angle + 0.25;
		angle2 = angle - 0.25;
		
		double maxSpeed = 100;
		
		double speed = sqrt(u*u + v*v);
		
		if (speed >maxSpeed)
			speed = maxSpeed;
		
		if (speed >= (maxSpeed/2))
			red = 1;
		else
			red = (speed/(maxSpeed/2));
		
		if (speed <= (maxSpeed/2))
			green = 1;
		else
			green = (1-((speed-(maxSpeed/2))/(maxSpeed/2)));
		
		//calculating points
		u0 = sin(angle) * 10;
		v0 = cos(angle) * 10;
		
		u1 = sin(angle1) * 7.5;
		v1 = cos(angle1) * 7.5;
		
		u2 = sin(angle2) * 7.5;	
		v2 = cos(angle2) * 7.5;
		
		u0 = u0+10;
		v0 = -v0+10;
		u1 = u1+10;
		v1 = -v1+10;
		u2 = u2+10;
		v2 = -v2+10;
		
		path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, 10, 10);
		CGPathAddLineToPoint(path, NULL, u0, v0); 
		CGPathAddLineToPoint(path, NULL, u1, v1);
		CGPathAddLineToPoint(path, NULL, u0, v0); 
		CGPathAddLineToPoint(path, NULL, u2, v2);
		CGPathAddLineToPoint(path, NULL, u0, v0); 
	}
	
	return self;
}


@end
