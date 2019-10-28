import UIKit
import PINTextFieldView

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupPINView()
    view.backgroundColor = .black
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    pinTextFieldView.becomeFirstResponder()
  }

  private let pinTextFieldView = PinTextFieldView()
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
}

