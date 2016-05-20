//
//  ImportSourceAdapterTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 18/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import XCTest
@testable import UTAPIObjCAdapter
@testable import UTAPI

struct ImportSourceImpl : UTAPI.ImportSource {
    
    let attributionLabel:String? = "Urban Things"
    let attributionImageURL:NSURL? = nil
    let attributionNotes:String? = "Some notes..."

    let importSourceID:String = "importSource123"
    let name:String = "testImportSource"
    let comments:String? = "Test string"
    let sourceInfoURL:NSURL? = NSURL(string: "http://urbanthings.co")
    let sourceDataURL:NSURL? = nil
}

@objc class TestImportSource : NSObject {

    @objc class func getImportSources() -> [UTAPIObjCAdapter.ImportSource]? {
        let (sut, json) = try! XCTestCase.getAPIInstanceAndJSON("ImportSources")
        var objc:[UTAPIObjCAdapter.ImportSource]?
        let _ = sut.sendRequest(UTImportSourcesRequest()) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTImportSource(adapt:$0) }
            }
        }
        return objc
    }
}
