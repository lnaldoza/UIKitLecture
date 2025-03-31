//
//  CompactMapVC.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit
import Combine

class CompactMapVC : UIViewController {
    
    var cancellable : AnyCancellable!
    
    let dictionary: [Int: String] = [1: "One", 2: "Two", 3: "Three", 5: "Five"]
    let numbers = (0...5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compactMapCombine()
    }
    
    func compactMapCombine() {
        //compactMap skip the nil value also unwrap the value received
        cancellable = numbers.publisher.compactMap({ numberKey -> String? in
            return dictionary[numberKey]
        })
        .sink { value in
            print("[DEBUG] \(value)")
        }
    }
}

