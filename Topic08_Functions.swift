import Foundation

print("\n===== Task 1 =====")

func average(of marks: Int...) -> Double {
    if marks.isEmpty {
        return 0
    }
    let total = marks.reduce(0, +)
    return Double(total) / Double(marks.count)
}

func grade(for average: Double) -> String {
    switch average {
    case 90...:
        return "O"
    case 80..<90:
        return "A+"
    case 70..<80:
        return "A"
    case 60..<70:
        return "B"
    default:
        return "RA"
    }
}

func stats(of marks: [Int]) -> (min: Int, max: Int, average: Double)? {
    guard let lowest = marks.min(), let highest = marks.max() else {
        return nil
    }
    let mean = Double(marks.reduce(0, +)) / Double(marks.count)
    return (min: lowest, max: highest, average: mean)
}

func curve(_ marks: inout [Int], by bonus: Int = 5) {
    for index in marks.indices {
        marks[index] = min(marks[index] + bonus, 100)
    }
}

var marks = [82, 35, 91, 56, 67]

let avg = average(of: 82, 35, 91, 56, 67)
print("Average: \(avg)")
print("Average of nothing: \(average())")
print("Grade: \(grade(for: avg))")

if let result = stats(of: marks) {
    print("Min \(result.min), Max \(result.max), Average \(result.average)")
}
if stats(of: []) == nil {
    print("stats returned nil for an empty array")
}

curve(&marks)
print("After default curve: \(marks)")
curve(&marks, by: 10)
print("After curve by 10: \(marks)")

print("\n===== Task 2 =====")

func isPalindrome(_ text: String) -> Bool {
    let cleaned = text.lowercased().filter { $0.isLetter || $0.isNumber }
    return cleaned == String(cleaned.reversed())
}

func vowelCount(in text: String) -> Int {
    let vowels = "aeiou"
    return text.lowercased().filter { vowels.contains($0) }.count
}

func wordCount(in text: String) -> Int {
    return text.split(whereSeparator: { !$0.isLetter }).count
}

func wordCount(in text: String, minLength: Int) -> Int {
    let words = text.split(whereSeparator: { !$0.isLetter })
    return words.filter { $0.count >= minLength }.count
}

let sentence = "A man, a plan, a canal: Panama"

print("Palindrome? \(isPalindrome(sentence))")
print("Palindrome? \(isPalindrome("Swift is fun"))")
print("Vowels: \(vowelCount(in: sentence))")
print("Words: \(wordCount(in: sentence))")
print("Words with 4+ letters: \(wordCount(in: sentence, minLength: 4))")

print("\n===== Task 3 =====")

func makeMultiplier(_ factor: Int) -> (Int) -> Int {
    return { number in
        return number * factor
    }
}

let double = makeMultiplier(2)
let triple = makeMultiplier(3)

print(double(5))
print(triple(5))

func apply(_ values: [Int], using transform: (Int) -> Int) -> [Int] {
    var result: [Int] = []
    for value in values {
        result.append(transform(value))
    }
    return result
}

let numbers = [1, 2, 3, 4]

print(apply(numbers, using: double))
print(apply(numbers, using: triple))
print(apply(numbers, using: { $0 * $0 }))
