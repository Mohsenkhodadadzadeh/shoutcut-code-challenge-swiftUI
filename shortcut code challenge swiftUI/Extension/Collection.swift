//
//  Collection.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
