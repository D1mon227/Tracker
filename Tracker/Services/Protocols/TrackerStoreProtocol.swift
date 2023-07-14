//
//  TrackerStoreProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 11.06.2023.
//

import Foundation

protocol TrackerStoreProtocol: AnyObject {
    func addTracker(model: Tracker)
    func editTracker(model: Tracker)
    func pinTracker(id: UUID)
    func unpinTracker(id: UUID)
    func getTracker(category: String, index: Int) -> Tracker
    func fetchTrackers() -> [TrackerCategory]
    func deleteTracker(id: UUID)
}
