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
        layout.itemSize = CGSize(width: 100, height: 100)
        
        var cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.isHidden = true
        cv.backgroundColor = .clear
        //cv.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .purple
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
