//
//  SMSCodeViewController.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 27/08/2022.
//

import UIKit

class SMSCodeViewController: UIViewController {

  private let customTextField = CustomTextField()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  
  private func setupCustomTextField() {
    view.addSubview(customTextField)
    customTextField.configure()
    customTextField.didEnterLastDigit = { [weak self] code in
      print(code)
      // TODO: Checking in Firebase
    }
  }

}
