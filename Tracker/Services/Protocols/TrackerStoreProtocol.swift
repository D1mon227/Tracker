//
//  TrackerStoreProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 11.06.2023.
//

import Foundation

protocol TrackerStoreProtocol: AnyObject {
    func addTracker(_ model: Tracker)
    func fetchTracker(category: String, index: Int) -> Tracker
}
