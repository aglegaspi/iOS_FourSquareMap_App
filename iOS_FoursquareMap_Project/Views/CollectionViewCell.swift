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
        imageView.image = UIImage(systemName: "list.bullet")
        return imageView
    }()
    
    var collectionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "Collection Name"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
        addSubviews(collectionImage,collectionLabel)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImage.heightAnchor.constraint(equalToConstant: 100),
            
            collectionLabel.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 12),
            collectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            collectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            collectionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
