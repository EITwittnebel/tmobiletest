//
//  TapestryShell.m
//  TmobileTestAssign
//
//  Created by Field Employee on 5/27/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TapestryShell.h"

@implementation TapestryShell : NSObject

static TapestryShell *sharedInstance = NULL;
+ (TapestryShell *)sharedShell {
  @synchronized(self) {
    if (sharedInstance == NULL)
    {
      sharedInstance = [[self alloc] init];
      sharedInstance.settings = [[Settings alloc] init];
      sharedInstance.currentDevice = [[Device alloc] init];
    }
  }
  return sharedInstance;
}

@end
