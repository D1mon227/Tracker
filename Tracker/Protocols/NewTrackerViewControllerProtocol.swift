//
//  NewTrackerViewPresenterProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

protocol NewTrackerViewControllerProtocol: AnyObject {
    var trackerPresenter: TrackerViewPresenterProtocol? { get set }
    var selectedCategory: String? { get set }
    var selectedSchedule: String? { get set }
    func reloadTableView()
}
