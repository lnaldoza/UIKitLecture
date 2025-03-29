//
//  ViewCell.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/29/25.
//

import UIKit

class VideoCell: UITableViewCell {
    
    var videoImageView = UIImageView()
    var videoTitleLabel = UILabel() // Renamed for clarity
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews to the content view
        contentView.addSubview(videoImageView)
        contentView.addSubview(videoTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageViewConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(video: Video) {
        videoImageView.image = video.image
        videoTitleLabel.text = video.title
    }
    
    func configureImageView() {
        videoImageView.layer.cornerRadius = 10
        videoImageView.clipsToBounds = true
        videoImageView.contentMode = .scaleAspectFill // Added to improve image display
    }
    
    func configureTitleLabel() {
        videoTitleLabel.numberOfLines = 0
        videoTitleLabel.adjustsFontSizeToFitWidth = true
        videoTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold) // Improved font configuration
    }
    
    func setImageViewConstraints() {
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            videoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            videoImageView.heightAnchor.constraint(equalToConstant: 80),
            videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier: 16/9)
        ])
    }
    
    func setTitleLabelConstraints() {
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), // Adjusted to align vertically
            videoTitleLabel.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 12),
            videoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}
