import UIKit.UIView

public protocol PINTextFieldViewProtocol: AnyObject {
  func didFinish(values: [Int])
}

open class PinTextFieldView: UIView {

  //MARK: Private vars

  private var textFields = [UITextField]()
  private let masker = PINMasker()
  private let quantity: Int

  override public func draw(_ rect: CGRect) {
    super.draw(rect)
    let width = rect.width
    configure(width: width, quantity: quantity)
  }

  public init(quantity: Int = 4) {
    self.quantity = quantity
    super.init(frame: .zero)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: Open vars

  open weak var delegate: PINTextFieldViewProtocol?

  //The height of each of the PINs
  open var widthPIN: CGFloat = 56.0

  //The height of each of the PINs
  open var heightPIN: CGFloat = 64.0

  //The corner radius of each of the PINs
  open var spacement: CGFloat = 16.0

  open var font: UIFont = UIFont.systemFont(ofSize: 40)

  //The corner radius of each of the PINs
  open var cornerRadiusPIN: CGFloat = 24.0

  //The border width of each of  the PINs
  open var borderWidthPIN: CGFloat = 2.0

  //The border color of the PINs
  open var borderColorPIN: UIColor = UIColor.white

  //The background color of a PIN when it's empty and not selected
  open var backgroundColorEmptyPIN: UIColor = UIColor.blue

  //The background color of a PIN when it's filled and not selected
  open var backgroundColorFilledPIN: UIColor = UIColor.orange

  //The background color of a PIN when it's selected
  open var backgroundColorSelectedPIN: UIColor = UIColor.white

  //The text color of the text of a PIN when it's selected
  open var textColorSelectedPIN: UIColor = UIColor.blue

  //The text color of the text of a PIN when it's unselected
  var textColorUnselectedPIN: UIColor = UIColor.white

  //MARK: Public methods

  //The method becomeFirstResponder will call becomeFirstResponder to the first PIN textField
  @discardableResult override public func becomeFirstResponder() -> Bool {
    return textFields.first?.becomeFirstResponder() ?? false
  }

  public func allPINCodes() -> [Int] {
    return allValues()
  }
}

private extension PinTextFieldView {
  func configure(width: CGFloat, quantity: Int) {
    let totalPINSpace: CGFloat = widthPIN + spacement

    let maxWidth = CGFloat(totalPINSpace*CGFloat(quantity))
    let initialX = (width - maxWidth)/2 + spacement/2
    for index in 0..<quantity {
      let textField = createCustomTextField()
      addSubview(textField)
      let constant = CGFloat(totalPINSpace * CGFloat(index)) + initialX
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
      textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      textField.heightAnchor.constraint(equalToConstant: heightPIN).isActive = true
      textField.widthAnchor.constraint(equalToConstant: widthPIN).isActive = true
      textField.addTarget(self, action: #selector(didChange(sender:)), for: .editingChanged)
      textField.addTarget(self, action: #selector(didEditingBegin(sender:)), for: .editingDidBegin)
      textField.addTarget(self, action: #selector(didEditingEnd(sender:)), for: .editingDidEnd)
      textFields.append(textField)
  }
}

  @objc func didChange(sender: UITextField) {
    let text = masker.mask(text: sender.text)
    sender.text = text

    if text.isEmpty {
      return
    }

    guard let index = textFields.firstIndex(of: sender) else { return }

    let currentIndex = index+1

    if (currentIndex == textFields.count) && areAllFieldsFilled() {
      sender.resignFirstResponder()
      delegate?.didFinish(values: allValues())
    }

    if currentIndex < textFields.count {
      let currentTextField = textFields[currentIndex]
      currentTextField.becomeFirstResponder()
    }
  }

  func allValues() -> [Int] {
    return textFields.map { textField -> Int in
      guard let text = textField.text, let value = Int(text) else { return 0 }
      return value
    }
  }

  @objc func didEditingBegin(sender: UITextField) {
    sender.backgroundColor = backgroundColorSelectedPIN
    sender.textColor = textColorSelectedPIN
  }

  @objc func didEditingEnd(sender: UITextField) {
    sender.textColor = textColorUnselectedPIN
    guard let text = sender.text else {
      sender.backgroundColor = backgroundColorEmptyPIN
      return
    }
    sender.backgroundColor = text.isEmpty ? backgroundColorEmptyPIN : backgroundColorFilledPIN
  }

  func areAllFieldsFilled() -> Bool {
    var areAllFilled = true
    textFields.forEach { textField in
      guard let text = textField.text else { areAllFilled = false; return }
      areAllFilled = areAllFilled && !text.isEmpty
    }
    return areAllFilled
  }

  func createCustomTextField() -> PINTextField {
    let textField = PINTextField(frame: .zero)
    textField.font = font
    textField.layer.cornerRadius = cornerRadiusPIN
    textField.layer.borderWidth = borderWidthPIN
    textField.pinTextFieldDelegate = self
    textField.layer.borderColor = UIColor.white.cgColor
    textField.backgroundColor = backgroundColorEmptyPIN
    return textField
  }
}

extension PinTextFieldView: PINTextFieldDelegateProtocol {
  func didDeleteBackward(sender: UITextField) {
    guard let index = textFields.firstIndex(of: sender) else { return }
    let currentIndex = index-1
    if currentIndex >= 0 {
      let currentTextField = textFields[currentIndex]
      currentTextField.becomeFirstResponder()
    }
  }
}
