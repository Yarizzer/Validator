//
//  ValidationNodePasswordNotValid.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 18.03.2023.
//

final class ValidationNodePasswordNotValid {
    private var nextNode: ValidationNodeable?
}

extension ValidationNodePasswordNotValid: ValidationNodeable {
    func setNext(node: ValidationNodeable) {
        nextNode = node
    }
    
    func proceed(with data: AuthDataModel) -> AuthError? {
        guard data.password.count > Constants.passwordLengthLimit else { return .invalidPassword }
        
        guard let nextNode = nextNode else { return nil }
        
        return nextNode.proceed(with: data)
    }
}

extension ValidationNodePasswordNotValid {
    private struct Constants {
        static let passwordLengthLimit = 5
    }
}
