//
//  MyAnnotation.h
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-11-01.
//  Copyright 2009 JAKERI AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SizePositionConstants.h"

@interface ArrowAnnotation : MKAnnotationView {
	double u;
	double v;
	float red;
	float green;

	
	CGMutablePathRef path;
}

@end
