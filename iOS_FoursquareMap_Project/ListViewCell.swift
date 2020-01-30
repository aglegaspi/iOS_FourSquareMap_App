//
//  ListViewCell.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/12/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    //TO-DO make cell look pretty!
    
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
    
    lazy var venueAddress: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "PodcastCell")
        setupVenueImage()
        setupVenueName()
        setupVenueAddress()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CONSTRAINTS
    private func setupVenueImage() {
        addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate(
            [venueImage.heightAnchor.constraint(equalTo: self.heightAnchor),
             venueImage.widthAnchor.constraint(equalToConstant: 100),
             venueImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
    
    private func setupVenueName() {
        let padding: CGFloat = 16
        addSubview(venueName)
        venueName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [venueName.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: padding),
             venueName.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
             venueName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
    }
    
    private func setupVenueAddress() {
        let padding: CGFloat = 16
        addSubview(venueAddress)
        venueAddress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [venueAddress.leadingAnchor.constraint(equalTo: venueName.leadingAnchor),
             venueAddress.topAnchor.constraint(equalTo: venueName.bottomAnchor),
             venueAddress.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)])
    }
}
