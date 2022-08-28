//
//  MenuRequest.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

struct MenuRequest {
  var path: String {
    return "getMenu"
  }
  
  let parameters: Parameters
  private init(parameters: Parameters) {
    self.parameters = parameters
  }
}

extension MenuRequest {
  static func from() -> MenuRequest {
    let parameters: [String : String] = [:]
    return MenuRequest(parameters: parameters)
  }
}
