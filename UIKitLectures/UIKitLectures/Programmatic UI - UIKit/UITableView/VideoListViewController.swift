//
//  VideoListViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/29/25.
//

import UIKit

class VideoListViewController: UIViewController {
    
    let tableView = UITableView()
    var videos: [Video] = []
    
    struct Cells {
        static let videoCell = "VideoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filipino Foods"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        videos = fetchData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.pin(to: view)
    
        tableView.register(VideoCell.self, forCellReuseIdentifier: Cells.videoCell)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.videoCell) as! VideoCell
        
        let video = videos[indexPath.row]
        cell.set(video: video)
        
        return cell
    }
}


extension VideoListViewController {
    
    func fetchData() -> [Video] {
        let food1 = Video(image: Images.adobo, title: "Chicken Abodo")
        let food2 = Video(image: Images.bicol, title: "Bicol Express")
        let food3 = Video(image: Images.inasal, title: "Chicken Spicy Inasal")
        let food4 = Video(image: Images.dinuguan, title: "Dinuguan")
        let food5 = Video(image: Images.kareKare, title: "Kare Kare")
        let food6 = Video(image: Images.lumpia, title: "Beef Lumpia")
        let food7 = Video(image: Images.pancit, title: "Filipino Pancit Style")
        let food8 = Video(image: Images.sinigang, title: "Sinigang sa Sampalok")
        let food9 = Video(image: Images.sisig, title: "Pork Sisig")
        
        return [food1, food2, food3, food4, food5, food6, food7, food8, food9]
    }
}
