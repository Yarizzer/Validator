//
//  InitialSceneViewController.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

import UIKit

final class InitialSceneViewController: BaseViewController<InitialSceneInteractable> {
	// MARK: View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
        
        registerForKeyboardNotifications()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: Constants.fadeOutAnimationDuration, delay: 0, options: [.curveEaseIn, .allowUserInteraction]) { [weak self] in
            self?.userInputView.alpha = Constants.maxAlphaValue
        }
    }
    
    deinit {
        removeKeyboardNotifications()
    }
	
	private func setup() {
        self.userInputView.alpha = Constants.minAlphaValue
        
		interactor?.makeRequest(requestType: .initialSetup)
	}
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbWillShow(_ notification: Notification) {
        if userInputViewYConstraint.constant == Constants.defaultInputViewConstraintValue {
            let userInfo = notification.userInfo
            let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: { [weak self] in
                guard let sSelf = self else { return }
                
                sSelf.userInputViewYConstraint.constant = sSelf.userInputViewYConstraint.constant - (kbFrameSize.height / 2)
            })
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func kbWillHide(_ notification: Notification) {
        userInputViewYConstraint.constant = Constants.defaultInputViewConstraintValue
        
        self.view.layoutIfNeeded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction private func confirmButtonAction(_ sender: UIButton) {
        guard let email = emailTF.text, let pass = passwordTF.text, let confPass = confirmPasswordTF.text else { return }
        
        interactor?.makeRequest(requestType: .authenticate(withData: AuthDataModel(email: email, password: pass, confirmPassword: confPass)))
    }
    
    @IBOutlet private weak var userInputViewYConstraint: NSLayoutConstraint!
    @IBOutlet private weak var userInputView: UIView!
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var confirmPasswordTF: UITextField!
}

extension InitialSceneViewController: InitialSceneViewControllerType {
	func update(viewModelDataType: InitialSceneViewControllerViewModel.ViewModelDataType) {
		switch viewModelDataType {
		case .initialSetup(let model):
            model.placeholders.forEach {
                switch $0 {
                case .email(let value): emailTF.placeholder = value
                case .password(let value): passwordTF.placeholder = value
                case .confirmPassword(let value): confirmPasswordTF.placeholder = value
                }
            }
        case .showAlert(let data):
            let action = UIAlertAction(title: data.model.authIssueData.actionTitle, style: .default)
            let ac = UIAlertController(title: data.model.authIssueData.title, message: data.description, preferredStyle: .alert)
            ac.addAction(action)
            
            self.present(ac, animated: true)
            
        case .showSuccess(let model):
            view.endEditing(true)
            
            let action = UIAlertAction(title: model.authSuccessData.actionTitle, style: .default) { _ in
                UIView.animate(withDuration: Constants.fadeOutAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
                    self?.userInputView.alpha = Constants.minAlphaValue
                } completion: { [weak self] finished in
                    self?.userInputView.isHidden = finished
                }
            }
            let ac = UIAlertController(title: model.authSuccessData.title, message: model.authSuccessData.body, preferredStyle: .alert)
            ac.addAction(action)
            
            self.present(ac, animated: true)
		}
	}
}

extension InitialSceneViewController {
	private struct Constants {
        static let defaultInputViewConstraintValue: CGFloat = 0.0
        static let minAlphaValue: CGFloat = 0.0
        static let maxAlphaValue: CGFloat = 1.0
        static let fadeOutAnimationDuration: Double = 1.0
	}
}
