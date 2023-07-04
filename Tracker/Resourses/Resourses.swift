//
//  Resourses.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit

enum Resourses {
    enum Images {
        static let statisticEmptyImage = UIImage(named: "statisticEmptyImage")
        static let trackerEmptyImage = UIImage(named: "trackerEmptyImage")
        static let searchEmptyImage = UIImage(named: "searchEmptyImage")
        static let firstPageOfOnboarding = UIImage(named: "firstPageOfOnboarding")
        static let secondPageOfOnboarding = UIImage(named: "secondPageOfOnboarding")
    }
    
    enum WeekDay: String, CaseIterable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
        var localizedString: String {
            return NSLocalizedString("scheduleVC." + self.rawValue, comment: "")
        }
    }
}
