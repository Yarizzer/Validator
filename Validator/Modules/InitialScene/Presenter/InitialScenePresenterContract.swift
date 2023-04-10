//
//  InitialScenePresenterContract.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

protocol InitialScenePresentable {
    func response(responseType: InitialScenePresenterResponse.InitialSceneResponseType)
}

struct InitialScenePresenterResponse {
	enum InitialSceneResponseType {
		case initialSetup
        case proceed(result: AuthResponse)
		case releaseView
	}
}
