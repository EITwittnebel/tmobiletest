//
//  Device.m
//  objcTmobile
//
//  Created by Field Employee on 5/28/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import "Device.h"

@interface Device ()

@property (nonatomic) NSString *actualDeviceID;

@end

@implementation Device

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.actualDeviceID = @"This is my UUID";
  }
  return self;
}

@end
