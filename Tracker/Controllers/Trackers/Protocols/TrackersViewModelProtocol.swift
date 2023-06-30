//
//  TrackersViewModelProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 28.06.2023.
//

import Foundation

protocol TrackersViewModelProtocol: AnyObject {
    func deleteTracker(id: UUID)
    func fetchCompletedCategoriesFromStore()
    func getCompletedCategories() -> [TrackerRecord]
    func addRecord(tracker: TrackerRecord)
    func deleteRecord(tracker: TrackerRecord)
    func setupVisibleTrackers()
    func checkDate() -> Bool
    func filterTrackers(text: String?)
}
