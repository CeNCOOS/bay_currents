//
//  SfsuViewController.h
//  Sfsu
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontLabel.h"
#import "FontManager.h"
#import "ResourceManager.h"
#import "ColorUtils.h"
#import "SfsuXMLParser.h"
#import "MapView.h"
#import "RMSTracker.h"
#import "AboutView.h"

@interface SfsuViewController : UIViewController<UITabBarDelegate, UIAlertViewDelegate> {
	MapView* mView;
	AboutView* aView;
	
	SeaSpeed* seaSpeed;
	int screen;
	
	NSString* lastUpdate;
}

-(void)updateData;
-(SeaSpeed*) getSeaSpeed;
-(void)setScreen:(int) newScreen;

@end

