//
//  ViewController.swift
//  Survey0424
//
//  Created by Paul Neuhold on 19.04.24.
//

import UIKit

class SurveySceenViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    class func create() -> UIViewController? {
        return UIStoryboard.init(name: "SurveyScreen", bundle: nil).instantiateInitialViewController()
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    
    private func animateButton(view: UIView) {
        //scale up animation
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        },completion: { succes in
           
        })
        
        //scale back to normal animation
        UIView.animate(withDuration: 0.15, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
            view.transform = .identity
        }, completion: { success in
            self.presentFeedback()
        })
    }
    
    @IBAction func buttonOneAction(_ sender: Any) {
        viewModel.didClick(result: .sehrGut)
        animateButton(view: buttonOne)
    }
    
    @IBAction func buttonTwoAction(_ sender: Any) {
        viewModel.didClick(result: .gut)
        animateButton(view: buttonTwo)
        
    }
    
    @IBAction func buttonThreeAction(_ sender: Any) {
        viewModel.didClick(result: .neutral)
        animateButton(view: buttonThree)
    }
    
    @IBAction func buttonFourAction(_ sender: Any) {
        viewModel.didClick(result: .schlecht)
        animateButton(view: buttonFour)
    }
    
    var viewModel: SurveySceenViewModel = SurveySceenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.delegate = self
        questionTitleLabel.font = Styles.titleFont
        label.font = Styles.textFont
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questionTitleLabel.text = viewModel.surveyQuestion
        label.text = viewModel.surveySubtitle
    }
    
    private func presentFeedback(){
        let feedback = SurveyFeedbackViewController()
        feedback.modalTransitionStyle = .crossDissolve
        feedback.modalPresentationStyle = .fullScreen
        
        present(feedback, animated: true)
    }
}


extension SurveySceenViewController: SurveySceenViewModelDelegate {
    
}

