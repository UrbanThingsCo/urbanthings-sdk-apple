//
//  ObjCDemo.m
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 20/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UTAPIObjCAdapter;

@interface ObjCDemo : NSObject
+ (void)logStatus:(id<ResourceStatus> )source;
@end

@implementation ObjCDemo

+ (void)logStatus:(id<ResourceStatus> )source {
    NSLog(@"%@ %@", source.primaryCode, source.statusText);
}

@end