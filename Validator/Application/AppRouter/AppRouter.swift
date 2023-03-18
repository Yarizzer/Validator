//
//  AppRouter.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//

import UIKit

protocol AppRoutable {
    func routeToInitialScene()
}

final class AppRouter {
    init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .systemBackground
        self.window = window
    }
    
    private let window: UIWindow
}

extension AppRouter: AppRoutable {
    func routeToInitialScene() {
        window.rootViewController = InitialSceneRouter.assembly()
        window.makeKeyAndVisible()
    }
}
