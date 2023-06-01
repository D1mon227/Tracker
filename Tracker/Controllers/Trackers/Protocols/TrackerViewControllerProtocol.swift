//
//  TrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

protocol TrackerViewControllerProtocol: AnyObject {
    var presenter: TrackerViewPresenterProtocol? { get set }
    func reloadCollectionView()
    func setupTrackersFromDatePicker()
}
