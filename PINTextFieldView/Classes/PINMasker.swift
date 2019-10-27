import Foundation.NSRegularExpression

struct PINMasker {
  func mask(text: String?) -> String {

    guard let text = text else { return "" }

    var textResult = text

    guard let regex = try? NSRegularExpression(pattern: "[\\D]", options: NSRegularExpression.Options(rawValue: 0)) else { return "" }
    let range = NSRange(location: 0, length: text.count)
    textResult = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")

    if textResult.count > 1 {
      guard let lastChar = textResult.last else { return "" }
      textResult = String(lastChar)
    }

    return textResult
  }
}
