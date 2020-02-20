//
//  CollectionListVC.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 2/19/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import UIKit

class CollectionListVC: UIViewController {
    
    var venues: FSCollection! {
        didSet { tableView.reloadData() }
    }
    
    var images: [VenuePhoto]!
    
    lazy var tableView: UITableView = {
        var tv = UITableView()
        tv.register(ListViewCell.self, forCellReuseIdentifier: "ListCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        view.backgroundColor = .white
        view.addSubview(tableView)
        configureTableView()
    }
    
    private func configureViewController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension CollectionListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.collections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venues.collections[indexPath.row]
        //let image = images[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListViewCell else { return UITableViewCell() }
        
        cell.venueImage.image = UIImage(systemName: "location")
        cell.venueName.text = venue.name
        cell.venueAddress.text = venue.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedVenue = self.venues[indexPath.row]
        
        let venueDetailVC = VenueDetailVC()
        //venueDetailVC.venue = selectedVenue
        navigationController?.pushViewController(venueDetailVC, animated: true)
    }
    
    
}
