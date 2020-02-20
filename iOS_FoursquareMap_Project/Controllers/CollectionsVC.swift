//
//  CollectionsVC.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/6/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class CollectionsVC: UIViewController {
    
    var collections: [FSCollection] = [] {
        didSet { collectionView.reloadData() }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.isHidden = false
        cv.backgroundColor = .clear
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCollections()
        view.backgroundColor = .systemBackground
        view.addSubviews(collectionView)
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadCollections()
    }
    
    private func loadCollections() {
        do { self.collections = try CollectionPersistenceHelper.manager.getEntries()
        } catch {
            print(error)
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    
    @objc func pressed() {
        
    }
    
    
}

extension CollectionsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collection = collections[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
        cell.collectionImage.image = UIImage(systemName: collection.collectionImage)
        cell.collectionLabel.text = collection.collectionName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCollection = self.collections[indexPath.row]
        
        let collectionlistvc = CollectionListVC()
        collectionlistvc.venues = selectedCollection
        navigationController?.pushViewController(collectionlistvc, animated: true)
    }
    
}

