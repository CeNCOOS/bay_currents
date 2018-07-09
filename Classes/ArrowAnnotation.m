//
//  MyAnnotation.m
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-11-01.
//  Copyright 2009 JAKERI AB. All rights reserved.
//

#import "ArrowAnnotation.h"
#import "Buoy.h"

@implementation ArrowAnnotation

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        CGRect frame = self.frame;
        frame.size = [SizePositionConstants getArrowFrame];
		
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setAnnotation:(id <MKAnnotation>)annotation
{
	if (annotation != nil)
	{
		[super setAnnotation:annotation];
		
		u = ((Buoy*) annotation).u;
		v = ((Buoy*) annotation).v;
		path = ((Buoy*) annotation).path;
		red = ((Buoy*) annotation).red;
		green = ((Buoy*) annotation).green;
		
		// this annotation view has custom drawing code.  So when we reuse an annotation view
		// (through MapView's delegate "dequeueReusableAnnoationViewWithIdentifier" which returns non-nil)
		// we need to have it redraw the new annotation data.
		//
		// for any other custom annotation view which has just contains a simple image, this won't be needed
		//
		//[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, red, green, 0, 1);
	CGContextAddPath(context, path);
	CGContextDrawPath(context, kCGPathStroke);
//	CGPathRelease(path);
}

@end