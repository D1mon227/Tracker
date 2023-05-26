//
//  CategoryViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class CategoryViewController: UIViewController {
    
    private let categoryView = CategoryView()
    private let trackerVC = TrackerViewController()
    let titles: [String] = ["Все трекеры", "Трекеры на сегодня", "Завершенные", "Не завершенные"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addTarget()
        setupTableView()
        checkCellsCount()
    }
    
    private func addTarget() {
        categoryView.addCategoryButton.addTarget(self, action: #selector(switchToNewCategoryViewController), for: .touchUpInside)
    }
    
    @objc private func switchToNewCategoryViewController() {
        let newCategoryVC = NewCategoryViewController()
        present(newCategoryVC, animated: true)
    }
    
    private func setupTableView() {
        categoryView.categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        categoryView.categoryTableView.dataSource = self
        categoryView.categoryTableView.delegate = self
    }
    
    private func checkCellsCount() {
        if trackerVC.categories == nil {
            view.addSubview(categoryView.emptyImage)
            view.addSubview(categoryView.emptyLabel)
            categoryView.categoryTableView.removeFromSuperview()

            categoryView.emptyImage.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }

            categoryView.emptyLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(16)
                make.top.equalTo(categoryView.emptyImage.snp.bottom).offset(8)
            }
        } else {
            categoryView.emptyImage.removeFromSuperview()
            categoryView.emptyLabel.removeFromSuperview()
            view.addSubview(categoryView.categoryTableView)

            categoryView.categoryTableView.snp.makeConstraints { make in
                make.top.equalTo(categoryView.categoryLabel.snp.bottom).offset(38)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(300)
            }
        }
    }
}

//MARK: UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackerVC.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(text: titles[indexPath.row])
        cell.backgroundColor = .ypBackground
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

//MARK: UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
    }
}

//MARK: SetupViews
extension CategoryViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(categoryView.categoryLabel)
//        view.addSubview(categoryView.categoryTableView)
//        view.addSubview(categoryView.emptyImage)
//        view.addSubview(categoryView.emptyLabel)
        view.addSubview(categoryView.addCategoryButton)
        addConstraints()
    }
    
    private func addConstraints() {
        categoryView.categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
//        categoryView.categoryTableView.snp.makeConstraints { make in
//            make.top.equalTo(categoryView.categoryLabel.snp.bottom).offset(38)
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(300)
//        }
        
//        categoryView.emptyImage.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//
//        categoryView.emptyLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.top.equalTo(categoryView.emptyImage.snp.bottom).offset(8)
//        }
        
        categoryView.addCategoryButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
