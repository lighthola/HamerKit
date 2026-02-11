import Testing
import OrderedCollections

// MARK: - Test Models

struct TestItem {
    let id: Int
    let category: TestCategory
}

enum TestCategory: Int, Hashable, Comparable {
    case alpha = 1
    case beta = 2
    case gamma = 3
    case delta = 4
    case epsilon = 5
    
    static func < (lhs: TestCategory, rhs: TestCategory) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Core Functionality Tests

@Suite("Array Grouping Extension")
struct ArrayGroupingExtensionTests {
    
    let items: [TestItem] = [
        TestItem(id: 1, category: .alpha),
        TestItem(id: 2, category: .beta),
        TestItem(id: 3, category: .alpha),
        TestItem(id: 4, category: .gamma),
        TestItem(id: 5, category: .delta),
        TestItem(id: 6, category: .alpha),
        TestItem(id: 7, category: .beta)
    ]
    
    // MARK: - grouped(by:ensuring:)
    
    @Test("基本分組功能")
    func groupingBasics() {
        let result = items.grouped(by: \.category)
        
        #expect(result[.alpha]?.count == 3)
        #expect(result[.beta]?.count == 2)
        #expect(result[.gamma]?.count == 1)
        #expect(result[.delta]?.count == 1)
        #expect(!result.keys.contains(.epsilon))
    }
    
    @Test("確保 default categories 存在")
    func ensuringDefaultCategories() {
        let result = items.grouped(
            by: \.category,
            ensuring: [.alpha, .epsilon]
        )
        
        #expect(result[.alpha]?.count == 3)
        #expect(result[.epsilon]?.isEmpty == true)
        #expect(result.count == 5) // alpha, beta, gamma, delta, epsilon
    }
    
    @Test("空陣列處理")
    func emptyArrayHandling() {
        let empty: [TestItem] = []
        
        let result1 = empty.grouped(by: \.category)
        #expect(result1.isEmpty)
        
        let result2 = empty.grouped(by: \.category, ensuring: [.alpha, .beta])
        #expect(result2.count == 2)
        #expect(result2[.alpha]?.isEmpty == true)
    }
    
    @Test("元素完整性")
    func preservesAllElements() {
        let result = items.grouped(by: \.category)
        let totalCount = result.values.flatMap { $0 }.count
        
        #expect(totalCount == items.count)
    }
    
    // MARK: - groupedAndSorted(by:ensuring:)
    
    @Test("排序功能")
    func sortingBasics() {
        let result = items.groupedAndSorted(by: \.category)
        let keys = Array(result.keys)
        
        #expect(keys == [.alpha, .beta, .gamma, .delta])
        #expect(result[.alpha]?.count == 3)
    }
    
    @Test("自訂排序")
    func customSorting() {
        let result = items.groupedAndSorted(
            by: \.category,
            sortBy: { $0.rawValue > $1.rawValue }
        )
        let keys = Array(result.keys)
        
        #expect(keys.first == .delta)
        #expect(keys.last == .alpha)
    }
    
    @Test("排序時確保 default categories")
    func sortingWithDefaults() {
        let result = items.groupedAndSorted(
            by: \.category,
            ensuring: [.epsilon]
        )
        
        #expect(result.keys.contains(.epsilon))
        #expect(result[.epsilon]?.isEmpty == true)
        #expect(Array(result.keys).last == .epsilon)
    }
}

// MARK: - Performance Tests

@Suite("Performance")
struct PerformanceTests {
    
    @Test("大量資料分組", .timeLimit(.minutes(1)))
    func largeDataGrouping() {
        let items = (0..<100_000).map {
            TestItem(id: $0, category: TestCategory(rawValue: ($0 % 5) + 1)!)
        }
        
        let start = ContinuousClock.now
        let result = items.grouped(by: \.category)
        let duration = ContinuousClock.now - start
        
        #expect(result.count == 5)
        #expect(duration < .seconds(1))
    }
    
    @Test("大量資料排序", .timeLimit(.minutes(1)))
    func largeDataSorting() {
        let items = (0..<100_000).map {
            TestItem(id: $0, category: TestCategory(rawValue: ($0 % 5) + 1)!)
        }
        
        let start = ContinuousClock.now
        let result = items.groupedAndSorted(by: \.category)
        let duration = ContinuousClock.now - start
        
        #expect(result.count == 5)
        #expect(duration < .seconds(2))
    }
}
