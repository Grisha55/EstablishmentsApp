//
//  AssemblyBuilder.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import UIKit

class AssemblyBuilder {
  
  static let shared = AssemblyBuilder()
  
  func createMapVC() -> UIViewController {
    let view = MapViewController()
    let request = EstablishmentsRequest.from()
    let client = StackExchangeClient()
    let alertsBuilder = AlertsBuilder()
    let mapPresenter = MapViewPresenter(request: request, client: client, alertsBuilder: alertsBuilder, view: view)
    
    view.mapPresenter = mapPresenter
    
    return view
  }
  
  func createEstablishmetnsVC() -> UIViewController {
    let view = EstablishmentsViewController()
    let alertsBuilder = AlertsBuilder()
    let request = EstablishmentsRequest.from()
    let client = StackExchangeClient()
    let establishmentsPersenter = EstablishmentsPresenter(request: request, client: client, view: view, alertsBuilder: alertsBuilder)
    
    view.establishmentsPresenter = establishmentsPersenter
    
    return view
  }
  
  func createSMSCodeVC(phoneNumber: String) -> UIViewController {
    let view = SMSCodeViewController(phoneNumber: phoneNumber)
    let alertsBuilder = AlertsBuilder()
    let smsCodePresenter = SMSCodePresenter(alertsBuilder: alertsBuilder, view: view)
    
    view.smsCodePresenter = smsCodePresenter
    
    return view
  }
  
  func createRegistrationVC() -> UIViewController {
    let view = RegistrationViewController()
    let alertsBuilder = AlertsBuilder()
    let registrationPresenter = RegistrationPresenter(alertsBuilder: alertsBuilder, view: view)
    
    view.registrationPresenter = registrationPresenter
    
    return view
  }
  
}
