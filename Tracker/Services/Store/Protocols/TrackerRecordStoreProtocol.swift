//
//  TrackerRecordStoreProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 14.06.2023.
//

import Foundation

protocol TrackerRecordStoreProtocol: AnyObject {
    func addTrackerRecord(tracker: TrackerRecord)
    func deleteTrackerRecord(tracker: TrackerRecord)
    func fetchTrackerRecords() -> [TrackerRecord]
}
