//
//  ListViewCell.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/12/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    //MARK: VIEWS
    lazy var venueImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var venueName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var venueCategory: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "PodcastCell")
        setupPodcastImageView()
        setupTitleLabel()
        setupHostLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CONSTRAINTS
    private func setupPodcastImageView() {
        addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate(
            [venueImage.heightAnchor.constraint(equalTo: self.heightAnchor),
             venueImage.widthAnchor.constraint(equalTo: venueImage.widthAnchor),
             venueImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
    
    private func setupTitleLabel() {
        let padding: CGFloat = 16
        addSubview(venueName)
        venueName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [venueName.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: padding),
             venueName.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
             venueName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
    }
    
    private func setupHostLabel() {
        let padding: CGFloat = 16
        addSubview(venueCategory)
        venueCategory.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [venueCategory.leadingAnchor.constraint(equalTo: venueName.leadingAnchor),
             venueCategory.topAnchor.constraint(equalTo: venueName.bottomAnchor),
             venueCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)])
    }
}
