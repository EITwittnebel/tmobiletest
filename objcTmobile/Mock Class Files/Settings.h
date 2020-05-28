//
//  Settings.h
//  TmobileTestAssign
//
//  Created by Field Employee on 5/27/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#ifndef Settings_h
#define Settings_h

@interface Settings : NSObject

@property bool ssoEnable;
@property int requestTimeoutSeconds;
@property NSString *featureEnabledDate;
@property NSString *actualDeviceID;
@property bool kioskMode;

@end

#endif /* Settings_h */
