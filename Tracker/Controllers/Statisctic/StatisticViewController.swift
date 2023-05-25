//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit
import SnapKit

final class StatisticViewController: UIViewController {
    
    private lazy var emptyLabel: UILabel = {
        let element = UILabel()
        element.text = "Анализировать пока нечего"
        element.textColor = .ypBlack
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 12, weight: .medium)
        return element
    }()
    
    private lazy var emptyImage: UIImageView = {
        let element = UIImageView()
        element.image = Resourses.Images.statisticEmptyImage
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

extension StatisticViewController {
    private func setupViews() {
        view.backgroundColor = .ypWhite
        view.addSubview(emptyImage)
        view.addSubview(emptyLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        emptyImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(emptyImage.snp.bottom).offset(8)
        }
    }
}
