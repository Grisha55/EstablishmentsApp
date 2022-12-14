//
//  EstablishmentsViewController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 27/08/2022.
//

import UIKit

private enum LayoutConstant {
  static let spacing: CGFloat = 16.0
  static let itemHeight: CGFloat = 250.0
}

class EstablishmentsViewController: UIViewController {

  // MARK: - Properties
  var establishmentsPresenter: EstablishmentsPresenter!
  
  lazy var establishmentsCollectionView: UICollectionView = {
    let viewLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
    collectionView.backgroundColor = .white
    collectionView.indicatorStyle = .white
    return collectionView
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .white
      title = "Список мест"
      navigationController?.navigationBar.prefersLargeTitles = true
      
      setupEstablishmentsCollectionView()
      establishmentsPresenter.getEstablishments()
    }
    
  // MARK: - Methods
  private func setupEstablishmentsCollectionView() {
    view.addSubview(establishmentsCollectionView)
    
    establishmentsCollectionView.register(EstablishmentsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EstablishmentsCollectionViewCell.self))
    establishmentsCollectionView.dataSource = self
    establishmentsCollectionView.delegate = self
    
    establishmentsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    establishmentsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    establishmentsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    establishmentsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    establishmentsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }

}

extension EstablishmentsViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
    return CGSize(width: width, height: LayoutConstant.itemHeight)
  }
  
  func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
    let itemsInRow: CGFloat = 2
    
    let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
    let finalWidth = (width - totalSpacing) / itemsInRow
    
    return floor(finalWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5, left: LayoutConstant.spacing, bottom: 0, right: LayoutConstant.spacing)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return LayoutConstant.spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
}

// MARK: - UICollectionViewDataSource
extension EstablishmentsViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return establishmentsPresenter.establishments.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EstablishmentsCollectionViewCell.self), for: indexPath) as? EstablishmentsCollectionViewCell else { return UICollectionViewCell() }
    let establishment = establishmentsPresenter.establishments[indexPath.row]
    cell.establishModel = establishment
    return cell
  }
}
