//
//  SMSCodeViewController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 27/08/2022.
//

import UIKit

class SMSCodeViewController: UIViewController {

  // MARK: - Properties
  var smsCodePresenter: SMSCodePresenterProtocol!
  
  private var timer: Timer?
  var countDown = 120
  private var phoneNumber: String?
  
  private let timerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 18)
    return label
  }()
  
  private let sendAgainButton: UIButton = {
    let button = UIButton()
    button.setTitle("Отправить код по СМС", for: .normal)
    button.setTitleColor(.purple, for: .normal)
    button.layer.cornerRadius = 2
    button.layer.borderColor = UIColor.purple.cgColor
    button.layer.borderWidth = 1
    return button
  }()
  
  private let detailsLabel: UILabel = {
    let label = UILabel()
    label.text = "СМС-код отправлен на Ваш номер"
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 25)
    label.textColor = .black
    return label
  }()
  
  private let customTextField = CustomTextField()
  
  init(phoneNumber: String) {
    super.init(nibName: nil, bundle: nil)
    self.phoneNumber = phoneNumber
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white
      print("It's viewdidload")
      setupDetailsLabel()
      setupCustomTextField()
      setupSendAgainButton()
      setupTimerLabel()
      setupTimer()
    }
    
  // MARK: - Methods
  func setupTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
    timerLabel.isHidden = false
    sendAgainButton.isHidden = true
  }
  
  @objc
  func countDownAction() {
    countDown -= 1
    let duration = TimeInterval(countDown)
    timerLabel.text = "Получить код повторно через \(duration.asTimeString())"
    if countDown == 0 {
      sendAgainButton.isHidden = false
      timerLabel.isHidden = true
      timer?.invalidate()
    }
  }
  
  private func setupTimerLabel() {
    view.addSubview(timerLabel)
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    timerLabel.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 20).isActive = true
    timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }
  
  private func setupSendAgainButton() {
    view.addSubview(sendAgainButton)
    sendAgainButton.isHidden = true
    sendAgainButton.addTarget(self, action: #selector(sendAgainButtonAction), for: .touchUpInside)
    sendAgainButton.translatesAutoresizingMaskIntoConstraints = false
    sendAgainButton.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 20).isActive = true
    sendAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    sendAgainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    sendAgainButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  @objc
  func sendAgainButtonAction() {
    smsCodePresenter.sendAgainButtonAction(phoneNumber: phoneNumber)
  }
  
  private func setupDetailsLabel() {
    view.addSubview(detailsLabel)
    detailsLabel.translatesAutoresizingMaskIntoConstraints = false
    detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
    detailsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
  }
  
  private func setupCustomTextField() {
    view.addSubview(customTextField)
    customTextField.translatesAutoresizingMaskIntoConstraints = false
    customTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    customTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
    customTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20).isActive = true
    customTextField.configure()
    customTextField.didEnterLastDigit = { [weak self] (code) in
      self?.smsCodePresenter.verifyCodeAction(code: code)
    }
  }

}
