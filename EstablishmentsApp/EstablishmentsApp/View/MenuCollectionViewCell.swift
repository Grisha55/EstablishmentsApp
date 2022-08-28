//
//  MenuCollectionViewCell.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import UIKit

protocol MenuCollectionViewCellDelegate: AnyObject {
  func closeButtonAction()
}

class MenuCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  weak var delegate: MenuCollectionViewCellDelegate?
  
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .yellow
    imageView.layer.cornerRadius = 30
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  private let closeButton: UIButton = {
    let button = UIButton()
    button.setTitle("Закрыть", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoImageView()
    setupNameLabel()
    setupCloseButton()
  }
  
  var menuModel: MenuModel? {
    didSet {
      guard let url = URL(string: menuModel?.image ?? "") else { return }
      photoImageView.load(url: url)
      nameLabel.text = "\(menuModel?.name ?? ""), \(menuModel?.price ?? 0.0) руб"
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  private func setupCloseButton() {
    addSubview(closeButton)
    closeButton.addTarget(delegate, action: #selector(closeButtonAction), for: .touchUpInside)
    
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    closeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  }
  
  @objc
  func closeButtonAction() {
    delegate?.closeButtonAction()
  }
  
  private func setupNameLabel() {
    addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20).isActive = true
    nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
  }
  
  private func setupPhotoImageView() {
    addSubview(photoImageView)
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    photoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    photoImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
  }
  
}
