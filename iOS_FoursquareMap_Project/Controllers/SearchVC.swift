import UIKit
import MapKit
import CoreLocation

class SearchVC: UIViewController {
    
    private var venues = [Venue]() {
        didSet {
            drawAnnotationsOnMap(venues: venues)
        }
    }
    
    private var images = [VenuePhoto]()
    
    //MARK: MAPVIEW FUNCTIONALITY
    private func drawAnnotationsOnMap(venues: [Venue]) {
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        let updatedAnnotations = venues.map(self.annotationsFromVenue)
        self.mapView.addAnnotations(updatedAnnotations)
    }
    
    private func annotationsFromVenue(_ venue: Venue) -> MKPointAnnotation {
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = CLLocationCoordinate2D(latitude: venue.location?.lat ?? 40.6782, longitude: venue.location?.lng ?? -73.9442)
        newAnnotation.title = venue.name
        return newAnnotation
    }
    
    private let locationManager = CLLocationManager()
    
    var currentLocation = CLLocationCoordinate2D.init(latitude: 40.6782, longitude: -73.9442) {
        didSet {
            self.loadVenues(query: self.searchBar.text ?? "", lat: self.currentLocation.latitude, long: self.currentLocation.latitude)
        }
    }
    
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
        button.addTarget(self, action: #selector(listViewButtonPressed), for: .touchDown)
        return button
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        var sb = UISearchBar()
        sb.placeholder = "New York, NY"
        return sb
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        map.showsUserLocation = true
        return map
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        var cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.isHidden = true
        cv.backgroundColor = .clear
        //cv.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        return cv
    }()
    
    
    //MARK: LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadSubViews()
        searchBar.delegate = self
        locationManager.delegate = self
        collectionView.delegate = self
        locationAuthorization()
        loadConstraints()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: PRIVATE FUNCTIONS
    private func loadVenues(query: String, lat: Double, long: Double) {
        VenueAPIHelper.manager.getVenues(query: query, lat: lat, long: long) { (result) in
            switch result {
            case .success(let venuesFromOnline):
                self.venues = venuesFromOnline!
                self.loadImages(venues: self.venues)
                
                //TO-DO: LOAD COLLECTION VIEW
                print("loaded venues")
            case .failure(let error):
                print("Could not load venues: \(error)")
            }
        }
    }
    
    private func loadImages(venues: [Venue]) {
        
        venues.forEach { (venue) in
            ImageAPIHelper.manager.getVenueImageURL(venueID: venue.id ?? "") { (result) in

                switch result {
                case .success(let imageFromFSQ):
                    self.images.append(imageFromFSQ)
                case .failure(let error):
                    print("Could not get Image URL: \(error)")
                }
            }
        }
    }
    
    private func loadSubViews() {
        view.addSubview(searchBar)
        view.addSubview(listButton)
        view.addSubview(locationSearchBar)
        view.addSubview(mapView)
        view.addSubview(collectionView)
    }
    
    private func loadConstraints() {
        constrainSearchBar()
        constrainListButton()
        constrainLocationSearchBar()
        constrainMapView()
        constrainCollectionView()
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
    
    private func constrainCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    //MARK: OBJC FUNCTIONS
    @objc func listViewButtonPressed() {
        let listView = ListVC()
        listView.venues = self.venues
        
        present(listView, animated: true, completion: nil)
    }
    
}


// MARK: LOCATION MANAGER CONFORMANCE
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

//MARK: SEARCHBAR DELEGATE CONFORMANCE
extension SearchVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
                print("\(String(describing: error))")
            } else {
                
                let lat = response?.boundingRegion.center.latitude ?? 40.6782
                let long = response?.boundingRegion.center.longitude ?? -73.9442
                
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 7.0, longitudinalMeters: self.searchRadius * 7.0)
                
                self.mapView.setRegion(coordinateRegion, animated: true)
                
                guard let userInputForVenueName = self.searchBar.text else { return }
                let formattedVenueName = userInputForVenueName.replacingOccurrences(of: " ", with: "+")
                
                self.loadVenues(query: formattedVenueName, lat: lat, long: long)
            }
        }
    }

}



extension SearchVC: UICollectionViewDelegate {
    
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
}
