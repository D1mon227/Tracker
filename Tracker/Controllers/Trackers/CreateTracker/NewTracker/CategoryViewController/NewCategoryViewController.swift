//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class NewCategoryViewController: UIViewController {
    
    private let newCategoryView = NewCategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
    }
    
}

//MARK: SetupViews
extension NewCategoryViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(newCategoryView.categoryLabel)
        view.addSubview(newCategoryView.newCategoryTextField)
        view.addSubview(newCategoryView.addCategoryButton)
        addConstraints()
    }
    
    private func addConstraints() {
        newCategoryView.categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        newCategoryView.newCategoryTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(newCategoryView.categoryLabel.snp.bottom).offset(38)
            make.height.equalTo(75)
        }
        
        newCategoryView.addCategoryButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
