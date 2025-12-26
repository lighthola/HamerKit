import Testing
@testable import HamerKit
import Foundation

@Suite("Utility: Clamped Test")
struct ClampedTest {
    @Test("clamped")
    func testClamped() {
        @Clamped(0...255) var r: Int = 300
        @Clamped(0...255) var g: Int = -10
        @Clamped(0...255) var b: Int = 128
        @Clamped(0...1) var a: CGFloat = 1.5
        
        #expect(r == 255)
        #expect(g == 0)
        #expect(b == 128)
        #expect(a == 1)
    }
    
    @Test("normalized clamped")
    func testNormalizedClamped() {
        let a: Double = 10.0.clampedNormalized(to: 0...20)
        let b: CGFloat = CGFloat(-10).clampedNormalized(to: 0...20)
        let c: Float = Float(10).clampedNormalized(to: 0...5)
        let d: NSNumber = 0.clampedNormalized(to: 0...1) as NSNumber
        
        #expect(a == 0.5)
        #expect(b == 0)
        #expect(c == 1)
        #expect(d == 0)
    }
}
