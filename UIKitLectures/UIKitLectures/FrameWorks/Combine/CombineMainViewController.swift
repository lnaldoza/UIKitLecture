//
//  CombineMainViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/29/25.
//

import UIKit

class CombineMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        let traditionalView = UINavigationController(rootViewController: TraditionaViewController())
        let RefactorCombineView = UINavigationController(rootViewController: RefactorCombineViewController())
        let withCombineView = UINavigationController(rootViewController: WithCombineViewController())
        
        traditionalView.title = "Traditional"
        RefactorCombineView.title = "Refactor Combine"
        withCombineView.title = "With Combine"
        
        setViewControllers([traditionalView, withCombineView, RefactorCombineView], animated: true)
    }
}
