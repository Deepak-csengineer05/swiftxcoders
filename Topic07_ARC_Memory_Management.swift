import Foundation

print("\n===== Task 1 =====")

class LeakyPerson {
    let name: String
    var apartment: LeakyApartment?

    init(name: String) { self.name = name }
    deinit { print("LeakyPerson \(name) is deallocated") }
}

class LeakyApartment {
    let unit: String
    var tenant: LeakyPerson?

    init(unit: String) { self.unit = unit }
    deinit { print("LeakyApartment \(unit) is deallocated") }
}

print("--- Part A: strong references both ways ---")
var leakyPerson: LeakyPerson? = LeakyPerson(name: "John")
var leakyApartment: LeakyApartment? = LeakyApartment(unit: "4A")

leakyPerson?.apartment = leakyApartment
leakyApartment?.tenant = leakyPerson

leakyPerson = nil
leakyApartment = nil
print("Both variables are nil, but no deinit message was printed. Memory leak!")

class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) { self.name = name }
    deinit { print("Person \(name) is deallocated") }
}

class Apartment {
    let unit: String
    weak var tenant: Person?

    init(unit: String) { self.unit = unit }
    deinit { print("Apartment \(unit) is deallocated") }
}

print("--- Part B: tenant is weak ---")
var person: Person? = Person(name: "Asha")
var apartment: Apartment? = Apartment(unit: "7B")

person?.apartment = apartment
apartment?.tenant = person

person = nil
apartment = nil

print("\n===== Task 2 =====")

class LeakyDownloader {
    let name: String
    var onFinish: (() -> Void)?

    init(name: String) { self.name = name }

    func start() {

        onFinish = {
            print("Finished \(self.name)")
        }
    }

    deinit { print("LeakyDownloader \(name) is deallocated") }
}

print("--- Strong capture ---")
var leaky: LeakyDownloader? = LeakyDownloader(name: "movie.zip")
leaky?.start()
leaky?.onFinish?()
leaky = nil
print("leaky is nil but no deinit message appeared, so the object was never freed")

class Downloader {
    let name: String
    var onFinish: (() -> Void)?

    init(name: String) { self.name = name }

    func start() {
        onFinish = { [weak self] in
            guard let self = self else { return }
            print("Finished \(self.name)")
        }
    }

    deinit { print("Downloader \(name) is deallocated") }
}

print("--- Weak capture ---")
var fixed: Downloader? = Downloader(name: "notes.pdf")
fixed?.start()
fixed?.onFinish?()
fixed = nil

print("\n===== Task 3 =====")

class Box {
    deinit { print("Box gone") }
}

var a: Box? = Box()
var b = a
var c = a
a = nil
b = nil
print("before c")
c = nil
print("end")
