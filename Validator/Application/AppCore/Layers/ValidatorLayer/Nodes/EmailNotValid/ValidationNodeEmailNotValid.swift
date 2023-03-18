//
//  ValidationNodeCompleteness.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 18.03.2023.
//

import Foundation

final class ValidationNodeEmailNotValid {
    private var nextNode: ValidationNodeable?
}

extension ValidationNodeEmailNotValid: ValidationNodeable {
    func setNext(node: ValidationNodeable) {
        nextNode = node
    }
    
    func proceed(with data: AuthDataModel) -> AuthError? {
        let predicate = NSPredicate(format: Constants.predicateFormat, Constants.regEx)
        
        guard predicate.evaluate(with: data.email) else {
            return .invalidEmail
        }
        
        guard let nextNode = nextNode else { return nil }
        
        return nextNode.proceed(with: data)
    }
}

extension ValidationNodeEmailNotValid {
    private struct Constants {
        static let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let predicateFormat = "SELF MATCHES %@"
    }
}
