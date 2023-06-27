//
//  SecondOnboardingViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 27.06.2023.
//

import UIKit
import SnapKit

final class SecondOnboardingViewController: UIViewController {
    private let secondPageView = SecondOnboardingPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTarget()
    }
    
    private func setTarget() {
        secondPageView.switchButton.addTarget(self, action: #selector(switchToTabBarVC), for: .touchUpInside)
    }
    
    @objc private func switchToTabBarVC() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate = scene?.delegate as? SceneDelegate {
            let vc = TabBarController()
            sceneDelegate.window?.rootViewController = vc
            OnboardingManager.hasCompletedOnboarding = true
        }
    }
    
}

extension SecondOnboardingViewController {
    private func setupView() {
        view.addSubview(secondPageView.backgrounView)
        view.addSubview(secondPageView.firstLabel)
        view.addSubview(secondPageView.switchButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        secondPageView.backgrounView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        secondPageView.switchButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        secondPageView.firstLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(secondPageView.switchButton.snp.top).offset(-160)
        }
    }
}
