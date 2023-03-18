//
//  AppCore.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//

final class AppCore {
    static let shared = AppCore()
    
    private init() {
        self.validatorL = AppValidatorLayer()
    }
    
    private let validatorL: AppValidatorLayerType
}

extension AppCore: AppCoreValidatable {
    var validatorLayer: AppValidatorLayerType { return validatorL }
}
