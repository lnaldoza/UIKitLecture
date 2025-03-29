//
//  WithCombineViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/29/25.
//

import UIKit
import Combine

class WithCombineViewController: UIViewController {
    
    var count = 0
    
    let countLabel = UILabel()
    let countButton = UIButton()
    
    let publisher = PassthroughSubject<Int, Never>()
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        bind()
        setupButton()
    }
    
    func bind(){
        let resultPublisher = publisher.map { (input) -> String in
            return "\(input)"
        }
        
        /// assign used for displaying the value on the UI
//        resultPublisher.assign(to: \.text!, on: countLabel)
//            .store(in: &cancellables)
        
        /// sink used on debugging the output value
        resultPublisher.sink { (value) in
            print("[DEBUG] CountValue \(value)")
        }.store(in: &cancellables)
    }

    func setupButton(){
        view.addSubview(countButton)
        
        countButton.configuration = .filled()
        countButton.configuration?.baseBackgroundColor = .systemRed
        countButton.configuration?.title = "Increment"
        
        countButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countButton.widthAnchor.constraint(equalToConstant: 200),
            countButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        countButton.addTarget(self, action: #selector(incrementCount), for: .touchUpInside)
    }
    
    @objc func incrementCount(){
        count += 1
        publisher.send(count)
    }
}

