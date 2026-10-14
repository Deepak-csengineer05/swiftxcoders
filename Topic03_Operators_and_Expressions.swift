import Foundation

print("\n===== Task 1 =====")

let itemPrice = 450.0
let quantity = 3
let subtotal = itemPrice * Double(quantity)

let hasCoupon = true
let discount = (hasCoupon && subtotal > 1000) ? subtotal * 0.10 : 0.0

let discountedAmount = subtotal - discount
let gst = discountedAmount * 0.18
let total = discountedAmount + gst

print("Subtotal: Rs. \(String(format: "%.2f", subtotal))")
print("Discount: Rs. \(String(format: "%.2f", discount))")
print("GST (18%): Rs. \(String(format: "%.2f", gst))")
print("Total: Rs. \(String(format: "%.2f", total))")

let people = 4
let share = total / Double(people)
print("Each of the \(people) people pays: Rs. \(String(format: "%.2f", share))")

let amount = 1234
let hundreds = amount / 100
let remainder = amount % 100
print("Rs. \(amount) = \(hundreds) hundreds and Rs. \(remainder) left over")

print("\n===== Task 2 =====")

for year in [1900, 2000, 2024, 2026] {
    let isLeapYear = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
    print("\(year) is a leap year: \(isLeapYear)")
}

for number in [0, 1, 57, 100, 101] {
    let inRange = (1...100).contains(number)
    print("\(number) is between 1 and 100: \(inRange)")
}

for number in [4, 7, 20, 30, 42] {
    let evenNotTen = number % 2 == 0 && number % 10 != 0
    print("\(number) is even and not a multiple of 10: \(evenNotTen)")
}

let nickname: String? = nil
print("Hello, \(nickname ?? "Guest")")

let anotherNickname: String? = "Susi"
print("Hello, \(anotherNickname ?? "Guest")")

print("\n===== Task 3 =====")

print(7 / 2)
print(7 % 2)
print(-7 % 3)
print(7.0 / 2)
print(10 - 2 * 3 + 4 / 2)
print(5 > 3 && 2 > 4 || true)
print(1 << 3)
print(6 & 3, 6 | 3, 6 ^ 3)
let x: UInt8 = 255
print(x &+ 1)
