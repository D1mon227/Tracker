//
//  NewTrackerViewPresenterProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import UIKit

protocol NewTrackerViewControllerProtocol: AnyObject {
    var trackerPresenter: TrackerViewPresenterProtocol? { get set }
    var selectedCategory: String? { get set }
    var selectedSchedule: String? { get set }
    var trackerName: String? { get set }
    var trackerEmoji: String? { get set }
    var trackerColor: UIColor? { get set }
    var schedule: [Int]? { get set }
    var typeOfTracker: TypeOfTracker? { get }
    func reloadTableView()
}
