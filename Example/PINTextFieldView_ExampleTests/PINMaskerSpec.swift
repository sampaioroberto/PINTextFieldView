import Quick
import Nimble
@testable import PINTextFieldView

class PINMaskerSpec: QuickSpec {

  override func spec() {
    describe("init") {
      var masker: PINMasker!
      var text: String!

      beforeEach {
        masker = PINMasker()
      }

      it("must return empty when text is nil") {
        let response = masker.mask(text: nil)
        expect(response).to(beEmpty())
      }

      it("must return empty when text is empty") {
        text = ""
        let response = masker.mask(text: text)
        expect(response).to(beEmpty())
      }

      it("must return empty when text do not contains any numbers") {
        text = "It's a full string!"
        let response = masker.mask(text: text)
        expect(response).to(beEmpty())
      }

      it("must return 1 when text is 1") {
        text = "1"
        let response = masker.mask(text: text)
        expect(response) == "1"
      }

      it("must return 5 when text is 12345") {
        text = "12345"
        let response = masker.mask(text: text)
        expect(response) == "5"
      }
    }
  }
}
