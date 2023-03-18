//
//  InitialSceneViewModel.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

protocol InitialSceneViewModelType {
    typealias acData = (title: String, body: String?, actionTitle: String)
    
    var placeholders: [PlaceholderType] { get }
    var authSuccessData: acData { get }
    var authIssueData: acData { get }
    
    func authenticate(with data: AuthDataModel, completion: @escaping (AuthResponse) -> ())
    
}

final class InitialSceneViewModel {
    init() {
        data = [.email(value: Constants.emailPlaceholder),
                .password(value: Constants.passwordPlaceholder),
                .confirmPassword(value: Constants.confirmPasswordPlaceholer)]
    }
    
    private let data: [PlaceholderType]
}

extension InitialSceneViewModel: InitialSceneViewModelType {
    var placeholders: [PlaceholderType] { return data }
    var authSuccessData: acData { return Constants.authSuccessData }
    var authIssueData: acData { return Constants.authIssueData }
    
    func authenticate(with data: AuthDataModel, completion: @escaping (AuthResponse) -> ()) {
        AppCore.shared.validatorLayer.validate(data: data) { completion($0) }
    }
}

extension InitialSceneViewModel {
    private struct Constants {
        static let emailPlaceholder = "email"
        static let passwordPlaceholder = "password"
        static let confirmPasswordPlaceholer = "confirm password"
        static let authSuccessData: acData = (title: "Yay!!!", body: "You're awesome!", actionTitle: "Yes I am awesome")
        static let authIssueData: acData = (title: "Nope", body: nil, actionTitle: "Okay")
    }
}
