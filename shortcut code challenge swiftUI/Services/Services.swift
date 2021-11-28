//
//  Services.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import Foundation
import SwiftUI

public final class Services {
    
    fileprivate static var _generalUrl: String?
    
    fileprivate static var generalUrl: String {
        get {
            if Services._generalUrl == nil {
                Services._generalUrl = Services.getGeneralUrl()
            }
            return Services._generalUrl!
        }
    }
    
    fileprivate static func getGeneralUrl() -> String {
        guard let serviceURLString = ProcessInfo.processInfo.environment["service_url"] else {
            fatalError("service_url cannot be empty, set the server address on Edit scheme -> Run -> Arguments -> Enviorment Variables")
        }
        guard let destinationFileString = ProcessInfo.processInfo.environment["destination_file"] else {
            fatalError("destination_file cannot be empty, set the server address on Edit scheme -> Run -> Arguments -> Enviorment Variables")
     
        }
        let retObj = "\(serviceURLString){0}/\(destinationFileString)"
        return retObj
    }
    
    public static func urlGenerator(with id: Int? = nil) -> URL? {
        if let fileId = id {
            let urlString = Services.generalUrl.replacingOccurrences(of: "{0}", with: "\(fileId)")
            return URL(string: urlString)
        } else {
            let urlString = Services.generalUrl.replacingOccurrences(of: "{0}/", with: "")
            return URL(string: urlString)
        }
    }
}
