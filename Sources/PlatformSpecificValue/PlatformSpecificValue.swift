//
//  PlatformSpecificValue.swift
//  
//
//  Created by Dima Koskin on 13.11.2022.
//

import Foundation


public enum PlatformSpecificValue<Value>: Hashable where Value : Hashable {
    case macOS(Value)
    case iOS(Value)
    case tvOS(Value)
    case watchOS(Value)
}


/// Returns a platform specific value.
public func platformSpecific<Value>(_ platformValues: Set<PlatformSpecificValue<Value>>, `default` defaultValue: Value? = nil) -> Value {
    for platformValue in platformValues {
        #if os(macOS)
        if case .macOS(let value) = platformValue {
            return value
        }
        #endif

        #if os(iOS)
        if case .iOS(let value) = platformValue {
            return value
        }
        #endif

        #if os(watchOS)
        if case .watchOS(let value) = platformValue {
            return value
        }
        #endif

        #if os(tvOS)
        if case .tvOS(let value) = platformValue {
            return value
        }
        #endif
    }

    if let defaultValue = defaultValue {
        return defaultValue
    } else {
        fatalError("No value was provided.")
    }
}
