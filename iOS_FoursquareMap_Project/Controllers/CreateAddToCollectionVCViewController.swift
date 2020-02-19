//
//  CreateAddToCollectionVCViewController.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 2/19/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import UIKit

class CreateAddToCollectionVCViewController: UIViewController {
    
    // X TO CLOSE, NAV BAR TITLE , CREATE BUTTON
    
    // TEXTFIELD - enter a new collection title
    lazy var nameForNewCollectionTextField: UITextField = {
        var textfield = UITextField()
        return textfield
    }()
    
    // LABEL - Leave A Feedback
    lazy var leaveFeedbackLabel: UILabel = {
        var label = UILabel()
        label.text = "Leave Feedback"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    // TEXTVIEW
    lazy var feedbackTextView: UITextView = {
        var textview = UITextView()
        return textview
    }()
    
    // COLLECTION VIEW
    lazy var displayCllectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
    
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        return cv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
    // FUNC CREATE NEW COLLECTION
    
    // ADD TO EXISTING COLLCTION VIA CV DATASOURCE
    

}
