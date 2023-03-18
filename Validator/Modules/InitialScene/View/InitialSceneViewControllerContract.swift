//
//  InitialSceneViewControllerContract.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

protocol InitialSceneViewControllerType {
	func update(viewModelDataType: InitialSceneViewControllerViewModel.ViewModelDataType)
}

struct InitialSceneViewControllerViewModel {
	enum ViewModelDataType {
		case initialSetup(with: InitialSceneViewModelType)
        case showAlert(with: (model: InitialSceneViewModelType, description: String))
        case showSuccess(with: InitialSceneViewModelType)
	}
}
