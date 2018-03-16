//
//  ReactNativePermissions.m
//  ReactNativePermissions
//
//  Created by Yonah Forst on 18/02/16.
//  Copyright © 2016 Yonah Forst. All rights reserved.
//

@import Contacts;

#import "ReactNativePermissions.h"

#if __has_include(<React/RCTBridge.h>)
  #import <React/RCTBridge.h>
#elif __has_include("React/RCTBridge.h")
  #import "React/RCTBridge.h"
#else
  #import "RCTBridge.h"
#endif

#if __has_include(<React/RCTConvert.h>)
  #import <React/RCTConvert.h>
#elif __has_include("React/RCTConvert.h")
  #import "React/RCTConvert.h"
#else
  #import "RCTConvert.h"
#endif

#if __has_include(<React/RCTEventDispatcher.h>)
  #import <React/RCTEventDispatcher.h>
#elif __has_include("React/RCTEventDispatcher.h")
  #import "React/RCTEventDispatcher.h"
#else
  #import "RCTEventDispatcher.h"
#endif

#import "RNPAudioVideo.h"

@interface ReactNativePermissions()
@end

@implementation ReactNativePermissions


RCT_EXPORT_MODULE();
@synthesize bridge = _bridge;

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init]) {
    }

    return self;
}

/**
 * run on the main queue.
 */
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_REMAP_METHOD(getPermissionStatus, getPermissionStatus:(RNPType)type json:(id)json resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *status;

    switch (type) {

        case RNPTypeLocation: {
            NSString *locationPermissionType = [RCTConvert NSString:json];
            status = [RNPLocation getStatusForType:locationPermissionType];
            break;
        }
        case RNPTypeCamera:
            status = [RNPAudioVideo getStatus:@"video"];
            break;
        case RNPTypeMicrophone:
            status = [RNPAudioVideo getStatus:@"audio"];
            break;
        case RNPTypePhoto:
            status = [RNPPhoto getStatus];
            break;
        case RNPTypeContacts:
            status = [RNPContacts getStatus];
            break;
        case RNPTypeEvent:
            status = [RNPEvent getStatus:@"event"];
            break;
        case RNPTypeReminder:
            status = [RNPEvent getStatus:@"reminder"];
            break;
        case RNPTypeBluetooth:
            status = [RNPBluetooth getStatus];
            break;
        case RNPTypeNotification:
            status = [RNPNotification getStatus];
            break;
        case RNPTypeBackgroundRefresh:
            status = [RNPBackgroundRefresh getStatus];
            break;
        case RNPTypeSpeechRecognition:
            status = [RNPSpeechRecognition getStatus];
            break;
        case RNPTypeMediaLibrary:
            status = [RNPMediaLibrary getStatus];
            break;
        case RNPTypeMotion:
            status = [RNPMotion getStatus];
            break;
        default:
            break;
    }

    resolve(status);
}

@end
