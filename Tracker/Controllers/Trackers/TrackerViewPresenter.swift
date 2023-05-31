//
//  TrackerViewPreseneter.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

final class TrackerViewPresenter: TrackerViewPresenterProtocol {
    
    let dateService = DateService()
    let trackerView = TrackerView()
    
    var categories: [TrackerCategory]? = [
        TrackerCategory(name: "Важное", trackerArray: [Tracker(id: UUID(),
                                                               name: "Учиться делать iOS-приложения",
                                                               color: .colorSelection1,
                                                               emoji: "🐶",
                                                               schedule: [1, 2, 4, 6]),
                                                       Tracker(id: UUID(),
                                                               name: "Получить права",
                                                               color: .colorSelection2,
                                                               emoji: "😻",
                                                               schedule: [1, 3, 5, 6, 7])]),
        TrackerCategory(name: "Уборка", trackerArray: [Tracker(id: UUID(),
                                                               name: "Полить цветы",
                                                               color: .colorSelection3,
                                                               emoji: "🍔",
                                                               schedule: [3, 4, 5, 6, 7]),
                                                       Tracker(id: UUID(),
                                                               name: "Влажная уборка",
                                                               color: .colorSelection4,
                                                               emoji: "😇",
                                                               schedule: [1, 4, 6])])
    ]
    
    var visibleCategories: [TrackerCategory]? = []
    var completedTrackers: [TrackerRecord]? = []
    
    var emojies = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    var currentDate: Date?
    
    func filterTrackersFromDate(text: String?) {
        guard let categories = categories,
              let date = currentDate,
              let text = text?.lowercased() else { return }
        
        visibleCategories = categories.compactMap { category in
            let filterTrackers = category.trackerArray.filter { tracker in
                guard let schedule = tracker.schedule else { return false }
                let filterText = text.isEmpty || tracker.name.lowercased().contains(text)
                let trackerDate = dateService.getNumberOfSelectedDay(date: date)
                
                return schedule.contains(trackerDate) && filterText
            }
            
            if filterTrackers.isEmpty {
                return nil
            }
            
            return TrackerCategory(name: category.name,
                                   trackerArray: filterTrackers)
        }
    }
}
