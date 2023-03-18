//
//  NibLoadableView.swift
//  Validator
//
//  Created by Yaroslav Abaturov on 17.03.2023.
//

import Foundation
import UIKit

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String { return String(describing: self) }
}

extension NibLoadableView where Self: UIViewController {
    static var nibName: String { return String(describing: self) }
}
