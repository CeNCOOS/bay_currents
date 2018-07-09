//
//  MkAnnotationArrow.h
//  Sfsu
//
//  Created by Guilherme Carvalho on 18/02/11.
//  Copyright 2011 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Buoy : NSObject <MKAnnotation> {

	CLLocationCoordinate2D coordinate;
	double u;
	double v;
	double latitude;
	double longitude;
	
	double angle;
	double angle1;
	double angle2;	
	double hipot;
	double u0;
	double v0;
	double u1;
	double v1;
	double u2;
	double v2;
	
	float red;
	float green;
	
	CGMutablePathRef path;
}

@property (nonatomic, assign) double u;
@property (nonatomic, assign) double v;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) float green;
@property (nonatomic, assign) float red;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) CGMutablePathRef path;
-(Buoy*) initWithString:(NSString*) contents;

@end

