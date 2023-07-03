//
//  CreateTrackerViewPresenterProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

protocol CreateTrackerViewControllerProtocol: AnyObject {
    var viewController: TrackerViewControllerProtocol? { get }
    func switchToTrackerVC()
}
