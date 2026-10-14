import Foundation

print("\n===== Task 1 =====")

protocol Payable {
    var name: String { get }
    func monthlyPay() -> Double
}

extension Payable {
    func payslip() -> String {
        let amount = String(format: "%.2f", monthlyPay())
        return "Payslip - \(name): Rs. \(amount)"
    }
}

struct FullTimeEmployee: Payable {
    let name: String
    let salary: Double

    func monthlyPay() -> Double {
        return salary / 12
    }
}

struct Intern: Payable {
    let name: String
    let stipend: Double

    func monthlyPay() -> Double {
        return stipend
    }
}

var staff: [any Payable] = [
    FullTimeEmployee(name: "Asha", salary: 600_000),
    Intern(name: "Ravi", stipend: 15_000)
]

struct Contractor: Payable {
    let name: String
    let hourlyRate: Double
    let hours: Double

    func monthlyPay() -> Double {
        return hourlyRate * hours
    }
}
staff.append(Contractor(name: "Meena", hourlyRate: 800, hours: 40))

for person in staff {
    print(person.payslip())
}

print("\n===== Task 2 =====")

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }

    func squared() -> Int {
        return self * self
    }
}

extension Array where Element == Int {
    var sum: Int {
        return reduce(0, +)
    }
}

extension String {
    var wordCount: Int {
        return split(whereSeparator: { $0.isWhitespace }).count
    }
}

struct Version {
    let major: Int
    let minor: Int
}

extension Version: Comparable {
    static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major != rhs.major {
            return lhs.major < rhs.major
        }
        return lhs.minor < rhs.minor
    }
}

print(10.isEven, 7.isEven)
print(6.squared())
print([1, 2, 3, 4].sum)
print("Swift is really fun".wordCount)

let old = Version(major: 1, minor: 9)
let new = Version(major: 2, minor: 0)
print(old < new)

let versions = [Version(major: 2, minor: 0), Version(major: 1, minor: 9), Version(major: 1, minor: 2)]
for version in versions.sorted() {
    print("\(version.major).\(version.minor)")
}

print("\n===== Task 3 =====")

protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

struct Duck: Flyable, Swimmable {
    func fly() { print("The duck flaps its wings and flies") }
    func swim() { print("The duck paddles across the pond") }
}

struct Eagle: Flyable {
    func fly() { print("The eagle soars high") }
}

struct Fish: Swimmable {
    func swim() { print("The fish swims in the river") }
}

func showOff(_ animal: Flyable & Swimmable) {
    animal.fly()
    animal.swim()
}

showOff(Duck())
