//
//  InitialScenePresenter.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

final class InitialScenePresenter {
	init(for view: InitialSceneViewControllerType, service: InitialScenePresenterServiceType) {
		self.viewController = view
		self.service = service
	}
	
	private var viewController: InitialSceneViewControllerType?
	private let service: InitialScenePresenterServiceType
}

extension InitialScenePresenter: InitialScenePresentable {
	func response(responseType: InitialScenePresenterResponse.InitialSceneResponseType) {
		let model = service.model
		
		switch responseType {
		case .initialSetup: viewController?.update(viewModelDataType: .initialSetup(with: model))
        case .proseed(let result):
            switch result {
            case .success: viewController?.update(viewModelDataType: .showSuccess(with: model))
            case .failure(let error): viewController?.update(viewModelDataType: .showAlert(with: (model: model, description: error.localizedDescription)))
            }
		case .releaseView: viewController = nil
		}
	}
}
