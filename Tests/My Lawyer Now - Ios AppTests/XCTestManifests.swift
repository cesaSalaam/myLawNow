import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(My_Lawyer_Now___Ios_AppTests.allTests),
    ]
}
#endif