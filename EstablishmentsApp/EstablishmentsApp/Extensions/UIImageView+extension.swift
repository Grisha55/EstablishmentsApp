//
//  UIImageView+extension.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import UIKit

var imageCache = [URL : UIImage]()

extension UIImageView {
  func load(url: URL) {
    
    if let image = imageCache[url] {
      self.image = image
    } else {
      if let data = try? Data(contentsOf: url) {
        let image = UIImage(data: data)
        imageCache[url] = image
        DispatchQueue.main.async { [weak self] in
          self?.image = image
        }
      }
    }
  }
}
