import XCTest
@testable import PlatformSpecificValue


final class PlatformSpecificValueTests: XCTestCase {
    func testThatPlatformSpecificFunctionReturnsTheRightValue() throws {
        let value: String = platformSpecific([.macOS("macOS"), .iOS("iOS"), .watchOS("watchOS"), .tvOS("tvOS")])
        
        #if os(macOS)
        XCTAssertEqual(value, "macOS")
        #elseif os(iOS)
        XCTAssertEqual(value, "iOS")
        #elseif os(watchOS)
        XCTAssertEqual(value, "watchOS")
        #elseif os(tvOS)
        XCTAssertEqual(value, "tvOS")
        #else
        #error("Testing on an unsupported platform")
        #endif
    }
}
