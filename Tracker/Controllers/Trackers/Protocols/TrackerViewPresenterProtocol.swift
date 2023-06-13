//
//  TrackerViewPresenterProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

protocol TrackerViewPresenterProtocol: AnyObject {
    var currentDate: Date? { get set }
    func getVisibleCategories() -> [TrackerCategory]
    func filterTrackers(text: String?)
    func deleteTracker(id: UUID)
}
