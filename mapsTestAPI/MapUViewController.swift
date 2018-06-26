//
//  MapUViewController.swift
//  mapsTestAPI
//
//  Created by Fabio Sousa da Silva on 26/06/2018.
//  Copyright © 2018 br.com.mapsTestAPI. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapUViewController: UIViewController, GMSMapViewDelegate {
    
    let markerT = GMSMarker()
    var markerSe = GMSMarker()
    var coordenateMuda = CLLocation()
    
    @IBOutlet weak var googleMap: GMSMapView!
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        print("didChange")
        markerSe.position = CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude)
        
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("idleAt")
        let coordena = CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude)
        let algoTela = GMSGroundOverlay(position: coordena, icon: #imageLiteral(resourceName: "carVerde"), zoomLevel: 16.0)
        algoTela.map = googleMap
        algoTela.isTappable = true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        markerSe.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//                let coordena = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
//                let algoTela = GMSGroundOverlay(position: coordena, icon: #imageLiteral(resourceName: "carVerde"), zoomLevel: 16.0)
//                algoTela.map = googleMap
//                algoTela.isTappable = true
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    
    func mapGoogleConfig() {
        
        let camera = GMSCameraPosition.camera(withLatitude: -23.480049, longitude: -46.603209, zoom: 16.0)
        googleMap.camera = camera
        
        markerT.position = CLLocationCoordinate2DMake(-23.480049, -46.603209)
        markerT.map = googleMap
    
        markerSe.position = CLLocationCoordinate2DMake(-23.480049, -46.603209)
        markerSe.map = googleMap
        markerSe.isDraggable = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleMap.delegate = self
        mapGoogleConfig()

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
