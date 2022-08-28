//
//  MenuModel.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

struct MenuModel: Decodable {
  let image: String
  let price: Double
  let name: String
  let weight: Double
  let id: String
  let desc: String
}
