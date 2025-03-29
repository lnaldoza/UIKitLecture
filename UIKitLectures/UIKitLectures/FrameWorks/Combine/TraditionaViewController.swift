//
//  TraditionaViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/29/25.
//

import UIKit

class TraditionaViewController: UIViewController {
    
    var count = 0
    let countButton = UIButton()
    let countLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupButton()
        setupLabel()
    }
    
    func setupButton() {
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
    
    func setupLabel() {
        view.addSubview(countLabel)
    }
    
    @objc func incrementCount (){
        count += 1
        countLabel.text = "\(count)"
        print("[DEBUG] IncrementCount = \(count)")
    }
}

