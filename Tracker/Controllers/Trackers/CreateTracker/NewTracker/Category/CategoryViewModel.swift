//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 28.06.2023.
//

import Foundation

final class CategoryViewModel: CategoryViewModelProtocol {
    
    private let dataProvider = DataProvider.shared
    
    @CategoryObservable
    private(set) var visibleCategories: [String] = []
    
    init() {
        dataProvider.bindCategoryViewModel(controller: self)
        getVisibleCategories()
    }
    
    var numberOfCategories: Int {
        visibleCategories.count
    }
    
    var selectedCategory: String {
        get {
            dataProvider.selectedCategory ?? ""
        }
        set {
            dataProvider.selectedCategory = newValue
        }
    }
    
    func areVisibleCategoriesEmpty() -> Bool {
        if numberOfCategories == 0 {
            return true
        } else {
            return false
        }
    }
    
    func isLastCategory(at indexPath: IndexPath) -> Bool {
        if numberOfCategories == indexPath.row + 1 {
            return true
        } else {
            return false
        }
    }
    
    func getVisibleCategories() {
        visibleCategories = dataProvider.updateCategoryViewModel()
    }
}
