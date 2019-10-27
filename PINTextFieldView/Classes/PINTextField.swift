import UIKit.UITextField

protocol PINTextFieldDelegateProtocol: NSObject {
  func didDeleteBackward(sender: UITextField)
}

final class PINTextField: UITextField {

  weak var pinTextFieldDelegate: PINTextFieldDelegateProtocol?

  override init(frame: CGRect) {
    super.init(frame: frame)
    textAlignment = .center
    keyboardType = .decimalPad
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func deleteBackward() {
    super.deleteBackward()

    pinTextFieldDelegate?.didDeleteBackward(sender: self)
  }

  override func caretRect(for position: UITextPosition) -> CGRect {
    return .zero
  }
}
