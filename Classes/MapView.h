//
//  UpcomingNormalView.h
//  Sfsu
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "ColorUtils.h"
#import "ResourceManager.h"
#import "SeaSpeed.h"
#import "SeaFile.h"
#import "RMSTracker.h"
#import "ArrowAnnotation.h"
#import "Buoy.h"
#import <QuartzCore/QuartzCore.h>
#import "SizePositionConstants.h"

@interface MapView : NSObject <MKMapViewDelegate, CLLocationManagerDelegate>{
	
	UIViewController* controller;
		
	UIView* mother;
	MKMapView* mapView;
	MKReverseGeocoder *geoCoder;
	MKPlacemark *mPlacemark;
	
	UISlider* slider;
	int lastValue;
	
	UIButton* addPin;
	UIButton* fullMap;
	UIButton* normalMap;
	
	UIView* topBar;
	UIImageView* colorBar;
	UIView* sliderBase;
	
	FontLabel* plus2;
	FontLabel* minus24;
	FontLabel* time;
	
	UITabBar* menuBar;
	UITabBarItem* item;
	UITabBarItem* item2;
	
	BOOL isBuilt;
	BOOL isFullMap;
	
	int annotationCounter;
	MKUserLocation* loc;
}

-(void) configure:(UIViewController*) parent;
-(void) sliderChanged;
-(void) toggleFullMap;
-(void) createPin;
-(void) closeClick:(id)sender;
-(MKMapView*) getMapView;

@end
