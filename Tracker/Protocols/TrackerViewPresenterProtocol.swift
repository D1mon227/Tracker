//
//  TrackerViewPresenterProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

protocol TrackerViewPresenterProtocol: AnyObject {
    var categories: [TrackerCategory]? { get set }
    var visibleCategories: [TrackerCategory]? { get set }
    var completedTrackers: [TrackerRecord]? { get set }
    var emojies: [String] { get }
    var currentDate: Date? { get set }
    func filterTrackersFromDate(text: String?)
}
