//
//  RemoteDownloader.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI
import Combine

public final class RemoteDownloader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    func download (urlString:String, downloadStatus: Bool) {
        if downloadStatus {
            return
        }
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }

}
