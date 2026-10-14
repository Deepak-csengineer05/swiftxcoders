import Foundation

print("\n===== Task 1 =====")

let studentName = "Susi"
let rollNumber: Int = 2301

var semester = 5
var cgpa: Double = 8.4
let isHosteller: Bool = true

print("Name: \(studentName), Roll: \(rollNumber), Semester: \(semester)")

semester += 1
cgpa = 8.6
print("Name: \(studentName), Roll: \(rollNumber), Semester: \(semester), CGPA: \(cgpa)")

print("studentName is a \(type(of: studentName))")
print("rollNumber is a \(type(of: rollNumber))")
print("semester is a \(type(of: semester))")
print("cgpa is a \(type(of: cgpa))")
print("isHosteller is a \(type(of: isHosteller))")

print("\n===== Task 2 =====")

let fahrenheitMultiplier = 9.0
let fahrenheitDivisor = 5.0
let fahrenheitOffset = 32.0
let kelvinOffset = 273.15

var celsius = 36.6

func printConversions(for celsius: Double) {
    let fahrenheit = celsius * fahrenheitMultiplier / fahrenheitDivisor + fahrenheitOffset
    let kelvin = celsius + kelvinOffset

    print("\(String(format: "%.1f", celsius)) C = \(String(format: "%.1f", fahrenheit)) F = \(String(format: "%.1f", kelvin)) K")
}

printConversions(for: celsius)

celsius = 100.0
printConversions(for: celsius)

celsius = -40.0
printConversions(for: celsius)

print("\n===== Task 3 =====")

var price = 250
let quantity: Int = 3
let taxRate = 0.18

price = 300

let subtotal = Double(price * quantity)
let tax = subtotal * taxRate
let total = subtotal + tax

var title = "Order"
title = "Order #42"

print("\(title): subtotal \(String(format: "%.2f", subtotal)), tax \(String(format: "%.2f", tax))")
print("Total including tax: \(String(format: "%.2f", total))")
