//
//  UTAPI.h
//  UTAPI
//
//  Created by Mark Woollard on 25/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

@import Foundation;

#if TARGET_OS_IPHONE || TARGET_OS_TV || TARGET_OS_SIMULATOR || TARGET_OS_WATCH
@import UIKit;
#else
@import AppKit;
#endif

//! Project version number for UrbanThingsAPI.
FOUNDATION_EXPORT double UrbanThingsAPIVersionNumber;

//! Project version string for UrbanThingsAPI.
FOUNDATION_EXPORT const unsigned char UrbanThingsAPIVersionString[];

