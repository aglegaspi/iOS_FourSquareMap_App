//
//  SearchVC.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/6/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SearchVC: UIViewController {
    
    var searchString: String? = nil {
        didSet {
            //mapView.addAnnotations(libraries.filter { $0.hasValidCoordinates })
        }
    }
    
    private let locationManager = CLLocationManager()
    
    let initialLocation = CLLocation(latitude: 40.742054, longitude: -73.769417)
    let searchRadius: CLLocationDistance = 2000
    
    //MARK: VIEWS
    lazy var searchBar: UISearchBar = {
        var sb = UISearchBar()
        sb.placeholder = "Search For Venue"
        return sb
    }()
    
    lazy var listButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setImage(UIImage(named: "listview"), for: .normal)
        return button
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        var sb = UISearchBar()
        sb.placeholder = "New York, NY"
        return sb
    }()
    
    lazy var mapView: MKMapView = {
        var mv = MKMapView()
        return mv
    }()
    
    
    
    //MARK: LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        loadSubViews()
        searchBar.delegate = self
        locationManager.delegate = self
        locationAuthorization()
        loadConstraints()
    }
    
    
    
    // PRIVATE FUNCTIONS
    private func loadSubViews() {
        view.addSubview(searchBar)
        view.addSubview(listButton)
        view.addSubview(locationSearchBar)
        view.addSubview(mapView)
    }
    
    private func loadConstraints() {
        constrainSearchBar()
        constrainListButton()
        constrainLocationSearchBar()
        constrainMapView()
    }
    
    private func locationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: CONSTRAINTS
    private func constrainSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60)
        ])
    }
    
    private func constrainListButton() {
        listButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listButton.leadingAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.trailingAnchor),
            listButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            listButton.heightAnchor.constraint(equalToConstant: 57)
        ])
    }
    
    private func constrainLocationSearchBar() {
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationSearchBar.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            locationSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func constrainMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


// MARK: CLLocationManagerDelegate Conformance
extension SearchVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New locations \(locations)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occurred: \(error)")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
        }
    }
}

//MARK: SEARCHBAR DELEGATE CONFORM
extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response,error) in
            activityIndicator.stopAnimating()
            
            if response == nil {
                print(error)
            } else {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
            }
            
            let latitud = response?.boundingRegion.center.latitude
            let longitud = response?.boundingRegion.center.longitude
            
            let newAnnotation = MKPointAnnotation()
            newAnnotation.title = searchBar.text
            newAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitud!, longitude: longitud!)
            self.mapView.addAnnotation(newAnnotation)
            
            // TO ZOOM IN THE ANNOTATION
            let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 2.0, longitudinalMeters: self.searchRadius * 2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)
        }
    }

    
}
