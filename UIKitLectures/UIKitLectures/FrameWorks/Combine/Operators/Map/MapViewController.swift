//
//  MapViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit
import Combine

struct FormField1 {
    var value : Int
}

class MapViewController : UIViewController {
    
    let textField = UITextField(frame: .zero)
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constructTextField()
        textField.textPublisher
            .map({ value -> FormField1 in
                FormField1(value: Int(value) ?? 0)
            })
            .sink { value in
            print("[DEBUG] \(value)")
        }.store(in: &cancellables)
    }
}

private extension MapViewController {
    
    func constructTextField () {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.textColor = .darkGray
        textField.font = .systemFont(ofSize: 40)
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
}
