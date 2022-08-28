//
//  EstablishmentsRequest.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

struct EstablishmentsRequest {
  var path: String {
    return "getPlaces"
  }
  
  let parameters: Parameters
  private init(parameters: Parameters) {
    self.parameters = parameters
  }
}

extension EstablishmentsRequest {
  static func from() -> EstablishmentsRequest {
    let parameters: [String : String] = [:]
    return EstablishmentsRequest(parameters: parameters)
  }
}
