//
//  TrackerCategoryStoreProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 11.06.2023.
//

import Foundation

protocol TrackerCategoryStoreProtocol: AnyObject {
    var numberOfCategories: Int { get }
    func numberOfRowsInSection(section: Int) -> Int
    func addCategory(category: String)
    func isCategoryExist(category: String) -> Bool
    func fetchCategoryName(index: Int) -> String
    func fetchNewCategoryName(name: String) -> TrackerCategoryCoreData?
    func getCategoriesNames() -> [String]
}
