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
    
    var numberOfCategories: Int? {
        visibleCategories.count
    }
    
    func getVisibleCategories() {
        visibleCategories = dataProvider.updateCategoryViewModel()
    }
    
    func getSelectedCategory() -> String {
        dataProvider.selectedCategory ?? ""
    }
    
    func setSelectedCategory(name: String) {
        dataProvider.selectedCategory = name
    }
}
