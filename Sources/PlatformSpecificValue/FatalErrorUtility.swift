//
//  FatalErrorUtility.swift
//  
//
//  Created by Dima Koskin on 13.11.2022.
//

import Foundation
import XCTest


// MARK: Mock fatalError()
// Source: https://stackoverflow.com/questions/32873212/unit-test-fatalerror-in-swift


internal extension XCTestCase {
    func XCTestFatalError(_ message: String, testCase: @escaping () -> Void) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil

        FatalErrorUtility.replaceFatalError { message, _, _ in
            DispatchQueue.main.async {
                assertionMessage = message
                expectation.fulfill()
            }
            Thread.exit()
            fatalError("It will never be executed")
        }

        Thread(block: testCase).start()
        
        waitForExpectations(timeout: 0.1) { _ in
            XCTAssertEqual(assertionMessage, message)
            FatalErrorUtility.restoreFatalError()
        }
    }
}


internal func fatalError(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtility.fatalErrorClosure(message(), file, line)
}


internal enum FatalErrorUtility {
    typealias FatalErrorClosureType = (String, StaticString, UInt) -> Never
    
    static var fatalErrorClosure: FatalErrorClosureType = defaultFatalErrorClosure
    
    private static let defaultFatalErrorClosure: FatalErrorClosureType = {
        Swift.fatalError($0, file: $1, line: $2)
    }
    
    static func replaceFatalError(closure: @escaping FatalErrorClosureType) {
        fatalErrorClosure = closure
    }
    
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
