//
//  BaseViewController.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//

import UIKit

class BaseViewController<InteractorT>: UIViewController {
    override func viewDidLoad() { super.viewDidLoad() }
    
    var interactor: InteractorT?
}
