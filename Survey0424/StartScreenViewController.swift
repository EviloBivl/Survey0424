//
//  StartScreenViewController.swift
//  Survey0424
//
//  Created by Paul Neuhold on 19.04.24.
//

import Foundation
import UIKit

final class StartScreenViewController: UIViewController {
    
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var adminButton: UIButton!
    @IBAction func adminAction(_ sender: Any) {
        presentSettingsScreen()
    }
    
    @IBAction func surveyAction(_ sender: Any) {
        presentSurvey()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleButton(with: "Settings", button: adminButton)
        styleButton(with: "Start Survey", button: surveyButton)
    }
    
    func styleButton(with title: String, button: UIButton) {
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.titleLabel?.font = Styles.startButtonFont
    }
    
    func presentSettingsScreen(){
        let controller = SettingsViewController(style: .insetGrouped)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func presentSurvey(){
        guard let controller = SurveySceenViewController.create() else { return }
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
