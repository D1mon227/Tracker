//
//  FilterViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class FilterViewController: UIViewController {
    
    let titles: [String] = ["Все трекеры", "Трекеры на сегодня", "Завершенные", "Не завершенные"]
    
    private lazy var filterLabel: UILabel = {
        let element = UILabel()
        element.text = "Фильтры"
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    private lazy var filterTableView: UITableView = {
        let element = UITableView()
        element.layer.cornerRadius = 16
        element.separatorStyle = .singleLine
        element.isScrollEnabled = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setupTableView()
    }
    
    private func setupTableView() {
        filterTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "FilterTableViewCell")
        filterTableView.dataSource = self
        filterTableView.delegate = self
    }
}

//MARK: UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(text: titles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

//MARK: UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
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
extension FilterViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(filterLabel)
        view.addSubview(filterTableView)
        addConstraints()
    }
    
    private func addConstraints() {
        filterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        filterTableView.snp.makeConstraints { make in
            make.top.equalTo(filterLabel.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(299)
        }
    }
}


