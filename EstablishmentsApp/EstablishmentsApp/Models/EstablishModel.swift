//
//  EstablishModel.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

struct EstablishModel: Decodable {
  let image: String
  let name: String
  let id: String
  let lat: Double
  let lon: Double
  
  enum CodingKeys: String, CodingKey {
    case image
    case name
    case id
    case lat = "latitide"
    case lon = "longitude"
  }
}
