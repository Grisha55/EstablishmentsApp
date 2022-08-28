//
//  RegistrationPresenter.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation
import UIKit

protocol RegistrationPresenterProtocol: AnyObject {
  func takeCodeButtonAction(phoneTextField: UITextField)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
  
  // MARK: - Properties
  private var alertsBuilder: AlertsBuilderProtocol
  private var view: RegistrationViewController
  
  // MARK: - Init
  init(alertsBuilder: AlertsBuilderProtocol, view: RegistrationViewController) {
    self.alertsBuilder = alertsBuilder
    self.view = view
  }
  
  // MARK: - Methods
  func takeCodeButtonAction(phoneTextField: UITextField) {
    if let text = phoneTextField.text, !text.isEmpty, text.count == 12 {
      if text.contains("+7") {
        AuthManager.shared.startAuth(phoneNumber: text) { [weak self] (success) in
          guard success else {
            guard let alert = self?.alertsBuilder.buildCancelAlert(with: "Ошибка, связанная с номером телефона", handler: nil) else { return }
            self?.view.present(alert, animated: true, completion: nil)
            return
          }
          
          DispatchQueue.main.async {
            let vc = AssemblyBuilder.shared.createSMSCodeVC(phoneNumber: text)
            vc.title = "Введите код"
            self?.view.navigationController?.pushViewController(vc, animated: true)
          }
        }
      } else {
        let alert = alertsBuilder.buildCancelAlert(with: "Неправильно набран номер", handler: nil)
        self.view.present(alert, animated: true, completion: nil)
      }
    } else {
      let alert = alertsBuilder.buildCancelAlert(with: "Неправильно набран номер", handler: nil)
      self.view.present(alert, animated: true, completion: nil)
    }
  }
  
}
