//
//  ViewController.swift
//  mapsTestAPI
//
//  Created by Fabio Sousa da Silva on 21/06/2018.
//  Copyright © 2018 br.com.mapsTestAPI. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON

class ViewController: UIViewController, UISearchBarDelegate{
    
    var latitudeJSON = Double()
    var longitudeJSON = Double()
    var stopNameJSON = String()
    var idJSON = Int()
//    var camera = GMSCameraPosition?
    var mapGSM: GMSMapView?
    var searchController: UISearchController?
    var resultViewController: GMSAutocompleteResultsViewController?
    var resultView: UITextView?
    let marker = GMSMarker()
    let markerPesquisa = GMSMarker()
    
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var viewSearch: UIView!
    //    @IBOutlet weak var searchBar: UISearchBar!
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.text else { return }
//        print(searchText)
//        convertEndereco(endereco: searchText, local: { (coordenadas) in
//            print(coordenadas)
//            if let latitude = coordenadas.location?.coordinate.latitude,
//                let longitude = coordenadas.location?.coordinate.longitude, let nomeLocal = coordenadas.name {
//                let searchProcura = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//                let localInicial = CLLocationCoordinate2D(latitude: self.latitudeJSON, longitude: self.longitudeJSON)
//
//                self.mapGSM?.animate(toLocation: searchProcura)
//                self.mapGSM?.camera = GMSCameraPosition.camera(withTarget: searchProcura, zoom: 14.0)
//                self.markerPesquisa.title = nomeLocal
//                self.markerPesquisa.position = searchProcura
//                self.markerPesquisa.map = self.mapGSM
//
//                let icon = UIImage(named: "carVerde.png")
//                let overlayBounds = GMSCoordinateBounds(coordinate: searchProcura, coordinate: localInicial)
//                let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
//                overlay.bearing = 0
//                overlay.map = self.mapGSM
//
//            } else {
//                print("Nao localizado")
//            }
//
//        })
//
//    }
    
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        let autoCompleteController = GMSAutocompleteViewController()
//        autoCompleteController.delegate = self
//        self.present(autoCompleteController, animated: true)
//    }
    
    func searchBarAuto() {
        
        resultViewController = GMSAutocompleteResultsViewController()
        resultViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultViewController)
        searchController?.searchBar.delegate = self
        
        let subView = UIView(frame: viewSearch.frame)
        
        subView.addSubview((searchController?.searchBar)!)
        self.view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
        
        
    }
    
    func convertEndereco(endereco: String, local: @escaping (_ local: CLPlacemark) -> Void) {
        
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(endereco) { (localiza, erro) in
            if let codeLocaliza = localiza?.first {
                local(codeLocaliza)
            }
        }
        
    }
    
    func viewMap() {
        
        local { (latitude, longitude, stopName, id) in
            self.latitudeJSON = latitude
            self.longitudeJSON = longitude
            self.stopNameJSON = stopName
            self.idJSON = id
        }
        
//        mapGSM = GMSMapView.map(withFrame: <#T##CGRect#>, camera: <#T##GMSCameraPosition#>)
        
//        mapView.map(<#T##transform: (GMSMapView) throws -> U##(GMSMapView) throws -> U#>)
        
        let camera = GMSCameraPosition.camera(withLatitude: latitudeJSON, longitude: longitudeJSON, zoom: 15.0)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        map.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
//        let mapView = GMSMapView.map(withFrame: self.map.frame, camera: camera)
        mapGSM = GMSMapView.map(withFrame: self.map.frame, camera: camera)
//        mapView.settings.compassButton = true
//        mapView.settings.myLocationButton = true
//        self.view.addSubview(mapView)
        //        map.camera = camera
        mapGSM?.settings.compassButton = true
        mapGSM?.settings.myLocationButton = true
        self.view.addSubview(mapGSM!)
        
        marker.position = CLLocationCoordinate2D(latitude: latitudeJSON, longitude: longitudeJSON)
        marker.title = "\(stopNameJSON)"
        marker.snippet = "\(String(describing: idJSON))"
        marker.map = mapGSM

    }
    
    func local(completion: @escaping (_ latitude: Double, _ longitude: Double, _ stopName: String, _ id: Int) -> Void) {
        
        guard let fileName = Bundle.main.path(forResource: "localJSON", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String: Any]
            else { return }
        
        print(dictionary)
        
        let swityJSON = JSON(dictionary)
        let id = swityJSON["id"].intValue
        let stopName = swityJSON["stop_name"].stringValue
        print(stopName)
        let latitude = swityJSON["local"]["latitude"].doubleValue
        print(latitude)
        let longitude = swityJSON["local"]["longitude"].doubleValue
        print(longitude)
        
        completion(latitude, longitude, stopName, id)
        
    }
    
//    override func loadView() {
////        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
////        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
////        view = mapView
////
////        let marker = GMSMarker()
////        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
////        marker.title = "Sydney"
////        marker.snippet = "Australia"
////        marker.map = mapView
//
//
//    }

    override func viewDidAppear(_ animated: Bool) {
        viewMap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarAuto()
        searchController?.searchBar.delegate = self
//        searchBar.delegate = self
//        viewMap()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
//
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
//        print("Error: ", error.localizedDescription)
//    }
//
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
//        searchController?.isActive = false
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
//    }
//
//    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible  = true
//    }
//
//    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible  = false
//    }
//
//}

extension ViewController: GMSAutocompleteViewControllerDelegate, GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")

    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
         print("Error: ", error.localizedDescription)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true)
    }

    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible  = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}

