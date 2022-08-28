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
  
  private var sliderCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collection
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(GMSServices.openSourceLicenseInfo())
    setupMapView()
    createMarkers()
    setupSliderCollectionView()
  }
  
  // MARK: - Methods
  private func setupSliderCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    sliderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.addSubview(sliderCollectionView)
    sliderCollectionView.isHidden = true
    sliderCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MenuCollectionViewCell.self))
    sliderCollectionView.dataSource = self
    sliderCollectionView.delegate = self
    
    sliderCollectionView.translatesAutoresizingMaskIntoConstraints = false
    sliderCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
    sliderCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    sliderCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    sliderCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
  }
  
  private func setupMapView() {
    
    let camera = GMSCameraPosition.camera(withLatitude: 31.35, longitude: 51.234, zoom: 8.0)
    mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
    view.addSubview(mapView)
    mapView.delegate = self
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

// MARK: - UICollectionViewDelegateFlowLayout
extension MapViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = sliderCollectionView.frame.width
    let height = sliderCollectionView.frame.height
    return CGSize(width: width, height: height)
  }
}

// MARK: - UICollectionViewDataSource
extension MapViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mapPresenter.menuModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuCollectionViewCell.self), for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
    let menu = mapPresenter.menuModels[indexPath.row]
    cell.delegate = self
    cell.menuModel = menu
    return cell
  }
}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
  
  func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    mapPresenter.getMenu()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.sliderCollectionView.isHidden = false
      self?.sliderCollectionView.reloadData()
    }
    return true
  }
}

extension MapViewController: MenuCollectionViewCellDelegate {
  
  func closeButtonAction() {
    self.sliderCollectionView.isHidden = true
  }
}
