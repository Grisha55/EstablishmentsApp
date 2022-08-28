//
//  Result.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

enum Result<T, U: Error> {
  case success(T)
  case failure(U)
}
