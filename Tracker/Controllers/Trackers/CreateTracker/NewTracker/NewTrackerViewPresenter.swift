//
//  NewTrackerViewPresenter.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 30.05.2023.
//

import UIKit

enum TypeOfTracker {
    case habit
    case unregularEvent
}

final class NewTrackerViewPresenter: NewTrackerViewPresenterProtocol {
    var view: NewTrackerViewControllerProtocol?
    //private let storage = TrackerStorage.shared
    private let dataProvider = DataProvider.shared
    let tableViewTitle = ["Категория", "Расписание"]
    
    func createNewTracker() {
        guard let trackerColor = dataProvider.trackerColor,
              let trackerName = dataProvider.trackerName,
              let trackerEmoji = dataProvider.trackerEmoji else { return }
        
        let newTracker = Tracker(id: UUID(),
                                 name: trackerName,
                                 color: trackerColor,
                                 emoji: trackerEmoji,
                                 schedule: dataProvider.schedule ?? [1,2,3,4,5,6,7])
        dataProvider.addTracker(newTracker)
//        var newCategory: [TrackerCategory] = []
//
//        categories.forEach { category in
//            if storage.selectedCategory == category.name {
//                var newTrackers = category.trackerArray
//                newTrackers.append(newTracker)
//                newCategory.append(TrackerCategory(name: category.name, trackerArray: newTrackers))
//            } else {
//                newCategory.append(category)
//            }
//        }
//
//        return newCategory
    }
}
