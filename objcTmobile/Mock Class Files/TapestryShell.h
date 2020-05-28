//
//  Tapestry.h
//  TmobileTestAssign
//
//  Created by Field Employee on 5/27/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#ifndef TapestryShell_h
#define TapestryShell_h
#import <Foundation/Foundation.h>
#import "Settings.h"

@interface TapestryShell : NSObject
@property Settings *settings;
@property Settings *currentDevice;

+ (TapestryShell *)sharedShell;

@end

#endif /* Tapestry_h */
