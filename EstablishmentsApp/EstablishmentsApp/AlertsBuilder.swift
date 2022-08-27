//
//  AlertsBuilder.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 27/08/2022.
//

import UIKit

protocol AlertsBuilderProtocol {
  func buildOkAlert(with title: String, message: String) -> UIViewController
  func buildCancelAlert(with message: String, handler: (() -> Void)?) -> UIViewController
}

class AlertsBuilder: AlertsBuilderProtocol {
  
  func buildOkAlert(with title: String, message: String) -> UIViewController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(action)
    return alertController
  }
  
  func buildCancelAlert(with message: String, handler: (() -> Void)?) -> UIViewController {
    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Cancel", style: .default) { _ in
      handler?()
    }
    
    alertController.addAction(action)
    return alertController
  }
  
}
