//
//  InitialSceneInteractorContract.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

protocol InitialSceneInteractable {
	func makeRequest(requestType: InitialSceneInteractorRequest.RequestType)
}

struct InitialSceneInteractorRequest {
	enum RequestType {
		case initialSetup
        case authenticate(withData: AuthDataModel)
	}
}
