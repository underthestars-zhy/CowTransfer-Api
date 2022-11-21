import XCTest
@testable import CowTransfer_Api

final class CowTransfer_ApiTests: XCTestCase {
    var api = CowTransfer_Api(email: "zhuhaoyu0909@icloud.com", pwd: "Zhu200699")

    func testLogin() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let res = try await api.login()
        XCTAssertTrue(res)
    }
}
