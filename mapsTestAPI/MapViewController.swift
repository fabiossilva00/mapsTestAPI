//
//  MapViewController.swift
//  mapsTestAPI
//
//  Created by Fabio Sousa da Silva on 22/06/2018.
//  Copyright © 2018 br.com.mapsTestAPI. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

class MapViewController: UIViewController {
    
    var latitudeJSON = Double()
    var longitudeJSON = Double()
    var stopNameJSON = String()
    var idJSON = Int()
    let marker = GMSMarker()
    let markerPesquisa = GMSMarker()
    var inicialCoord = CLLocation()
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var mapGMS: GMSMapView?
    
    @IBOutlet weak var map: UIView!    
    @IBOutlet weak var search: UIView!
    
    let viewControl = ViewController()
    
    func viewMap() {
        
        viewControl.local { (latitude, longitude,  stopName, id) in
            self.latitudeJSON = latitude
            self.longitudeJSON = longitude
            self.stopNameJSON = stopName
            self.idJSON = id
            self.inicialCoord = CLLocation(latitude: latitude, longitude: longitude)
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: latitudeJSON, longitude: longitudeJSON, zoom: 15.0)
        mapGMS = GMSMapView.map(withFrame: self.map.frame, camera: camera)
        mapGMS?.
        self.view.addSubview(mapGMS!)
        
        marker.position = CLLocationCoordinate2D(latitude: latitudeJSON, longitude: longitudeJSON)
        marker.title = "\(stopNameJSON)"
        marker.snippet = "\(String(describing: idJSON))"
        marker.map = mapGMS
        
    }
    
    func searchBarControl() {
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        search.addSubview((searchController?.searchBar)!)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
        
    }
    
    func drawLines(inicialLocation: CLLocation, finalLocation: CLLocation){
        
        print(inicialCoord)
        let origin = "\(inicialLocation.coordinate.latitude), \(inicialLocation.coordinate.longitude)"
        let destination = "\(finalLocation.coordinate.latitude),\(finalLocation.coordinate.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        print("URL", url)
        
        Alamofire.request(url).validate().responseJSON() { response in
            switch response.result {
            case .success:
                print(response.debugDescription)
                break
            case .failure:
                print(response.debugDescription)
                break
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMap()
        searchBarControl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        
        let final = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0)
        
        drawLines(inicialLocation: inicialCoord, finalLocation: final)
        self.mapGMS?.camera = camera
        
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(place.attributions)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
