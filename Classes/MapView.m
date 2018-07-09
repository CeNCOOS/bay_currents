//
//  UpcomingNormalView.m
//  Sfsu
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "MapView.h"
#import "SfsuViewController.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"

@implementation MapView


-(void) configure:(UIViewController*) parent
{
	controller = parent;
	
	if (!isBuilt)
	{
		annotationCounter = 0;
		
		isBuilt = true;
		
		mother = [[UIScrollView alloc]init];
		mother.frame = [SizePositionConstants getMotherFrame];
		mother.backgroundColor = [UIColor greenColor];
		
		mapView=[[MKMapView alloc] initWithFrame:[SizePositionConstants getMotherFrame]];
		mapView.showsUserLocation=TRUE;
		mapView.mapType=MKMapTypeSatellite;
		mapView.delegate=self;
		
		/*Region and Zoom*/
		MKCoordinateRegion region;
		MKCoordinateSpan span;
		span.latitudeDelta=0.094671;
		span.longitudeDelta=0.189342;
		
		CLLocationCoordinate2D location=mapView.userLocation.coordinate;
		
		location.latitude=37.874849;
		location.longitude=-122.41732;
		region.span=span;
		region.center=location;
		
		[mapView setRegion:region animated:TRUE];
		[mother addSubview:mapView];
		
		topBar = [[UIView alloc]init];
		topBar.frame = [SizePositionConstants getTopBarFrame];
		topBar.backgroundColor = [UIColor blackColor];
		topBar.alpha = 0.55;
		[mother addSubview:topBar];
		
		addPin = [[UIButton alloc] initWithFrame:[SizePositionConstants getAddPinFrame]];
		UIImageView* imageView1 = [[UIImageView alloc] initWithFrame: [SizePositionConstants getAddPinImageFrame]];
		imageView1.image = [UIImage imageNamed:@"add_pin.png"];
		[addPin addTarget:self action:@selector(createPin)  forControlEvents:UIControlEventTouchUpInside]; 
		[addPin addSubview:imageView1];
		[mother addSubview:addPin];
		
		fullMap = [[UIButton alloc] initWithFrame:[SizePositionConstants getFullMapFrame]];
		UIImageView* imageView2 = [[UIImageView alloc] initWithFrame: [SizePositionConstants getFullMapImageFrame]];
		imageView2.image = [UIImage imageNamed:@"full_map.png"];
		[fullMap addSubview:imageView2];
		[fullMap addTarget:self action:@selector(toggleFullMap)  forControlEvents:UIControlEventTouchUpInside]; 
		[mother addSubview:fullMap];
		
		normalMap = [[UIButton alloc] initWithFrame:[SizePositionConstants getNormalMapFrame]];
		UIImageView* imageView3 = [[UIImageView alloc] initWithFrame: [SizePositionConstants getNormalMapImageFrame]];
		imageView3.image = [UIImage imageNamed:@"normal_map.png"];
		[normalMap addSubview:imageView3];
		normalMap.hidden = TRUE;
		[normalMap addTarget:self action:@selector(toggleFullMap)  forControlEvents:UIControlEventTouchUpInside]; 
		[mother addSubview:normalMap];
		
		colorBar = [[UIImageView alloc] initWithFrame: [SizePositionConstants getColorBarFrame]];
		colorBar.image = [UIImage imageNamed:@"color_bar.png"];
		[mother addSubview:colorBar];
		
		sliderBase = [[UIView alloc]init];
		sliderBase.frame = [SizePositionConstants getSliderPanelFrame];
		sliderBase.backgroundColor = [UIColor blackColor];
		sliderBase.alpha = 0.55;
		sliderBase.layer.cornerRadius = 5;
		[mother addSubview:sliderBase];
		
		plus2 = [[FontLabel alloc] initWithFrame:[SizePositionConstants getPlus2LabelFrame] fontName:@"HelveticaNeueBold" pointSize:11.0f];
		plus2.textColor = [UIColor whiteColor];
		plus2.backgroundColor = nil;
		plus2.textAlignment = UITextAlignmentRight;
		plus2.opaque = NO;
		plus2.text = @"+2 Hours";
		[mother addSubview:plus2];
		
		minus24 = [[FontLabel alloc] initWithFrame:[SizePositionConstants getMinus24LabelFrame] fontName:@"HelveticaNeueBold" pointSize:11.0f];
		minus24.textColor = [UIColor whiteColor];
		minus24.backgroundColor = nil;
		minus24.opaque = NO;
		minus24.text = @"-24 Hours";
		[mother addSubview:minus24];
		
		time = [[FontLabel alloc] initWithFrame:[SizePositionConstants getTimeLabelFrame] fontName:@"HelveticaNeueBold" pointSize:11.0f];
		time.textColor = [UIColor whiteColor];
		time.backgroundColor = nil;
		time.textAlignment = UITextAlignmentCenter;
		time.opaque = NO;
		time.text = @"7:00 PM PST 27 FEB 2011";
		[mother addSubview:time];
		
		slider = [[UISlider alloc]initWithFrame: [SizePositionConstants getSliderFrame]];
		slider.minimumValue = 1;	
		slider.maximumValue = 29;
		slider.value = 25;
		[self sliderChanged];
		[slider addTarget:self action:@selector(sliderChanged)  forControlEvents:UIControlEventValueChanged];   
		[mother addSubview:slider];	
		
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
		
		isFullMap = false;
	}
	
	[menuBar setSelectedItem:item];
	
	if ([[controller.view subviews] count] > 0)
		[[[controller.view subviews] objectAtIndex:0] removeFromSuperview];
		
	[controller.view addSubview:mother];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView2 viewForAnnotation:(id <MKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[Buoy class]])
	{
		ArrowAnnotation* arrow = [[ArrowAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@""];
		arrow.userInteractionEnabled = FALSE;
		arrow.enabled = FALSE;
	
		return arrow;
	}
	else if ([annotation isKindOfClass:[DDAnnotation class]])
	{
		MKAnnotationView *draggablePinView = [DDAnnotationView annotationViewWithAnnotation:annotation reuseIdentifier:@"" mapView:self];
		
		if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
			// draggablePinView is DDAnnotationView on iOS 3.
		} else {
			// draggablePinView instance will be built-in draggable MKPinAnnotationView when running on iOS 4.
		}			
		
		return draggablePinView;
	}
	else
	{
		loc = (MKUserLocation*)annotation;
		loc.title = [NSString stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
	}
	
	return nil;
}

-(void) sliderChanged
{
	int index = 29-[slider value];
	
	if (lastValue != index)
	{
		//remove the most part
		if ((lastValue >=0) && (lastValue < 29))
		{
			SeaFile* old = [[[((SfsuViewController*) controller) getSeaSpeed] getFiles] objectAtIndex:lastValue];	
			[mapView removeAnnotations:[old getBuoys]];
		}
		
		//double checking (there was a bug requiring this)
		for (int i=[[mapView annotations] count]-1; i>=0; i--)
		{		
			if ([[[mapView annotations] objectAtIndex:i] isKindOfClass:[Buoy class]])
			{
				[mapView removeAnnotation:[[mapView annotations] objectAtIndex:i]];
			}
		}
		
		lastValue = index;
		
		SeaFile* file = [[[((SfsuViewController*) controller) getSeaSpeed] getFiles] objectAtIndex:index];
				
		[mapView addAnnotations:[file getBuoys]];
		
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setDateFormat:@"hh:mm a z dd MMM yyyy"];  //7:00 PM PST 27 FEB 2011
		
		time.text = [[format stringFromDate:file.time] uppercaseString];
	}
}

-(void) createPin
{	
	CLLocationCoordinate2D location;
	location.latitude = 37.874849;
	location.longitude = -122.41732;
	
	DDAnnotation *annotation = [[[DDAnnotation alloc] initWithCoordinate:location addressDictionary:nil] autorelease];
	annotation.title = [NSString stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
	annotationCounter++;
	annotation.tag = annotationCounter;
	
	[mapView addAnnotation:annotation];
}

-(void) toggleFullMap
{
	if (isFullMap)
	{
		isFullMap = FALSE;
		
		normalMap.hidden = TRUE;
		
		slider.hidden = FALSE;	
		addPin.hidden = FALSE;
		fullMap.hidden = FALSE;
		topBar.hidden = FALSE;
		colorBar.hidden = FALSE;
		sliderBase.hidden = FALSE;
		plus2.hidden = FALSE;
		minus24.hidden = FALSE;
		time.hidden = FALSE;
		menuBar.hidden = FALSE;
	}
	else
	{
		isFullMap = TRUE;
		
		normalMap.hidden = FALSE;
		
		slider.hidden = TRUE;	
		addPin.hidden = TRUE;
		fullMap.hidden = TRUE;
		topBar.hidden = TRUE;
		colorBar.hidden = TRUE;
		sliderBase.hidden = TRUE;
		plus2.hidden = TRUE;
		minus24.hidden = TRUE;
		time.hidden = TRUE;
		menuBar.hidden = TRUE;
	}	
}

-(MKMapView*) getMapView
{
	return mapView;
}

-(void)closeClick:(id)sender
{
	NSArray* arr = [mapView annotations];
	
	for (int i=0; i<[arr count];i++)
	{
		if ([[arr objectAtIndex:i] isKindOfClass:[DDAnnotation class]])
		{	
			DDAnnotation* temp = (DDAnnotation*)[arr objectAtIndex:i];
			
			//NSLog(@"%i %i",temp.tag,((UIButton*)sender).tag);
			if ((temp.tag) == ((UIButton*)sender).tag)
			{
				[mapView removeAnnotation:temp];
				return;
			}
		}
	}
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	// update annotation position here
	if (loc != nil)
		loc.title = [NSString stringWithFormat:@"%f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];

}

@end
