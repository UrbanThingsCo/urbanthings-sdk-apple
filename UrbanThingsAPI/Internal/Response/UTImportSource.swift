//
//  ImportSource.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTImportSource : UTAttribution, ImportSource {
    
    let importSourceID: String
    let name: String
    let comments: String?
    let sourceInfoURL: URL?
    let sourceDataURL: URL?
    
    override class var className:String {
        return "\(self)"
    }
    
    override init(json:[String:Any]) throws {
        self.name = try parse(required: json, key: .Name, type: UTImportSource.self)
        self.importSourceID = try parse(required:json, key: .ImportSourceID, type: UTImportSource.self)
        self.comments = try parse(optional:json, key: .Comment, type: UTImportSource.self)
        self.sourceInfoURL = try parse(optional:json, key:. SourceInfoURL, type: UTImportSource.self) { try URL.fromJSON(optional:$0) }
        self.sourceDataURL = try parse(optional:json, key:. SourceDataURL, type: UTImportSource.self) { try URL.fromJSON(optional:$0) }
        try super.init(json:json)
    }
}
