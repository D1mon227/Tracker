//
//  Schedule.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

final class ScheduleService {
    
    func arrayToString(array: [Int]) -> String {
        var result = array
        
        if result.contains(1) {
            let sorted = result.filter { $0 != 1 }.sorted()
            result = sorted + [1]
        } else {
            result = array.sorted()
        }
        
        let shortNames = result.map { changeDayToShortName(day: $0) }
        let finalString = shortNames.joined(separator: ", ")

        return finalString
    }
    
    func addDayToSchedule(day: String) -> Int {
        switch day {
        case "Понедельник":
            return 2
        case "Вторник":
            return 3
        case "Среда":
            return 4
        case "Четверг":
            return 5
        case "Пятница":
            return 6
        case "Суббота":
            return 7
        case "Воскресенье":
            return 1
        default:
            return 0
        }
    }
    
    func changeDayToShortName(day: Int) -> String {
        switch day {
        case 1:
            return "Вс"
        case 2:
            return "Пн"
        case 3:
            return "Вт"
        case 4:
            return "Ср"
        case 5:
            return "Чт"
        case 6:
            return "Пт"
        case 7:
            return "Сб"
        default:
            return ""
        }
    }
}
