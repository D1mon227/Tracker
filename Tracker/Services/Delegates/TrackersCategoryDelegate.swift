//
//  TrackersCategoryDelegate.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 12.06.2023.
//

import Foundation

protocol TrackersCategoryDelegate: AnyObject {
    func didUpdate(update: CollectionStoreUpdate)
}
