//
//  InitialSceneInteractorService.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

protocol InitialSceneInteractorServiceType{
    func authenticate(with data: AuthDataModel, completion: @escaping (AuthResponse) -> ())
}

final class InitialSceneInteractorService {
	init(withModel model: InitialSceneViewModelType) {
		self.viewModel = model
	}
	
	private let viewModel: InitialSceneViewModelType
}

extension InitialSceneInteractorService: InitialSceneInteractorServiceType {
    func authenticate(with data: AuthDataModel, completion: @escaping (AuthResponse) -> ()) {
        viewModel.authenticate(with: data) { completion($0) }
    }
}
