//
//  InitialSceneRouter.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

import UIKit

protocol InitialSceneRoutable {
	static func assembly() -> UIViewController
}

final class InitialSceneRouter {
	private weak var view: InitialSceneViewController?
}

extension InitialSceneRouter: InitialSceneRoutable {
	static func assembly() -> UIViewController {
		let router = InitialSceneRouter()
		let vc                  = InitialSceneViewController(nibName: String(describing: InitialSceneViewController.self), bundle: Bundle.main)
		let viewModel           = InitialSceneViewModel()
		let presenterService    = InitialScenePresenterService(withModel: viewModel)
		let presenter           = InitialScenePresenter(for: vc, service: presenterService)
		let interactorService   = InitialSceneInteractorService(withModel: viewModel)
		let interactor          = InitialSceneInteractor(withRouter: router, presenter: presenter, service: interactorService)
		
        vc.interactor = interactor
		router.view = vc
		
		guard let view = router.view else {
			fatalError("cannot instantiate \(String(describing: InitialSceneViewController.self))")
		}
		
		return view
	}
}
