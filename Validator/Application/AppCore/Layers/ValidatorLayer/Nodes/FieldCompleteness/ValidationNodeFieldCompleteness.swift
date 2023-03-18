//
//  ValidationNodeFieldCompleteness.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 18.03.2023.
//

final class ValidationNodeFieldCompleteness {
    private var nextNode: ValidationNodeable?
}

extension ValidationNodeFieldCompleteness: ValidationNodeable {
    func setNext(node: ValidationNodeable) {
        nextNode = node
    }
    
    func proceed(with data: AuthDataModel) -> AuthError? {
        guard !data.email.isEmpty && !data.password.isEmpty && !data.confirmPassword.isEmpty else { return .completeness }
        
        guard let nextNode = nextNode else { return nil }
        
        return nextNode.proceed(with: data)
    }
}
