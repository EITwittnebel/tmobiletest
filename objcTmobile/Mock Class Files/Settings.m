//
//  Settings.m
//  objcTmobile
//
//  Created by Field Employee on 5/27/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"

@implementation Settings

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.ssoEnable = true;
    self.requestTimeoutSeconds = 10;
    self.featureEnabledDate = @"N/A";
    self.actualDeviceID = @"100";
    self.kioskMode = true;
  }
  return self;
}

@end
