//
//  MapViewPresenter.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

protocol MapViewPresenterProtocol: AnyObject {
  func getEstablishmentsCoordinates()
  func getMenu()
  var establishments: [EstablishModel] { get }
  var menuModels: [MenuModel] { get }
}

class MapViewPresenter: MapViewPresenterProtocol {
  
  // MARK: - Properties
  private var establishmentsRequest: EstablishmentsRequest
  private var menuRequest: MenuRequest
  private var client: StackExchangeClientProtocol
  private var alertsBuilder: AlertsBuilderProtocol
  private var view: MapViewController
  var establishments: [EstablishModel] = []
  var menuModels: [MenuModel] = []
  
  // MARK: - Init
  init(establishmentsRequest: EstablishmentsRequest, menuRequest: MenuRequest, client: StackExchangeClientProtocol, alertsBuilder: AlertsBuilderProtocol, view: MapViewController) {
    self.establishmentsRequest = establishmentsRequest
    self.menuRequest = menuRequest
    self.client = client
    self.alertsBuilder = alertsBuilder
    self.view = view
  }
  
  // MARK: - Methods
  func getMenu() {
    client.getMenu(with: menuRequest) { [weak self] (result) in
      switch result {
      case .failure(let error):
        guard let alert = self?.alertsBuilder.buildCancelAlert(with: error.reason, handler: nil) else { return }
        self?.view.present(alert, animated: true, completion: nil)
      case .success(let menuModels):
        DispatchQueue.main.async {
          self?.menuModels = menuModels
        }
      }
    }
  }
  
  func getEstablishmentsCoordinates() {
    client.getEstablishments(with: establishmentsRequest) { [weak self] (result) in
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
