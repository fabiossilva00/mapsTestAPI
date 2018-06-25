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

class MapViewController: UIViewController {
    
    var latitudeJSON = Double()
    var longitudeJSON = Double()
    var stopNameJSON = String()
    var idJSON = Int()
    let marker = GMSMarker()
    let markerPesquisa = GMSMarker()
    
    var mapGMS: GMSMapView?
    
    let viewControl = ViewController()
    
    func viewMap() {
        
        viewControl.local { (latitude, longitude,  stopName, id) in
            self.latitudeJSON = latitude
            self.longitudeJSON = longitude
            self.stopNameJSON = stopName
            self.idJSON = id
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: latitudeJSON, longitude: longitudeJSON, zoom: 15.0)
        mapGMS = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view.addSubview(mapGMS!)
        
        marker.position = CLLocationCoordinate2D(latitude: latitudeJSON, longitude: longitudeJSON)
        marker.title = "\(stopNameJSON)"
        marker.snippet = "\(String(describing: idJSON))"
        marker.map = mapGMS
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
