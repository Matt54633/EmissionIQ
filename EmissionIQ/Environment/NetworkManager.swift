//
//  NetworkManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 15/03/2024.
//

import Foundation
import Network

// NetworkManager is responsible for checking the status of the network connection
class NetworkManager: ObservableObject {
    private let networkManager = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Manager")
    var isConnected = false

    init() {
        networkManager.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkManager.start(queue: workerQueue)
    }
}
