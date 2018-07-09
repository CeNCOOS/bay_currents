//
//  SizePositionConstants.m
//  Sfsu
//
//  Created by Guilherme Carvalho on 04/03/11.
//  Copyright 2011 Konkix. All rights reserved.
//

#import "SizePositionConstants.h"


@implementation SizePositionConstants

+(CGRect)getMotherFrame { return CGRectMake(0, 0, 320, 480); }
+(CGRect)getAboutLinkFrame { return CGRectMake(25, 160, 150, 30); }
+(CGRect)getMenuBarFrame { return CGRectMake(0, 431, 320, 49); }
+(CGRect)getPinDeleteFrame { return CGRectMake(0,0,35,35); }
+(CGRect)getTopBarFrame { return CGRectMake(0, 0, 320, 40); }
+(CGRect)getAddPinFrame { return CGRectMake(280, 4, 33, 30); }
+(CGRect)getAddPinImageFrame { return CGRectMake(0, 0, 33, 30); }
+(CGRect)getFullMapFrame { return CGRectMake(15, 4, 33, 30); }
+(CGRect)getFullMapImageFrame { return CGRectMake(0, 0, 33, 30); }
+(CGRect)getNormalMapFrame { return CGRectMake(15, 4, 30, 30); }
+(CGRect)getNormalMapImageFrame { return CGRectMake(0, 0, 30, 30); }
+(CGRect)getColorBarFrame { return CGRectMake(0, 60, 30, 261); }
+(CGRect)getSliderPanelFrame { return CGRectMake(35, 369, 250, 60); }
+(CGRect)getPlus2LabelFrame { return CGRectMake(220, 410, 60, 15); }
+(CGRect)getMinus24LabelFrame { return CGRectMake(40, 410, 70, 15); }
+(CGRect)getTimeLabelFrame { return CGRectMake(50, 372, 220, 20); }
+(CGRect)getSliderFrame { return CGRectMake(50, 387, 220, 25); }

+(CGSize)getArrowFrame { return CGSizeMake(20.0, 20.0); }

@end
