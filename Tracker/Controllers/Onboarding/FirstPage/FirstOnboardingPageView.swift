//
//  FirstOnboardingPageView.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 27.06.2023.
//

import UIKit

final class FirstOnboardingPageView {
    
    lazy var backgrounView: UIImageView = {
        let element = UIImageView()
        element.image = Resourses.Images.firstPageOfOnboarding
        return element
    }()
    
    lazy var firstLabel: UILabel = {
        let element = UILabel()
        element.textColor = .black
        element.text = "Отслеживайте только то, что хотите"
        element.font = .boldSystemFont(ofSize: 32)
        element.textAlignment = .center
        element.numberOfLines = 0
        return element
    }()
    
    lazy var switchButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .black
        element.layer.cornerRadius = 16
        element.setTitle("Вот это технологии!", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        return element
    }()
}
