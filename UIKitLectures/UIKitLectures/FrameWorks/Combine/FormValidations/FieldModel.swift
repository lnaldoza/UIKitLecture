//
//  Untitled.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import Foundation

class FieldModel {
    var id = UUID()
    var hint = "Not Set"
    @Published var value = ""
    
    init(hint: String) {
        self.hint = hint
    }
}

extension FieldModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FieldModel, rhs: FieldModel) -> Bool {
        return lhs.id == rhs.id
    }
}

