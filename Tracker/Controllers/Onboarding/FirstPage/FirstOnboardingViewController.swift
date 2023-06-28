//
//  FirstOnboardingViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 27.06.2023.
//

import UIKit
import SnapKit

final class FirstOnboardingViewController: UIViewController {
    private let firstPageView = FirstOnboardingPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTarget()
    }
    
    private func setTarget() {
        firstPageView.switchButton.addTarget(self, action: #selector(switchToTabBarVC), for: .touchUpInside)
    }
    
    @objc private func switchToTabBarVC() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate = scene?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            let vc = TabBarController()
            sceneDelegate.window?.rootViewController = vc
            OnboardingManager.hasCompletedOnboarding = true

            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
}

extension FirstOnboardingViewController {
    private func setupView() {
        view.addSubview(firstPageView.backgrounView)
        view.addSubview(firstPageView.firstLabel)
        view.addSubview(firstPageView.switchButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        firstPageView.backgrounView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        firstPageView.switchButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        firstPageView.firstLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(firstPageView.switchButton.snp.top).offset(-160)
        }
    }
}
