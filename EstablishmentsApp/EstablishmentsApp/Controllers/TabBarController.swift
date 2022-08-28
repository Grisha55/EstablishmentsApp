//
//  TabBarController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
    }
    
  // MARK: - Methods
  private func setupSelf() {
    view.backgroundColor = .white
    
    let establishmentsVC = UINavigationController(rootViewController: AssemblyBuilder.shared.createEstablishmetnsVC())
    establishmentsVC.title = "Список мест"
    
    let mapVC = UINavigationController(rootViewController: AssemblyBuilder.shared.createMapVC())
    mapVC.title = "Объекты на карте"
    
    self.setViewControllers([establishmentsVC, mapVC], animated: true)
    
    guard let items = tabBar.items else { return }
    
    items[0].image = UIImage(systemName: "menucard")
    items[1].image = UIImage(systemName: "map")
  }

}
