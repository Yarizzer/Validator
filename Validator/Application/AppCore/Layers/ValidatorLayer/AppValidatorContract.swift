//
//  AppValidatorContract.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 18.03.2023.
//

import Foundation

typealias AuthResponse = Result<Bool, Error>

enum AuthError {
    case completeness
    case invalidEmail
    case invalidPassword
    case passwordMismatch
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .completeness:     return NSLocalizedString(Constants.notFilled.title, comment: Constants.notFilled.comment)
        case .invalidEmail:     return NSLocalizedString(Constants.invalidEmail.title, comment: Constants.invalidEmail.comment)
        case .invalidPassword:  return NSLocalizedString(Constants.invalidPass.title, comment: Constants.invalidPass.comment)
        case .passwordMismatch: return NSLocalizedString(Constants.passMismatch.title, comment: Constants.passMismatch.comment)
        case .unknownError:     return NSLocalizedString(Constants.unknown.title, comment: Constants.unknown.comment)
        }
    }
}

extension AuthError {
    private struct Constants {
        static let notFilled = (title: "All fields are required.", comment: "")
        static let invalidEmail = (title: "Email format is not valid. (ex: name@domain.com)", comment: "")
        static let invalidPass = (title: "Invalid password length. It should'nt be less than 6 symbols.", comment: "")
        static let passMismatch = (title: "'Password' & 'Confirm password' fields should contain same char sequences.", comment: "")
        static let unknown = (title: "Unknown error, sorry(", comment: "")
    }
}
