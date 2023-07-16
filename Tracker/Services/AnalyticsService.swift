//
//  AnalyticsService.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 16.07.2023.
//

import Foundation
import YandexMobileMetrica

enum Events: String {
    case open = "open"
    case close = "close"
    case click = "click"
}

enum Screen: String {
    case trackersVC = "TrackersVC"
    case createTrackerVC = "CreateTrackerVC"
    case newTrackerVC = "NewTrackerVC"
    case categoryVC = "CategoryVC"
    case scheduleVC = "ScheduleVC"
    case statisticVC = "StatisticVC"
    case editingCategory = "EditingCategoryVC"
    case editingTrackerVC = "EditingTrackerVC"
    case filterVC = "FilterVC"
}

enum Item: String {
    // TrackerVC:
    case addTrack = "add_track"
    case track = "track"
    case filter = "filter"
    case edit = "edit"
    case delete = "delete"
    
    // CreateTrackerVC:
    case habit = "habit"
    case unregularEvent = "unregularEvent"
    
    // NewTrackerVC:
    case category = "category"
    case schedule = "schedule"
    case emoji = "emoji"
    case color = "color"
    case create = "create"
    case cancel = "cancel"
    case nameDidEnter = "nameDidEnter"
    
    // Schedule:
    case everyDay = "everyDay"
    case notEveryDay = "notEveryDay"
    
    // FilterVC:
    case allTrackers = "allTrackers"
    case todaysTrackers = "todaysTrackers"
    case completedTrackers = "completedTrackers"
    case uncompletedTrackers = "uncompletedTrackers"
    
    // EditingTrackerVC
    case decreaseDays = "decreaseDays"
    case increaseDays = "increaseDays"
}

final class AnalyticsService {
    
    static let shared = AnalyticsService()
    
    func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "24060cb4-dd1c-4549-b83d-37719151b5b7") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func report(typeOfEvent: Events, screen: Screen, item: Item?) {
        var params: [AnyHashable: Any] = [:]
        
        if item == nil {
            params = ["event": typeOfEvent.rawValue, "screen": screen.rawValue]
        } else {
            guard let item = item else { return }
            params = ["event": typeOfEvent.rawValue, "screen": screen.rawValue, "item": item.rawValue]
        }
        YMMYandexMetrica.reportEvent("EVENT", parameters: params, onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}
