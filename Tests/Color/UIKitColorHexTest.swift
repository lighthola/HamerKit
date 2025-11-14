import Testing
@testable import HamerKit
import UIKit

@Suite("UIKit Color Hex Test")
struct UIKitColorHexTest {
    @Test("make color with RGB Hex")
    func makeColorWithRGBHex() async throws {
        let hex = "#abCD12"
        let color = UIColor.hex(hex)
        let expected = hex.uppercased()
        #expect(color.hex() == expected)
    }
    
    @Test("make color with RGBA Hex")
    func makeColorWithRGBAHex() async throws {
        let hex = "#abCD1234"
        let color = UIColor.hex(hex)
        let expected = hex.uppercased()
        #expect(color.hex(includeAlpha: true) == expected)
    }
    
    @Test("make color with RGB Hex and alpha")
    func makeColorWithRGBHexAndAlpha() async throws {
        let hex = "#abCD12"
        let color = UIColor.hex(hex, alpha: 0.5)
        let expected = hex.uppercased() + "7F"
        #expect(color.hex(includeAlpha: true) == expected)
    }
    
    @Test("make color with incorrect length Hex")
    func makeColorWithIncorrectRGBHexAndAlpha() async throws {
        let hex = "#abCD"
        let color = UIColor.hex(hex, alpha: 0.5)
        let expected = "#00000000"
        #expect(color.hex(includeAlpha: true) == expected)
    }
}
