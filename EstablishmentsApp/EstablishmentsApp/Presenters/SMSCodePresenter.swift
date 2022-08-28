//
//  SMSCodePresenter.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

protocol SMSCodePresenterProtocol: AnyObject {
  func sendAgainButtonAction(phoneNumber: String?)
  func verifyCodeAction(code: String)
}

class SMSCodePresenter: SMSCodePresenterProtocol {
  
  // MARK: - Properties
  private var alertsBuilder: AlertsBuilderProtocol
  private var view: SMSCodeViewController
  
  // MARK: - Init
  init(alertsBuilder: AlertsBuilderProtocol, view: SMSCodeViewController) {
    self.alertsBuilder = alertsBuilder
    self.view = view
  }
  
  // MARK: - Methods
  func verifyCodeAction(code: String) {
    AuthManager.shared.verifyCode(smsCode: code) { [weak self] (success) in
      guard success else {
        guard let alert = self?.alertsBuilder.buildCancelAlert(with: "Неправильный код", handler: nil) else { return }
        self?.view.present(alert, animated: true, completion: nil)
        return
      }
      
      DispatchQueue.main.async {
        let vc = AssemblyBuilder.shared.createEstablishmetnsVC()
        vc.modalPresentationStyle = .fullScreen
        self?.view.present(vc, animated: true, completion: nil)
      }
    }
  }
  
  func sendAgainButtonAction(phoneNumber: String?) {
    AuthManager.shared.startAuth(phoneNumber: phoneNumber ?? "") { [weak self] (success) in
      guard success else {
        guard let alert = self?.alertsBuilder.buildCancelAlert(with: "Ошибка, связанная с номером телефона", handler: nil) else { return }
        self?.view.present(alert, animated: true, completion: nil)
        return
      }
      self?.view.countDown = 120
      self?.view.setupTimer()
    }
  }
  
}
