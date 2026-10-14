import Foundation

print("\n===== Task 1 =====")

enum BookStatus {
    case available
    case borrowed(by: String, dueIn: Int)
    case reserved(for: String)

    var label: String {
        switch self {
        case .available:
            return "Available"
        case .borrowed(let by, let dueIn):
            return "Borrowed by \(by), due in \(dueIn) days"
        case .reserved(let person):
            return "Reserved for \(person)"
        }
    }
}

struct Book {
    var title: String
    var status: BookStatus = .available
}

class Member {
    var name: String
    var borrowedBooks: [Book] = []

    init(name: String) {
        self.name = name
    }
}

let original = Book(title: "Swift Programming")
var copy = original
copy.status = .borrowed(by: "Asha", dueIn: 7)

print("Original: \(original.title) - \(original.status.label)")
print("Copy:     \(copy.title) - \(copy.status.label)")

let member = Member(name: "Asha")
let sameMember = member
sameMember.name = "Ravi"

print("member.name = \(member.name)")
print("sameMember.name = \(sameMember.name)")

print("\n===== Task 2 =====")

enum Shape {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)
    case triangle(base: Double, height: Double)

    var area: Double {
        switch self {
        case .circle(let radius):
            return Double.pi * radius * radius
        case .rectangle(let width, let height):
            return width * height
        case .triangle(let base, let height):
            return 0.5 * base * height
        }
    }
}

let shapes: [Shape] = [
    .circle(radius: 3),
    .rectangle(width: 4, height: 5),
    .triangle(base: 6, height: 2)
]
for shape in shapes {
    print("\(shape) has area \(String(format: "%.2f", shape.area))")
}

struct Rectangle {
    var width: Double
    var height: Double

    var perimeter: Double {
        return 2 * (width + height)
    }

    mutating func scale(by factor: Double) {
        width *= factor
        height *= factor
    }
}

let originalRect = Rectangle(width: 4, height: 5)
var scaledCopy = originalRect
scaledCopy.scale(by: 2)

print("Original: \(originalRect.width) x \(originalRect.height), perimeter \(originalRect.perimeter)")
print("Scaled copy: \(scaledCopy.width) x \(scaledCopy.height), perimeter \(scaledCopy.perimeter)")

print("\n===== Task 3 =====")

struct Counter {
    var value = 0
    mutating func increment() { value += 1 }
}

class Box {
    var value = 0
    func increment() { value += 1 }
}

var c = Counter()
c.increment()
print("Counter value: \(c.value)")

let b = Box()
b.increment()
print("Box value: \(b.value)")

let anotherB = b
print("b and anotherB are the same object: \(b === anotherB)")

let differentBox = Box()
print("b and differentBox are the same object: \(b === differentBox)")

anotherB.increment()
print("b.value after incrementing through anotherB: \(b.value)")
