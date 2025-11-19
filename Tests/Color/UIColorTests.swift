import Testing
@testable import HamerKit
import UIKit

@Suite("UIColor Hex Test")
struct UIColorRGBTest {
    @Test("color with RGBA")
    func testColorWithRGBA() async throws {
        #expect(UIColor.rgb(255, 0, 0) == UIColor.red)
        #expect(UIColor.rgb(0, 255, 0) == UIColor.green)
        #expect(UIColor.rgb(0, 0, 255) == UIColor.blue)
        #expect(UIColor.rgb(255, 255, 255).hex() == "#FFFFFF")
        #expect(UIColor.rgb(0, 0, 0).hex() == "#000000")
        #expect(UIColor.rgb(0, 0, 0, 0).hex(includeAlpha: true) == "#00000000")
    }
}

@Suite("UIColor Hex Test")
struct UIColorHexTest {
    @Test("color with RGB Hex")
    func testColorWithRGBHex() async throws {
        let hex = "#abCD12"
        let color = UIColor.hex(hex)
        let expected = hex.uppercased()
        #expect(color.hex() == expected)
    }
    
    @Test("color with RGBA Hex")
    func testColorWithRGBAHex() async throws {
        let hex = "#abCD1234"
        let color = UIColor.hex(hex)
        let expected = hex.uppercased()
        #expect(color.hex(includeAlpha: true) == expected)
    }
    
    @Test("color with RGB Hex and alpha")
    func testColorWithRGBHexAndAlpha() async throws {
        let hex = "#abCD12"
        let color = UIColor.hex(hex, alpha: 0.5)
        let expected = hex.uppercased() + "7F"
        #expect(color.hex(includeAlpha: true) == expected)
    }
    
    @Test("color with incorrect length Hex")
    func testColorWithIncorrectRGBHexAndAlpha() async throws {
        let hex = "#abCD"
        let color = UIColor.hex(hex, alpha: 0.5)
        let expected = "#00000000"
        #expect(color.hex(includeAlpha: true) == expected)
    }
}
