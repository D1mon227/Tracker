//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit
import SnapKit

final class StatisticViewController: UIViewController {
    
    private let statisticView = StatisticView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension StatisticViewController {
    private func setupViews() {
        view.backgroundColor = .ypWhite
        view.addSubview(statisticView.emptyImage)
        view.addSubview(statisticView.emptyLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        statisticView.emptyImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        statisticView.emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(statisticView.emptyImage.snp.bottom).offset(8)
        }
    }
}
