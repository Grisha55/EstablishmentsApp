//
//  Timer+extension.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 27/08/2022.
//

import Foundation

extension TimeInterval {
  func asTimeString() -> String {
    let minutes = Int(self) / 60 % 60
    let seconds = Int(self) % 60
    return String(format: "%02i:%02i", minutes, seconds)
  }
}
