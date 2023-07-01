//
//  CategoryViewModelProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 28.06.2023.
//

import Foundation

protocol CategoryViewModelProtocol: AnyObject {
    var selectedCategory: String { get set }
    func getVisibleCategories()
}
