//
//  UTAPIObjCAdapter.h
//  UTAPIObjCAdapter
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

@import Foundation;

#if TARGET_OS_IPHONE || TARGET_OS_TV || TARGET_OS_SIMULATOR || TARGET_OS_WATCH
@import UIKit;
#else
@import AppKit;
#endif

//! Project version number for UTAPIObjCAdapter
FOUNDATION_EXPORT double UTAPIObjCAdapter_VersionNumber;

//! Project version string for UTAPIObjCAdapter.
FOUNDATION_EXPORT const unsigned char UTAPIObjCAdapter_VersionString[];
