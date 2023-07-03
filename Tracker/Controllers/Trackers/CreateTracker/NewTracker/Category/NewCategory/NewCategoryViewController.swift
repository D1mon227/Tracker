//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class NewCategoryViewController: UIViewController, NewCategoryViewControllerProtocol {
    
    private let newCategoryView = NewCategoryView()
    private let dataProvider = DataProvider.shared
    var viewController: CategoryViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setupTextField()
        addTarget()
    }
    
    private func setupTextField() {
        newCategoryView.newCategoryTextField.delegate = self
    }
    
    private func addTarget() {
        newCategoryView.addCategoryButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
    }
    
    @objc private func addCategory() {
        guard let categoryName = newCategoryView.newCategoryTextField.text else { return }
        dataProvider.addCategory(category: categoryName)
        dismiss(animated: true)
    }
}

extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            newCategoryView.addCategoryButton.isEnabled = true
            newCategoryView.addCategoryButton.backgroundColor = .ypBlack
            newCategoryView.addCategoryButton.setTitleColor(.ypWhite, for: .normal)
            return true
        } else {
            newCategoryView.addCategoryButton.isEnabled = false
            newCategoryView.addCategoryButton.backgroundColor = .ypGray
            return true
        }
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
