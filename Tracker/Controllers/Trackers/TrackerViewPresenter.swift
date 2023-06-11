//
//  TrackerViewPreseneter.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

final class TrackerViewPresenter: TrackerViewPresenterProtocol {
    
    let dateService = DateService()
    //private let storage = TrackerStorage.shared
    private let dataProvider = DataProvider.shared
    var currentDate: Date?
    
    func filterTrackers(text: String?) {
        guard let date = currentDate,
              let text = text?.lowercased() else { return }
        
        dataProvider.visibleCategories = dataProvider.categories?.compactMap { category in
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
