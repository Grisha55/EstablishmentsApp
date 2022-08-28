//
//  MapViewController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

  // MARK: - Properties
  var mapPresenter: MapViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    GMSServices.provideAPIKey("AIzaSyCgqOSF_bVpie7ygNzoLEaOnH1ltJuqPLw")
    
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
    self.view.addSubview(mapView)
    
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    marker.title = "Sydney"
    marker.snippet = "Australia"
    marker.map = mapView
  }
  

  // MARK: - Methods
  

}
