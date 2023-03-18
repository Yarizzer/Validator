//
//  ValidationNodeable.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 18.03.2023.
//

protocol ValidationNodeable {
    func setNext(node: ValidationNodeable)
    func proceed(with data: AuthDataModel) -> AuthError?
}
