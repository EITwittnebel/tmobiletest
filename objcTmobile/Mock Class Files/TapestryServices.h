//
//  TapestryServices.h
//  TmobileTestAssign
//
//  Created by Field Employee on 5/27/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#ifndef TapestryServices_h
#define TapestryServices_h

@interface TapestryServices : NSObject

@property NSData *_data;
@property NSError *_error;

+ (TapestryServices *)shared;

// This function should be doing the API call and setting data/error, but simply for testing purposes we will
// have it do nothing and set the data/error in the test cases themselves.
- (void)serviceCallUsingMutableRequest: (NSMutableURLRequest *) getTokenRequest;

@end

#endif //TapestryServices_h

