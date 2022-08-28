//
//  EstablishmentsViewController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 27/08/2022.
//

import UIKit

class EstablishmentsViewController: UIViewController {

  // MARK: - Properties
  private let establishmentsTableView: UITableView = {
    let table = UITableView()
    return table
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .white
      title = "Список мест"
      navigationController?.navigationBar.prefersLargeTitles = true
      setupEstablishmentsTableView()
    }
    
  // MARK: - Methods
  private func setupEstablishmentsTableView() {
    view.addSubview(establishmentsTableView)
    establishmentsTableView.dataSource = self
    
    establishmentsTableView.translatesAutoresizingMaskIntoConstraints = false
    establishmentsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    establishmentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    establishmentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    establishmentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }

}

extension EstablishmentsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
