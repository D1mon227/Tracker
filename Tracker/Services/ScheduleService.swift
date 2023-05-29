//
//  Schedule.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

final class ScheduleService {
    
    func arrayToString(array: [Int]) -> String {
        let sortedDays = array.sorted()
        let shortNames = sortedDays.map { changeDayToShortName(day: $0) }
        let finalString = shortNames.joined(separator: ", ")

        return finalString
    }
    
    func addDayToSchedule(day: String) -> Int {
        switch day {
        case "Понедельник":
            return 1
        case "Вторник":
            return 2
        case "Среда":
            return 3
        case "Четверг":
            return 4
        case "Пятница":
            return 5
        case "Суббота":
            return 6
        case "Воскресенье":
            return 7
        default:
            return 0
        }
    }
    
    func changeDayToShortName(day: Int) -> String {
        switch day {
        case 1:
            return "Пн"
        case 2:
            return "Вт"
        case 3:
            return "Ср"
        case 4:
            return "Чт"
        case 5:
            return "Пт"
        case 6:
            return "Сб"
        case 7:
            return "Вс"
        default:
            return ""
        }
    }
}
