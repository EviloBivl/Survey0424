//
//  SurveyFeedbackViewController.swift
//  Survey0424
//
//  Created by Paul Neuhold on 19.04.24.
//

import Foundation
import UIKit


final class SurveyFeedbackViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = Styles.titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Styles.textFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topPlaceHolder: UIView = {
       return UIView()
    }() 
    
    lazy var bottomPlaceHolder: UIView = {
       return UIView()
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bottomPlaceHolder,titleLabel, descriptionLabel, topPlaceHolder])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var timer: Timer?
    var feedBackTitle: String? {
        return (UserDefaults.standard.value(forKey: SettingsViewModel.surveyFeedbackTitle) as? String)
    }
    
    var feedbackSubtitle: String? {
        (UserDefaults.standard.value(forKey: SettingsViewModel.surveyFeedbackSubtitle) as? String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = SurveyState.shared.feedBackTitle
        descriptionLabel.text = SurveyState.shared.feedbackSubtitle
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            bottomPlaceHolder.heightAnchor.constraint(equalTo: topPlaceHolder.heightAnchor)
        ])
        
        timer = Timer.scheduledTimer(withTimeInterval: SurveyState.feedbackScreenDuration, repeats: false, block: {
            timer in
            timer.invalidate()
            self.dismiss(animated: true)
        })
        
        if let storedValue = feedBackTitle, !storedValue.isEmpty {
            titleLabel.text = storedValue
        }
        
        if let storedValue = feedbackSubtitle, !storedValue.isEmpty {
            descriptionLabel.text = storedValue
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @objc private func didTap(){
        self.dismiss(animated: true)
    }
}
