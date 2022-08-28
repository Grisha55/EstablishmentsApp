//
//  EstablishmentsViewController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 27/08/2022.
//

import UIKit

private enum LayoutConstant {
  static let spacing: CGFloat = 16.0
  static let itemHeight: CGFloat = 300.0
}

class EstablishmentsViewController: UIViewController {

  // MARK: - Properties
  private lazy var establishmentsCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
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
    }
    
  // MARK: - Methods
  private func setupEstablishmentsCollectionView() {
    view.addSubview(establishmentsCollectionView)
    let viewLayout = UICollectionViewFlowLayout()
    viewLayout.scrollDirection = .horizontal
    establishmentsCollectionView.collectionViewLayout = viewLayout
    
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
    return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return LayoutConstant.spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return LayoutConstant.spacing
  }
}

// MARK: - UICollectionViewDataSource
extension EstablishmentsViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EstablishmentsCollectionViewCell.self), for: indexPath)
    return cell
  }
}
