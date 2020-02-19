//
//  VenueDetailVC.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 2/19/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//
import UIKit

class VenueDetailVC: UIViewController {
    
    var venue: Venue!

    lazy var venueDetailImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "eye")
        return view
    }()
    
    lazy var venueDetailName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = venue.name
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        view.addSubviews(venueDetailImage, venueDetailName)
        configureVenueDetailImage()
        configureVenueDetailName()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToCollection))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addToCollection() {
        
        let createaddcollectionvc = CreateAddToCollectionVCViewController()
        createaddcollectionvc.venueToAdd = self.venue
        navigationController?.pushViewController(createaddcollectionvc, animated: true)
    }
    
    private func configureVenueDetailImage() {
        
        NSLayoutConstraint.activate([
            venueDetailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            venueDetailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            venueDetailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            venueDetailImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureVenueDetailName() {
        
        NSLayoutConstraint.activate([
            venueDetailName.topAnchor.constraint(equalTo: venueDetailImage.bottomAnchor, constant: 10),
            venueDetailName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            venueDetailName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            venueDetailName.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
