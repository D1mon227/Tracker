//
//  CategoryTableViewCellDelegate.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 13.07.2023.
//

import Foundation

protocol CategoryTableViewCellDelegate: AnyObject {
    func editCategory(_ cell: CategoryTableViewCell)
    func deleteCategory(_ cell: CategoryTableViewCell)
}
