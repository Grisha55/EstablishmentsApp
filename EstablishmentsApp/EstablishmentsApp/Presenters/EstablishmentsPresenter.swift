//
//  EstablishmentsPresenter.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

protocol EstablishmentsPresenterProtocol: AnyObject {
  
}

class EstablishmentsPresenter: EstablishmentsPresenterProtocol {
  
  // MARK: - Properties
  var establishments: [EstablishModel] = []
  var request: EstablishmentsRequest
  var client: StackExchangeClientProtocol
  var view: EstablishmentsViewController
  var alertsBuilder: AlertsBuilderProtocol
  
  // Init
  init(request: EstablishmentsRequest, client: StackExchangeClientProtocol, view: EstablishmentsViewController, alertsBuilder: AlertsBuilderProtocol) {
    self.request = request
    self.client = client
    self.view = view
    self.alertsBuilder = alertsBuilder
  }
  
  // MARK: - Methods
  func getEstablishments() {
    client.getEstablishments(with: request) { [weak self] (result) in
      switch result {
      case .failure(_):
        guard let alert = self?.alertsBuilder.buildCancelAlert(with: "Ошибка сервера, попробуйте позже!", handler: nil) else { return }
        self?.view.present(alert, animated: true, completion: nil)
      case .success(let establishments):
        DispatchQueue.main.async {
          self?.establishments = establishments
          self?.view.establishmentsCollectionView.reloadData()
        }
      }
    }
  }
  
}
