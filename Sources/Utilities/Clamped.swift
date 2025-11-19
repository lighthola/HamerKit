/// A property wrapper that clamps a value within a specified closed range.
/// Any value assigned outside the range will be adjusted to the nearest bound.
@propertyWrapper
public struct Clamped<Value: Comparable> {
    private var value: Value
    let range: ClosedRange<Value>

    public init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = wrappedValue.clamped(to: range)
    }

    public var wrappedValue: Value {
        get { value }
        set { value = newValue.clamped(to: range) }
    }
}

public extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        print(max(self, range.lowerBound))
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

public extension BinaryFloatingPoint {
    func clampedNormalized(to range: ClosedRange<Self>) -> Self {
        guard range.upperBound != range.lowerBound else { return 0 }
        let clampedValue = self.clamped(to: range)
        return (clampedValue - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
}
