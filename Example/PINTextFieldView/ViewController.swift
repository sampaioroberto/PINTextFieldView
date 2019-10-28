import UIKit
import PINTextFieldView

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupPINView()
    setupButton()
    setupGestureRecognizer()
    view.backgroundColor = .black
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    pinTextFieldView.becomeFirstResponder()
  }

  private let pinTextFieldView = PinTextFieldView()

  private let validateButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(validatePIN), for: .touchUpInside)
    button.setTitle("Validate", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.layer.cornerRadius = 14
    return button
  }()
}

private extension ViewController {
  func setupPINView() {
    view.addSubview(pinTextFieldView)
    pinTextFieldView.translatesAutoresizingMaskIntoConstraints = false
    pinTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    pinTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    pinTextFieldView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    pinTextFieldView.widthAnchor.constraint(equalToConstant: 300).isActive = true
  }

  func setupButton() {
    view.addSubview(validateButton)
    validateButton.translatesAutoresizingMaskIntoConstraints = false
    validateButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    validateButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
    validateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    validateButton.topAnchor.constraint(equalTo: pinTextFieldView.bottomAnchor, constant: 40).isActive = true
  }

  func setupGestureRecognizer() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    view.addGestureRecognizer(gesture)
  }

  @objc func validatePIN() {
    guard let pincodes = pinTextFieldView.allPINCodes() else {
      validateButton.backgroundColor = .red
      validateButton.setTitle("Not valid", for: .normal)
      return
    }
    validateButton.backgroundColor = .green
    validateButton.setTitle("Is valid: \(pincodes)", for: .normal)
  }

  @objc func hideKeyboard() {
    view.endEditing(true)
  }
}

