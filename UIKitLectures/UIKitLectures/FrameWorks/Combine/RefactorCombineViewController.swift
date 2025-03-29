//
//  RefactorCombineViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/29/25.
//

import UIKit
import Combine

class RefactorCombineViewController : UIViewController {
    
    var count = Counter()
    
    let countLabel = UILabel()
    let countButton = UIButton()
    
    let publisher = PassthroughSubject<Int, Never>()
    
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        bind()
        setupButton()
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
    
    func bind() {
        
//        count.$value.assign(to: \.text!, on: countLabel).store(in: &cancellable)
        
        count.$value.sink {(inValue) in
            print("[DEBUG] Value \(inValue)")
        }.store(in: &cancellable)
    }
    
    @objc func incrementCount(){
        count.increment()
    }
}

class Counter {
    
    @Published private(set) var value: String = "0"
    
    private var current = 0
    
    func increment() {
        current += 1
        value = "\(current)"
    }
    
}
