//
//  CreateAddToCollectionVCViewController.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 2/19/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import UIKit

class CreateAddToCollectionVCViewController: UIViewController {
    
    var venueToAdd: Venue!
    var collections: [FSCollection] = [] {
        didSet { displayCollectionView.reloadData() }
    }
    let padding: CGFloat = 15
    var nameOfNewCollection: String = ""
    
    // X TO CLOSE, NAV BAR TITLE , CREATE BUTTON
    
    // TEXTFIELD - enter a new collection title
    lazy var nameForNewCollectionTextField: UITextField = {
        var textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textAlignment = .center
        textfield.placeholder = "enter name of collection"
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
        textview.font = UIFont.systemFont(ofSize: 18)
        return textview
    }()
    
    // COLLECTION VIEW
    lazy var displayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
    
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(DisplayCollectionCell.self, forCellWithReuseIdentifier: DisplayCollectionCell.reuseID)
        return cv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        view.addSubviews(nameForNewCollectionTextField,
                         leaveFeedbackLabel,
                         feedbackTextView,
                         displayCollectionView)
        
        configureNameForNewCollectionTextField()
        configureLeaveFeedbackLabel()
        configureFeedbackTextView()
        configureDisplayCollectionView()
        loadCollections()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        self.title = "Add To / Create Collection"
        
        let createButton =  UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(addToNewCollection))
        navigationItem.rightBarButtonItem = createButton
    }

    
    @objc func addToNewCollection() {
        
        guard let collectionName = nameForNewCollectionTextField.text,
            let venueName = venueToAdd.name,
            let address = venueToAdd.location?.address,
            let collectionfFeedback = feedbackTextView.text else { return }
        
        let newFavorite = FSFavorite(name: venueName, address: address, image: "eye", feedback: "nothing")
        
        let newCollection = FSCollection(collectionUID: UUID().uuidString, collections: [newFavorite], collectionName: collectionName, collectionImage: "eye", collectionFeedback: collectionfFeedback)
        
        do {
            try CollectionPersistenceHelper.manager.save(entry: newCollection)
        } catch {
            print(error)
        }
        
    }
    
    private func loadCollections() {
        do { self.collections = try CollectionPersistenceHelper.manager.getEntries()
        } catch {
            print(error)
        }
    }
    
    private func configureNameForNewCollectionTextField() {
        nameForNewCollectionTextField.delegate = self
        nameForNewCollectionTextField.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                nameForNewCollectionTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
                nameForNewCollectionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                nameForNewCollectionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                nameForNewCollectionTextField.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    private func configureLeaveFeedbackLabel() {
        leaveFeedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                leaveFeedbackLabel.topAnchor.constraint(equalTo: nameForNewCollectionTextField.bottomAnchor, constant: padding),
                leaveFeedbackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                leaveFeedbackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                leaveFeedbackLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    
    private func configureFeedbackTextView() {
        feedbackTextView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            feedbackTextView.topAnchor.constraint(equalTo: leaveFeedbackLabel.bottomAnchor, constant: padding),
            feedbackTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            feedbackTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            feedbackTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureDisplayCollectionView() {
        displayCollectionView.delegate = self
        displayCollectionView.dataSource = self
        displayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            displayCollectionView.topAnchor.constraint(equalTo: feedbackTextView.bottomAnchor, constant: padding),
            displayCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            displayCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            displayCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
            
        ])
    }
    
}


extension CreateAddToCollectionVCViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collection = collections[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DisplayCollectionCell.reuseID, for: indexPath) as! DisplayCollectionCell
        cell.collectionLabel.text = collection.collectionName
        cell.collectionImage.image = UIImage(systemName: collection.collectionImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // ADD ITEM TO THIS COLLECTION
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}

extension CreateAddToCollectionVCViewController: UITextFieldDelegate {
    
  
}
