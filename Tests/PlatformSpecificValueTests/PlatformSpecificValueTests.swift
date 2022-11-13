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
    
    func testThatPlatformSpecificFunctionThrowsFatalErrorIfThereIsNoAppropriateValue() throws {
        let values: Set<PlatformSpecificValue<String>> = [.macOS("macOS"), .iOS("iOS"), .watchOS("watchOS"), .tvOS("tvOS")]
        
        XCTestFatalError("No value was provided.") {
            #if os(macOS)
            let filteredValues = values.filter { $0 != .macOS("macOS") }
            #elseif os(iOS)
            let filteredValues = values.filter { $0 != .iOS("iOS") }
            #elseif os(watchOS)
            let filteredValues = values.filter { $0 != .watchOS("watchOS") }
            #elseif os(tvOS)
            let filteredValues = values.filter { $0 != .tvOS("tvOS") }
            #else
            #error("Testing on an unsupported platform")
            #endif
            _ = platformSpecific(filteredValues)
        }
    }
}

