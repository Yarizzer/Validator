//
//  AppValidatorLayer.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//

protocol AppValidatorLayerType {
    func validate(data: AuthDataModel, completion: @escaping (AuthResponse) -> ())
}

final class AppValidatorLayer {
    init() {
        let passwordMismatchNode = ValidationNodePasswordMismatch()
        let passwordNotValid = ValidationNodePasswordNotValid()
        let completenessValid = ValidationNodeFieldCompleteness()
        let emailValid = ValidationNodeEmailNotValid()
        
        passwordNotValid.setNext(node: passwordMismatchNode)
        completenessValid.setNext(node: passwordNotValid)
        emailValid.setNext(node: completenessValid)
        
        validationChain = [emailValid,
                           completenessValid,
                           passwordNotValid,
                           passwordMismatchNode]
    }
    
    private let validationChain: [ValidationNodeable]
}

extension AppValidatorLayer: AppValidatorLayerType {
    func validate(data: AuthDataModel, completion: @escaping (AuthResponse) -> ()) {
        guard !validationChain.isEmpty else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard let error = validationChain[0].proceed(with: data) else {
            completion(.success(true))
            return
        }
        
        completion(.failure(error))
    }
}
