//
//  ObjCDemo.h
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 20/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

#ifndef ObjCDemo_h
#define ObjCDemo_h

@import UTAPIObjCAdapter;

// To demonstrate ObjC / Swift integration for the SDK this
// simple ObjC class is included that provides a class method
// to print a log message from a ResourceStatus instance.
@interface ObjCDemo : NSObject
+ (void)logStatus:(id<ResourceStatus> )source;
@end


#endif /* ObjCDemo_h */
