//
//  MulticastPublisherViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit
import Combine

class MulticastPublisherViewController : UIViewController {
    
    let debugView1 = UITextView()
    let debugView2 = UITextView()
    let debugView3 = UITextView()
    
    var cancellables: Set<AnyCancellable> = []
    
    let subject = PassthroughSubject<String, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayViews()
    }
    
    func displayViews() {
        view.addSubview(debugView1)
        view.addSubview(debugView2)
        view.addSubview(debugView3)
    }
    
    func valuePublisher() -> Publishers.Zip<Publishers.Sequence<[Int], Never>, Publishers.Autoconnect<Timer.TimerPublisher>> {
        
        let timerPublisher = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
        
        return Publishers.Zip([1,2,3,4,5,6,7].publisher, timerPublisher)
    }
    
    func simpleMulticast() {
        let zipPublisher = valuePublisher()
        
        let publisher = zipPublisher
            .print()
            .map({ (tuplex) -> String in
                return  "\(tuplex.0)"
            })
            .eraseToAnyPublisher()
        
        publisher
            .map {"\(self.debugView1.text ?? "")\n\($0)"}
            .assign(to: \.text, on: self.debugView1)
            .store(in: &cancellables)
        
        publisher
            .map {"\(self.debugView2.text ?? "")\n\($0)"}
            .assign(to: \.text, on: self.debugView2)
            .store(in: &cancellables)
    }
    
    func multiCastWithSubject() {
        let zipPublisher = valuePublisher()
        
        let publisher = zipPublisher
            .map { "\($0.0)" }
            .print()
            .eraseToAnyPublisher()
        
        let multiCast = publisher.multicast(subject: subject)
        
        publisher
            .map { "\(self.debugView1.text ?? "") \n\($0)"}
            .assign(to: \.text, on: debugView1)
            .store(in: &cancellables)
        
        publisher
            .map { "\(self.debugView2.text ?? "") \n\($0)"}
            .assign(to: \.text, on: debugView2)
            .store(in: &cancellables)
        
        // To Align the new value
        self.debugView3.text = "\n\n\n"
        
        multiCast.connect().store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            publisher
                .map{"\(self.debugView3.text ?? "") \n \($0)"}
                .assign(to: \.text, on: self.debugView3)
                .store(in: &self.cancellables)
        }
        
    }
    
    func shareMulticast() {
        
        let zipPublisher = valuePublisher()
        
        let publisher = zipPublisher
            .map { $0.0}
            .print()
            .eraseToAnyPublisher()
        
        let multicastSubject = publisher.share()
        
        multicastSubject
            .map{"\(self.debugView1.text ?? "") \n \($0)"}
            .assign(to: \.text, on: debugView1)
            .store(in: &cancellables)
        
        multicastSubject
            .map{"\(self.debugView2.text ?? "") \n \($0)"}
            .assign(to: \.text, on: debugView2)
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            multicastSubject
                .map{"\(self.debugView3.text ?? "") \n \($0)"}
                .assign(to: \.text, on: self.debugView3)
                .store(in: &self.cancellables)
        }
    }
}
