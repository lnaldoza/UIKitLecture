//
//  UITextField+Ext.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit
import Combine

public extension UITextField {
    var textPublisher : AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for:
                        UITextField
                .textDidChangeNotification,
                       object: self
            )
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? ""  }
            .eraseToAnyPublisher()
    }
}
