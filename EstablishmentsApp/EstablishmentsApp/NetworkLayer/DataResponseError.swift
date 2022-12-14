//
//  DataResponseError.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

enum DataResponseError: Error {
  case network
  case decoding
  
  var reason: String {
    switch self {
    case .network:
      return "Error with fetching data"
    case .decoding:
      return "Error with decoding"
    }
  }
}
