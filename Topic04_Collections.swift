import Foundation

print("\n===== Task 1 =====")

var subjects = ["Swift", "UIKit", "SwiftUI"]
subjects.append("Networking")
subjects.insert("Testing", at: 1)

if let index = subjects.firstIndex(of: "UIKit") {
    subjects.remove(at: index)
}
print("Sorted subjects: \(subjects.sorted())")

var registered = Set<String>()
registered.insert("Asha")
registered.insert("Ravi")
registered.insert("Asha")
print("Registered count: \(registered.count)")

var marks: [String: Int] = ["Asha": 82, "Ravi": 35, "Meena": 91]
marks["Kiran"] = 56
marks["Ravi"] = 48

if let divyaMark = marks["Divya"] {
    print("Divya scored \(divyaMark)")
} else {
    print("Divya is not in the dictionary")
}
print("Divya with a default: \(marks["Divya", default: 0])")

for (name, mark) in marks.sorted(by: { $0.key < $1.key }) {
    print("\(name): \(mark)")
}

if let topper = marks.max(by: { $0.value < $1.value }) {
    print("Highest mark: \(topper.value) by \(topper.key)")
}

print("\n===== Task 2 =====")

let sentence = "swift is fun and swift is fast"
let words = sentence.split(separator: " ").map { String($0) }

print("Number of words: \(words.count)")

let uniqueWords = Set(words)
print("Unique words: \(uniqueWords.sorted())")

var frequency: [String: Int] = [:]
for word in words {
    frequency[word, default: 0] += 1
}
for (word, count) in frequency.sorted(by: { $0.key < $1.key }) {
    print("\(word): \(count)")
}

let ranked = frequency.sorted { first, second in
    if first.value != second.value {
        return first.value > second.value
    }
    return first.key < second.key
}
print("Ranking:")
for (position, entry) in ranked.enumerated() {
    print("\(position + 1). \(entry.key) (\(entry.value))")
}

print("\n===== Task 3 =====")

let swiftClub: Set<String> = ["Anu", "Ben", "Chitra", "Dev"]
let uiClub: Set<String> = ["Chitra", "Dev", "Esha"]

print("Both clubs: \(swiftClub.intersection(uiClub).sorted())")

print("Only Swift club: \(swiftClub.subtracting(uiClub).sorted())")

print("Everyone: \(swiftClub.union(uiClub).sorted())")

print("Exactly one club: \(swiftClub.symmetricDifference(uiClub).sorted())")

let numbers = [3, 1, 3, 2, 1, 4]
var seen = Set<Int>()
var uniqueNumbers: [Int] = []

for number in numbers {
    if seen.insert(number).inserted {
        uniqueNumbers.append(number)
    }
}
print("Without duplicates: \(uniqueNumbers)")
