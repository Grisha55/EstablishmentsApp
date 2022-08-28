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
  
  private var mapView: GMSMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(GMSServices.openSourceLicenseInfo())
    setupMapView()
    createMarkers()
  }
  
  // MARK: - Methods
  private func setupMapView() {
    
    let camera = GMSCameraPosition.camera(withLatitude: 31.35, longitude: 51.234, zoom: 8.0)
    mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
    view.addSubview(mapView)
  }
  
  private func createMarkers() {
    mapPresenter.getEstablishmentsCoordinates()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      for index in 0..<(self?.mapPresenter.establishments.count ?? 0) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self?.mapPresenter.establishments[index].lat ?? 0.0, longitude: self?.mapPresenter.establishments[index].lon ?? 0.0)
        marker.title = self?.mapPresenter.establishments[index].name
        marker.map = self?.mapView
      }
    }
  }

}
