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
    var coordena = CLLocationCoordinate2D()
    
    @IBOutlet weak var googleMap: GMSMapView!
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        print("didChange")
        markerSe.position = CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude)
        
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("idleAt")
        coordena = CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude)
        
        UIView.animate(withDuration: 2.5, animations: {
            self.londonView?.tintColor = .blue
        }) { (finished) in
            self.lodon?.tracksViewChanges = false
        }
        
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
    
//    private var infoWindow = mapView(<#T##mapView: GMSMapView##GMSMapView#>, markerInfoWindow: <#T##GMSMarker#>)
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        <#code#>
//    }
    
    func mapGoogleConfig() {
        
        let camera = GMSCameraPosition.camera(withLatitude: -23.480049, longitude: -46.603209, zoom: 16.0)
        googleMap.camera = camera
        
        markerT.position = CLLocationCoordinate2DMake(-23.480049, -46.603209)
        markerT.map = googleMap
    
        markerSe.position = CLLocationCoordinate2DMake(-23.480049, -46.603209)
        markerSe.map = googleMap
        markerSe.isDraggable = true
        markerSe.icon = UIImage(named: "mira")
    }
    
    func makeOverlay(coordenadas: CLLocationCoordinate2D) {
        
        markerT.map = nil
    
        let marker = GMSMarker(position: coordenadas)
        marker.icon = UIImage(named: "ghostBlue")
        marker.icon = GMSMarker.markerImage(with: .black)
        marker.map = googleMap
        
    }
    
    var londonView: UIImageView?
    var lodon: GMSMarker?
    
    func makeMarker(coordenadas: CLLocationCoordinate2D){
        
        let marker = GMSMarker(position: coordenadas)
        
        let house = UIImage(named: "ghostBlue")!.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: house)
        markerView.tintColor = .white
        londonView = markerView
        
        marker.title = "Bu!"
        marker.snippet = "Fantasmaaa!"
        
//        marker.infoWindowAnchor = CGPoint(x: 2.5, y: 0.5)
        
//        marker.accessibilityLabel =
        
        marker.iconView = markerView
        marker.tracksViewChanges = true
        
        marker.map = googleMap
        lodon = marker
        
    }
    
    func markerComID(coordenadas: CLLocationCoordinate2D, imagem: String, titulo: String, descricao: String) -> GMSMarker {
        let marker =  GMSMarker(position: coordenadas)
        marker.icon = UIImage(named: imagem)
        marker.title = title
        marker.snippet = descricao
       
        return marker
    }
    
    
    @IBAction func redButton(_ sender: Any) {
        makeMarker(coordenadas: coordena)
    }
    
    @IBAction func blueButton(_ sender: Any) {
//        makeOverlay(coordenadas: coordena)
        googleMap.clear()
    }
    
    @IBAction func whiteButton(_ sender: Any) {
        
        ComunicacoesAlamoFire().markePost(titulo: "Teste", latitude: coordena.latitude, longitude: coordena.longitude, imagem: "ghostBlue", descricao: "Descricao Teste", completion: { (error, id) in
            if !error{
//                let marker = self.markerComID(coordenadas: self.coordena, imagem: "ghostImage", titulo: "Teste 2", descricao: "Teste Descricao 2")
//                marker.map = self.googleMap
                
            }else{
                print("Deu Merda")
            }
        })
        
    }
    
    @IBAction func blackButton(_ sender: Any) {
        
        ComunicacoesAlamoFire().markerGet { (id, descricao, imagem, latitude, longitude) in
            
            for indx in 0...(id.count - 1) {
                print(indx)

                self.markerArray(id: id[indx], descricao: descricao[indx], imagem: imagem[indx], latitude: latitude[indx], longitude: longitude[indx])
            }
            
        }
        
    }
    
    func markerArray(id: String, descricao: String, imagem: String, latitude: Double, longitude: Double) {
        
        let coordenadas = CLLocationCoordinate2DMake(latitude, longitude)
        let marker = GMSMarker(position: coordenadas)
        
        marker.icon = UIImage(named: imagem)
        marker.title = id
        marker.snippet = descricao
        
        marker.map = googleMap
        
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
