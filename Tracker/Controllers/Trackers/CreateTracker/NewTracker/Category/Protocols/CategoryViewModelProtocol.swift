//
//  CategoryViewModelProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 28.06.2023.
//

import Foundation

protocol CategoryViewModelProtocol: AnyObject {
    func getVisibleCategories()
    func getSelectedCategory() -> String
    func setSelectedCategory(name: String)
}
