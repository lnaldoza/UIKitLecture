//
//  FirstScreenViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/29/25.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemMint
        title = "Main Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupButton()
    }
    
    func setupButton() {
        view.addSubview(nextButton)
        
        nextButton.configuration = .filled()
        nextButton.configuration?.baseBackgroundColor = .systemRed
        nextButton.configuration?.title = "Next"
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        nextButton.addTarget(self, action: #selector(pushToSecondScreen), for: .touchUpInside)
    }
    
    @objc func pushToSecondScreen() {
        let secondScreenViewController = SecondScreenViewController()
        navigationController?.pushViewController(secondScreenViewController, animated: true)
    }
}

