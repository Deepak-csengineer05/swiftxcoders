import Foundation

print("\n===== Task 1 =====")

struct Address {
    var city: String?
}

struct User {
    var name: String
    var age: Int?
    var address: Address?
}

func describe(_ user: User) -> String {

    guard let age = user.age else {
        return "\(user.name): age is unknown, cannot build the profile"
    }

    let city = user.address?.city ?? "unknown city"

    return "\(user.name), \(age) years old, lives in \(city)"
}

let asha = User(name: "Asha", age: 20, address: Address(city: "Coimbatore"))
let ravi = User(name: "Ravi", age: nil, address: Address(city: "Chennai"))
let meena = User(name: "Meena", age: 21, address: Address(city: nil))

print(describe(asha))
print(describe(ravi))
print(describe(meena))

print(Int("42") as Any)
print(Int("abc") as Any)

print("\n===== Task 2 =====")

let entries = ["10", "x", "25", "", "7.5", "40"]

let validNumbers = entries.compactMap { Int($0) }
print("Valid integers: \(validNumbers)")

let sum = validNumbers.reduce(0, +)
print("Sum: \(sum)")

let invalidCount = entries.count - validNumbers.count
print("Invalid entries: \(invalidCount)")

let firstDoubled = validNumbers.first.map { $0 * 2 }
if let doubled = firstDoubled {
    print("First valid number doubled: \(doubled)")
} else {
    print("There were no valid numbers")
}

print("\n===== Task 3 =====")

let scores = ["Asha": 90, "Ravi": 72]
var total = 0

if let kiranScore = scores["Kiran"] {
    total += kiranScore
} else {
    print("No score found for Kiran, counting it as 0")
}

if let number = Int("12a") {
    total += number
} else {
    print("\"12a\" is not a valid number, skipping it")
}

print("Total: \(total)")
