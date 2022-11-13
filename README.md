# PlatformSpecificValue

This library might come in handy when you have a lot of compile-time platform check in your code.

```swift
import SwiftUI
import PlatformSpecificValue

struct ContentView: View {        
    private let shapeRadius: Int = platformSpecific([.macOS(15), .iOS(20)])
    
    var body: some View {
        RoundedRectangle(cornerRadius: shapeRadius)
    }
}
```
