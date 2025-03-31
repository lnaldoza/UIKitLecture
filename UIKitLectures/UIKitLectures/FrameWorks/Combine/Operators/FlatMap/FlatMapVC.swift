//
//  FlatMapVC.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit
import Combine

class FlatMapVC : UIViewController {
    
    var blogPublisher = PassthroughSubject<PostQuery, Never>()
    
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
        
        let publisher = blogPublisher.flatMap(maxPublishers: .unlimited) {
            query -> URLSession.DataTaskPublisher in
            
            let endPointUrl = URL(string: "https:jsonplaceholder.typicode.com/posts/\(query.id)")!
            
            return URLSession.shared.dataTaskPublisher(for: endPointUrl)
        }
        .eraseToAnyPublisher()
        
        publisher.map {
            $0.data
        }
        //decode used to transform the map data to decode type and decoder style
        .decode(type: PostModel.self, decoder: JSONDecoder())
        
        .sink { completion in
            switch completion {
            case .finished :
                print("[DEBUG] Finished completion")
            case .failure(let error) :
                print("[DEBUG] Error \(error)")
            }
        } receiveValue: { value in
            print("[DEBUG] Received Value = \(value)")
        }.store(in: &cancellables)

        
        blogPublisher.send(PostQuery(id: "1"))
        blogPublisher.send(PostQuery(id: "2"))
    }
}
