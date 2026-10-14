import Foundation

print("\n===== Task 1 =====")

struct Stack<Element> {
    private var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        return items.popLast()
    }

    var top: Element? {
        return items.last
    }

    var isEmpty: Bool {
        return items.isEmpty
    }

    var count: Int {
        return items.count
    }
}

var numberStack = Stack<Int>()
numberStack.push(10)
numberStack.push(20)
numberStack.push(30)
print("Top: \(numberStack.top as Any), count: \(numberStack.count)")
print("Popped: \(numberStack.pop() as Any)")
print("Empty? \(numberStack.isEmpty)")

var wordStack = Stack<String>()
wordStack.push("Swift")
wordStack.push("Generics")
print("Top: \(wordStack.top as Any)")
_ = wordStack.pop()
_ = wordStack.pop()
print("Pop from empty: \(wordStack.pop() as Any)")

func largest<T: Comparable>(in items: [T]) -> T? {
    guard var biggest = items.first else {
        return nil
    }
    for item in items.dropFirst() {
        if item > biggest {
            biggest = item
        }
    }
    return biggest
}

print(largest(in: [4, 19, 7]) as Any)
print(largest(in: ["pear", "apple", "zebra"]) as Any)
print(largest(in: [Int]()) as Any)

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var first = "left"
var second = "right"
swapValues(&first, &second)
print(first, second)

struct Point {
    var x: Int
    var y: Int
}

print("\n===== Task 2 =====")

enum ATMError: Error {
    case insufficientFunds(shortBy: Double)
    case invalidAmount
    case dailyLimitExceeded
}

struct Account {
    private(set) var balance: Double
    static let dailyLimit = 20_000.0

    mutating func withdraw(_ amount: Double) throws {
        guard amount > 0 else {
            throw ATMError.invalidAmount
        }
        guard amount <= Account.dailyLimit else {
            throw ATMError.dailyLimitExceeded
        }
        guard amount <= balance else {
            throw ATMError.insufficientFunds(shortBy: amount - balance)
        }
        balance -= amount
    }
}

func attempt(_ amount: Double, on account: inout Account) {
    do {
        try account.withdraw(amount)
        print("Withdrew \(amount). Balance is now \(account.balance)")
    } catch ATMError.invalidAmount {
        print("\(amount): invalid amount, it must be more than 0")
    } catch ATMError.dailyLimitExceeded {
        print("\(amount): over the daily limit of \(Account.dailyLimit)")
    } catch ATMError.insufficientFunds(let shortBy) {
        print("\(amount): not enough money, short by \(shortBy)")
    } catch {
        print("Something unexpected happened: \(error)")
    }
}

var account = Account(balance: 10_000)

attempt(500, on: &account)
attempt(-10, on: &account)
attempt(25_000, on: &account)
attempt(12_000, on: &account)

let worked = (try? account.withdraw(100)) != nil
print("Withdrawing 100 worked: \(worked)")

let failed = (try? account.withdraw(-5)) == nil
print("Withdrawing -5 failed: \(failed)")

print("\n===== Task 3 =====")

enum ParseError: Error {
    case empty
    case notANumber
    case outOfRange
}

func parseAge(_ text: String) throws -> Int {
    if text.isEmpty {
        throw ParseError.empty
    }
    guard let age = Int(text) else {
        throw ParseError.notANumber
    }
    guard (1...120).contains(age) else {
        throw ParseError.outOfRange
    }
    return age
}

for input in ["25", "", "abc", "150"] {
    let result = Result { try parseAge(input) }

    switch result {
    case .success(let age):
        print("\"\(input)\" -> valid age \(age)")
    case .failure(let error):
        print("\"\(input)\" -> failed with \(error)")
    }
}

enum ReportError: Error {
    case writeFailed
}

func saveReport(shouldFail: Bool = false) throws {
    print("Opening file")
    defer {
        print("Closing file")
    }

    if shouldFail {
        throw ReportError.writeFailed
    }
    print("Writing report")
}

print("--- normal run ---")
try saveReport()

print("--- failing run ---")
do {
    try saveReport(shouldFail: true)
} catch {
    print("Caught: \(error)")
}
