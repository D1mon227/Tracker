//
//  CategoryViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    private let categoryView = CategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addTarget()
    }
    
    private func addTarget() {
        categoryView.addCategoryButton.addTarget(self, action: #selector(switchToNewCategoryViewController), for: .touchUpInside)
    }
    
    @objc private func switchToNewCategoryViewController() {
        let newCategoryVC = NewCategoryViewController()
        present(newCategoryVC, animated: true)
    }
}

//MARK: SetupViews
extension CategoryViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(categoryView.categoryLabel)
        view.addSubview(categoryView.emptyImage)
        view.addSubview(categoryView.emptyLabel)
        view.addSubview(categoryView.addCategoryButton)
        addConstraints()
    }
    
    private func addConstraints() {
        categoryView.categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        categoryView.emptyImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        categoryView.emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(categoryView.emptyImage.snp.bottom).offset(8)
        }
        
        categoryView.addCategoryButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
