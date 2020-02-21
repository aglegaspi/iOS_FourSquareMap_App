//
//  CollectionViewCell.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 1/31/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseID = "CollectionCell"
    
    var collectionImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "no_venue_image")
        imageView.tintColor = .systemBackground
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var collectionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Name"
        label.adjustsFontSizeToFitWidth = true // how it scales to device/view
        label.minimumScaleFactor = 0.50 // does down to 75% of the size
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemYellow.withAlphaComponent(0.75)
        layer.cornerRadius = 20
        addSubviews(collectionImage,collectionLabel)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            collectionImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            collectionImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            collectionImage.heightAnchor.constraint(equalToConstant: 60),
            
            collectionLabel.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 2),
            collectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            collectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            collectionLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
}
