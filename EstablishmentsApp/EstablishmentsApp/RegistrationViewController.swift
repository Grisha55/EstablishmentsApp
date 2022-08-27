//
//  RegistrationViewController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 26/08/2022.
//

import UIKit

class RegistrationViewController: UIViewController {

  // MARK: - Properties
  private let phoneTextField: UITextField = {
    let tf = UITextField()
    tf.text = "+7"
    tf.layer.cornerRadius = 7
    tf.font = UIFont.systemFont(ofSize: 20)
    tf.backgroundColor = .white
    return tf
  }()
  
  private let takeCodeButton: UIButton = {
    let button = UIButton()
    button.setTitle("Получить код", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemPurple
    button.layer.cornerRadius = 7
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return button
  }()
  
  private let helpLabel: UILabel = {
    let label = UILabel()
    label.text = "Номер телефона должен начинаться с (+7) и содержать 11 символов"
    label.numberOfLines = 0
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .purple
    navigationController?.navigationBar.prefersLargeTitles = true
    
    setupPhoneTextField()
    setupHelpLabel()
    setupTakeCodeButton()
  }

  // MARK: - Methods
  private func setupHelpLabel() {
    view.addSubview(helpLabel)
    helpLabel.translatesAutoresizingMaskIntoConstraints = false
    helpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
    helpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    helpLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10).isActive = true
  }
  
  private func setupTakeCodeButton() {
    view.addSubview(takeCodeButton)
    takeCodeButton.addTarget(self, action: #selector(takeCodeButtonAction), for: .touchUpInside)
    takeCodeButton.translatesAutoresizingMaskIntoConstraints = false
    takeCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    takeCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    takeCodeButton.topAnchor.constraint(equalTo: helpLabel.bottomAnchor, constant: 50).isActive = true
    takeCodeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  @objc
  func takeCodeButtonAction() {
    if let text = phoneTextField.text, !text.isEmpty {
      if text.contains("+7") {
        AuthManager.shared.startAuth(phoneNumber: text) { [weak self] (success) in
          guard success else {
            // TODO: Alert
            return
          }
          
          DispatchQueue.main.async {
            let vc = SMSCodeViewController()
            vc.title = "Введите полученный код"
            self?.navigationController?.pushViewController(vc, animated: true)
          }
        }
      } else {
        // TODO: Alert
      }
    } else {
      // TODO: Сделать Алерты
    }
  }
  
  private func setupPhoneTextField() {
    view.addSubview(phoneTextField)
    phoneTextField.delegate = self
    addLeftImageTo(textField: phoneTextField, image: UIImage(systemName: "phone")!)
    phoneTextField.translatesAutoresizingMaskIntoConstraints = false
    phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    phoneTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    phoneTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
  }
  
  private func addLeftImageTo(textField: UITextField, image: UIImage) {
    let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
    leftImageView.image = image
    leftImageView.tintColor = .gray
    textField.leftView = leftImageView
    textField.leftViewMode = .always
  }
  
}

// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.becomeFirstResponder()
    
    if let text = textField.text, !text.isEmpty {
      if text.contains("+7") {
        AuthManager.shared.startAuth(phoneNumber: text) { [weak self] (success) in
          guard success else {
            // TODO: Alert
            return
          }
          
          DispatchQueue.main.async {
            let vc = SMSCodeViewController()
            vc.title = "Введите полученный код"
            self?.navigationController?.pushViewController(vc, animated: true)
          }
        }
      } else {
        // TODO: Alert
      }
    } else {
      // TODO: Сделать Алерты
    }
    
    return true
  }
  
}
