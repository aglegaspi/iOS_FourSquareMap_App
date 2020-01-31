//
//  CollectionsVC.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/6/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class CollectionsVC: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        var cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //cv.isHidden = false
        cv.backgroundColor = .clear
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .purple
        view.addSubview(collectionView)
        //constrainCollectionView()
    }
    
    
    private func constrainCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    
}

extension CollectionsVC: UICollectionViewDelegate { }

extension CollectionsVC: UICollectionViewDelegateFlowLayout { }

extension CollectionsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath)

       cell.backgroundColor = UIColor.green
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 25)
    }
}

