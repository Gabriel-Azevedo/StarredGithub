import Quick
import Nimble
@testable import StarredGithub

final class IntFormatterSpec: QuickSpec {
    override func spec() {
        describe("a integer formatter") {
            context("converts an interger number to a dot-separated string") {
                it("converts successfully") {
                    let intNumber = 2000
                    let processedNumber = intNumber.formatted()
                    let expectedNumber = "2.000"
                    expect(processedNumber) == expectedNumber
                }
            }
        }
    }
}
