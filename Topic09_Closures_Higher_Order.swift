import Foundation

print("\n===== Task 1 =====")

struct Student {
    let name: String
    let marks: Int
    let dept: String
}

extension Student {
    var hasPassed: Bool { marks >= 40 }
}

let students = [
    Student(name: "Asha", marks: 82, dept: "IT"),
    Student(name: "Ravi", marks: 35, dept: "CSE"),
    Student(name: "Meena", marks: 91, dept: "IT"),
    Student(name: "Kiran", marks: 56, dept: "ECE"),
    Student(name: "Divya", marks: 67, dept: "CSE"),
    Student(name: "Arjun", marks: 40, dept: "IT")
]

let passed = students.filter { $0.marks >= 40 }
print("Passed: \(passed.count) students")

let passedNames = passed.map { $0.name }
print("Names: \(passedNames)")

let allMarks = students.map { $0.marks }
let average = Double(allMarks.reduce(0, +)) / Double(allMarks.count)
print("Class average: \(average)")

let ranking = students.sorted { $0.marks > $1.marks }
for (position, student) in ranking.enumerated() {
    print("\(position + 1). \(student.name) - \(student.marks)")
}

let byDepartment = Dictionary(grouping: students, by: { $0.dept })
for dept in byDepartment.keys.sorted() {
    let names = byDepartment[dept, default: []].map { $0.name }
    print("\(dept): \(names)")
}

let fullForm = students.filter({ (student: Student) -> Bool in
    return student.marks >= 40
})

let shorthand = students.filter { $0.marks >= 40 }

let keyPath = students.filter(\.hasPassed)

print(fullForm.count, shorthand.count, keyPath.count)

print("\n===== Task 2 =====")

func myFilter(_ items: [Int], _ predicate: (Int) -> Bool) -> [Int] {
    var result: [Int] = []
    for item in items {
        if predicate(item) {
            result.append(item)
        }
    }
    return result
}

func applyTwice(_ value: Int, _ f: (Int) -> Int) -> Int {
    return f(f(value))
}

class Button {
    private var handlers: [() -> Void] = []

    func onTap(_ handler: @escaping () -> Void) {
        handlers.append(handler)
    }

    func tap() {
        for handler in handlers {
            handler()
        }
    }
}

print(myFilter([1, 2, 3, 4, 5, 6, 7, 8], { $0 % 2 == 0 }))
print(applyTwice(3, { $0 * 2 }))

let button = Button()
button.onTap { print("First handler ran") }
button.onTap { print("Second handler ran") }
button.tap()

print("\n===== Task 3 =====")

func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let a = makeCounter()
let b = makeCounter()
print(a(), a(), b(), a())
