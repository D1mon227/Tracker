//
//  SecondOnboardingPageView.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 27.06.2023.
//

import UIKit

final class SecondOnboardingPageView {
    
    lazy var backgrounView: UIImageView = {
        let element = UIImageView()
        element.image = Resourses.Images.secondPageOfOnboarding
        return element
    }()
    
    lazy var firstLabel: UILabel = {
        let element = UILabel()
        element.textColor = .black
        element.text = "Даже если это\nне литры воды и йога"
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
