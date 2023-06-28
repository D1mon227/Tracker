//
//  TrackerCollectionViewCellDelegate.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 01.06.2023.
//

import Foundation

protocol TrackerCollectionViewCellDelegate: AnyObject {
    func completeTracker(id: UUID, at indexPath: IndexPath)
    func uncompleteTracker(id: UUID, at indexPath: IndexPath)
    func editTracker(_ cell: TrackersCollectionViewCell)
    func deleteTracker(_ cell: TrackersCollectionViewCell)
}
