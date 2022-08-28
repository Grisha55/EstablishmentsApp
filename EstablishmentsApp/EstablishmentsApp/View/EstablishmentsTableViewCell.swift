//
//  EstablishmentsCollectionViewCell.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import UIKit

class EstablishmentsCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .yellow
    imageView.layer.cornerRadius = 30
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20)
    label.text = "lkfjlkdsfjsdlkjfl;kdsjfkld"
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoImageView()
    setupNameLabel()
  }
  
  var establishModel: EstablishModel? {
    didSet {
      guard let url = URL(string: establishModel?.image ?? "") else { return }
      photoImageView.load(url: url)
      nameLabel.text = establishModel?.name
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
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
