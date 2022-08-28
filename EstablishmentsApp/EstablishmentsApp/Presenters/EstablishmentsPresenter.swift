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
  
  // Init
  init(request: EstablishmentsRequest, client: StackExchangeClientProtocol, view: EstablishmentsViewController) {
    self.request = request
    self.client = client
    self.view = view
  }
  
  func getEstablishments() {
    client.getPhotos(with: request) { [weak self] (result) in
      switch result {
      case .failure(let error):
        print(error.reason)
      case .success(let establishments):
        DispatchQueue.main.async {
          self?.establishments = establishments
          self?.view.establishmentsCollectionView.reloadData()
        }
      }
    }
  }
  
}
