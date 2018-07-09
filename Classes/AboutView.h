//
//  PastView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "ColorUtils.h"
#import "ResourceManager.h"
#import "SizePositionConstants.h"

@interface AboutView : NSObject {
	UIViewController* controller;
	
	UIView* mother;
	UIImageView* bg;
	
	UIButton* link;
	
	UITabBar* menuBar;
	UITabBarItem* item;
	UITabBarItem* item2;
	
	BOOL isBuilt;
}

-(void) configure:(UIViewController*) parent;
-(void) openLink;

@end
