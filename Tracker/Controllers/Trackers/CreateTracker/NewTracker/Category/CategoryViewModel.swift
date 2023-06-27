//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 28.06.2023.
//

import Foundation

final class CategoryViewModel {
    
    @CategoryObservable
    private(set) var visibleCategories: [String] = []
}
