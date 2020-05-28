//
//  TapestryServices.m
//  TmobileTestAssign
//
//  Created by Field Employee on 5/27/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TapestryServices.h"

@implementation TapestryServices

static TapestryServices *sharedInstance = NULL;

+ (TapestryServices *)shared {
  @synchronized(self) {
    if (sharedInstance == NULL)
    {
      sharedInstance = [[self alloc] init];
    }
  }
  return sharedInstance;
}

- (void)serviceCallUsingMutableRequest: (NSMutableURLRequest *) getTokenRequest {
}

@end

