import Foundation

print("\n===== Task 1 =====")

protocol Borrowable {
    var id: Int { get }
    var title: String { get }
    var isAvailable: Bool { get set }
}

struct Book: Borrowable {
    let id: Int
    let title: String
    let author: String
    var isAvailable = true
}

struct Magazine: Borrowable {
    let id: Int
    let title: String
    let issue: Int
    var isAvailable = true
}

enum LibraryError: Error {
    case itemNotFound(id: Int)
    case alreadyBorrowed(title: String)
    case limitReached(max: Int)
}

final class Member {
    static let limit = 2

    let name: String
    private(set) var borrowedIDs: [Int] = []

    init(name: String) {
        self.name = name
    }

    func recordBorrow(_ id: Int) throws {
        guard borrowedIDs.count < Member.limit else {
            throw LibraryError.limitReached(max: Member.limit)
        }
        borrowedIDs.append(id)
    }

    func recordReturn(_ id: Int) {
        borrowedIDs.removeAll { $0 == id }
    }
}

struct Catalog<Item: Borrowable> {
    private var items: [Int: Item] = [:]

    mutating func add(_ item: Item) {
        items[item.id] = item
    }

    func item(withID id: Int) -> Item? {
        return items[id]
    }

    mutating func checkout(id: Int, to member: Member) throws {
        guard var item = items[id] else {
            throw LibraryError.itemNotFound(id: id)
        }
        guard item.isAvailable else {
            throw LibraryError.alreadyBorrowed(title: item.title)
        }

        try member.recordBorrow(id)

        item.isAvailable = false
        items[id] = item
    }
}

var catalog = Catalog<Book>()
catalog.add(Book(id: 1, title: "Clean Code", author: "Robert Martin"))
catalog.add(Book(id: 2, title: "The Swift Programming Language", author: "Apple"))
catalog.add(Book(id: 3, title: "Algorithms", author: "Robert Sedgewick"))

let asha = Member(name: "Asha")

func lend(_ id: Int, from catalog: inout Catalog<Book>, to member: Member) {
    do {
        try catalog.checkout(id: id, to: member)
        print("Item \(id) issued to \(member.name)")
    } catch LibraryError.itemNotFound(let id) {
        print("Item \(id) does not exist")
    } catch LibraryError.alreadyBorrowed(let title) {
        print("\"\(title)\" is already borrowed")
    } catch LibraryError.limitReached(let max) {
        print("\(member.name) has reached the limit of \(max) items")
    } catch {
        print("Unexpected error: \(error)")
    }
}

lend(1, from: &catalog, to: asha)
lend(1, from: &catalog, to: asha)
lend(2, from: &catalog, to: asha)
lend(3, from: &catalog, to: asha)
lend(99, from: &catalog, to: asha)

print("Is book 3 still available? \(catalog.item(withID: 3)?.isAvailable ?? false)")
print("Asha's borrowed ids: \(asha.borrowedIDs)")

print("\n===== Task 2 =====")

protocol Entity {
    var id: Int { get }
}

enum RepositoryError: Error {
    case duplicateID(Int)
    case notFound(Int)
}

struct Repository<T: Entity> {
    private var storage: [Int: T] = [:]

    mutating func add(_ item: T) throws {
        guard storage[item.id] == nil else {
            throw RepositoryError.duplicateID(item.id)
        }
        storage[item.id] = item
    }

    func find(_ id: Int) -> T? {
        return storage[id]
    }

    mutating func remove(_ id: Int) throws {
        guard storage.removeValue(forKey: id) != nil else {
            throw RepositoryError.notFound(id)
        }
    }

    func all(where isIncluded: (T) -> Bool) -> [T] {
        return storage.values.filter(isIncluded).sorted { $0.id < $1.id }
    }
}

struct Student: Entity {
    let id: Int
    let name: String
    let marks: Int
}

struct Course: Entity {
    let id: Int
    let title: String
}

var students = Repository<Student>()
do {
    try students.add(Student(id: 3, name: "Meena", marks: 91))
    try students.add(Student(id: 1, name: "Asha", marks: 82))
    try students.add(Student(id: 2, name: "Ravi", marks: 35))
    try students.add(Student(id: 1, name: "Duplicate", marks: 0))
} catch RepositoryError.duplicateID(let id) {
    print("Cannot add, id \(id) already exists")
} catch {
    print("Unexpected: \(error)")
}

print("Find 2: \(students.find(2)?.name ?? "not found")")
print("Find 9: \(students.find(9)?.name ?? "not found")")

let everyone = students.all(where: { _ in true })
print("All sorted by id: \(everyone.map { $0.name })")

let toppers = students.all(where: { $0.marks >= 80 })
print("Marks 80 or more: \(toppers.map { $0.name })")

do {
    try students.remove(2)
    try students.remove(2)
} catch RepositoryError.notFound(let id) {
    print("Cannot remove, id \(id) was not found")
} catch {
    print("Unexpected: \(error)")
}

var courses = Repository<Course>()
try? courses.add(Course(id: 101, title: "iOS Development"))
try? courses.add(Course(id: 102, title: "Data Structures"))
print("Courses: \(courses.all(where: { _ in true }).map { $0.title })")

print("\n===== Task 3 =====")
protocol Describable {
    var summary: String { get }
}

extension Student: Describable {
    var summary: String { "\(name) scored \(marks) marks" }
}

extension Course: Describable {
    var summary: String { "Course: \(title)" }
}

extension Repository where T: Describable {
    func printReport() {
        print("----- Report -----")
        for item in all(where: { _ in true }) {
            print("#\(item.id) \(item.summary)")
        }
        print("------------------")
    }
}

var studentRepo = Repository<Student>()
try? studentRepo.add(Student(id: 2, name: "Ravi", marks: 35))
try? studentRepo.add(Student(id: 1, name: "Asha", marks: 82))
studentRepo.printReport()

var courseRepo = Repository<Course>()
try? courseRepo.add(Course(id: 101, title: "iOS Development"))
courseRepo.printReport()

struct Room: Entity {
    let id: Int
}

var roomRepo = Repository<Room>()
try? roomRepo.add(Room(id: 5))
