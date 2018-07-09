//
//  untitled.h
//  Sfsu
//
//  Created by Guilherme Carvalho on 27/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SeaSpeed.h"
#import "SeaFile.h"
#import "XMLParser.h"
#import "TreeNode.h"
#import "ZipArchive.h"
#import "Buoy.h"

@interface SfsuXMLParser : NSObject {

}

+(SeaSpeed*) getData:(NSString*) xml;

@end
