//
//  SfsuAppDelegate.h
//  Sfsu
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMSTracker.h"

@class SfsuViewController;

@interface SfsuAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SfsuViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SfsuViewController *viewController;

@end

