//
//  ListVC.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/12/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    var venues: [Venue]! {
        didSet { tableView.reloadData() }
    }
    
    var images: [Image]!
    
    lazy var tableView: UITableView = {
        var tv = UITableView()
        tv.register(ListViewCell.self, forCellReuseIdentifier: "ListCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venues[indexPath.row]
        //let image = images[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListViewCell else { return UITableViewCell() }
        
        cell.venueImage.image = UIImage()
        cell.venueName.text = venue.name
        cell.venueCategory.text = venue.location?.address
        
        return cell
        
    }
    
    
}
