//
//  FuturePublisherViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit
import Combine

class FuturePublisherViewController : UIViewController {
    
    let label = UILabel()
    
    var store = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
    }
     
    
    fileprivate func peformAsyncTask() {
        let lib = ThirdPartyLibrary()
        label.text = "Performing async task..."
        lib.performAsyncAction { [weak self] in
            self?.label.text = "Async task completed"
        }
    }
    
    fileprivate func performFutureTask() {
        let lib = ThirdPartyLibrary()
        label.text = "Performing future task..."
        
        lib.performAsyncActionFuture().sink { [weak self] in
            self?.label.text = "Future task completed"
        }.store(in: &store)
    }
    
    fileprivate func performFutureTaskError() {
        let lib = ThirdPartyLibrary()
        label.text = "Performing future task with error..."
        
        lib.performAsyncActionFutureError().sink { [weak self] completion in
            switch completion {
            case .failure(.message(let error)):
                self?.label.text = "\(error)"
            case .finished:
                self?.label.text = "Async task completed"
            }
        } receiveValue: {}.store(in: &store)
    }
    
}

class ThirdPartyLibrary {
    
    func performAsyncAction(completionHandler: @escaping () -> Void ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler()
        }
    }
    
    func performAsyncActionFuture() -> Future <Void, Never> {
        return Future() { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(Result.success(()))
            }
        }
    }
    
    func performAsyncActionFutureError() -> Future <Void, AsyncError> {
        return Future() { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(Result.failure(AsyncError.message("Request failed!")))
            }
        }
    }
}

enum AsyncError: Error {
    case message(String)
}
