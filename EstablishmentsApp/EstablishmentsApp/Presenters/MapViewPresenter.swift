//
//  MapViewPresenter.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

protocol MapViewPresenterProtocol: AnyObject {
  func getEstablishmentsCoordinates()
  var establishments: [EstablishModel] { get }
}

class MapViewPresenter: MapViewPresenterProtocol {
  
  // MARK: - Properties
  private var request: EstablishmentsRequest
  private var client: StackExchangeClientProtocol
  private var alertsBuilder: AlertsBuilderProtocol
  private var view: MapViewController
  var establishments: [EstablishModel] = []
  
  // MARK: - Init
  init(request: EstablishmentsRequest, client: StackExchangeClientProtocol, alertsBuilder: AlertsBuilderProtocol, view: MapViewController) {
    self.request = request
    self.client = client
    self.alertsBuilder = alertsBuilder
    self.view = view
  }
  
  // MARK: - Methods
  func getEstablishmentsCoordinates() {
    client.getEstablishments(with: request) { [weak self] (result) in
      switch result {
      case .failure(let error):
        guard let alert = self?.alertsBuilder.buildCancelAlert(with: error.reason, handler: nil) else { return }
        self?.view.present(alert, animated: true, completion: nil)
      case .success(let establishments):
        DispatchQueue.main.async {
          self?.establishments = establishments
        }
      }
    }
  }
  
}
