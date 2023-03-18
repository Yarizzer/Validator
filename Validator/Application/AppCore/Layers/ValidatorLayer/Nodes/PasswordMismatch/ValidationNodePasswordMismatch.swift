//
//  ValidationNodePasswordMismatch.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 18.03.2023.
//

final class ValidationNodePasswordMismatch {
    private var nextNode: ValidationNodeable?
}

extension ValidationNodePasswordMismatch: ValidationNodeable {
    func setNext(node: ValidationNodeable) {
        nextNode = node
    }
    
    func proceed(with data: AuthDataModel) -> AuthError? {
        guard data.password == data.confirmPassword else { return .passwordMismatch }
        
        guard let nextNode = nextNode else { return nil }
        
        return nextNode.proceed(with: data)
    }
}
