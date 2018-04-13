//: Playground - noun: a place where people can play

import UIKit

// ----------------------- 基础内容 ------------------------------

// let var
var str = "Hello, playground"
let str2 = "Hello, let"
//str = "var"
//str2 = "let"

// 定义，初值
var welcomeMessage: String = "hello"
welcomeMessage = "welcome"

// 合并定义
var red, green, blue: Double

// 打印，字符串拼接
print("hi you "+welcomeMessage)

// 字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// 类型别名
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

// 元组
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print(statusCode)
let http200Status = (statusCode: 200, description: "OK")
print(http200Status.statusCode)

// *可选项 ?!，展开
var optionalString: String?
var optionalString2: Optional<String>
var test = optionalString?.appending("append")
print(test)


// ----------------------- 运算符 ------------------------------
// 合并空值运算符
let defaultColorName = "red"
var userDefinedColorName: String? // defaults to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName

// 区间运算符
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}

// ----------------------- 容器类型 ------------------------------
// Array，Dictionary，set
var someInts = [Int]()
var shoppingList: [String] = ["Eggs", "Milk"]
print("someInts is of type [Int] with \(someInts.count) items.")

var namesOfIntegers = [Int: String]()
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
print("someInts is of type [Int] with \(airports.count) items.")

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}


// ----------------------- *函数 ------------------------------
// 一般
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
print(greet(person: "Anna"))

// 多返回值，元组
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

// 默认参数
func someFunction(parameterWithDefault: Int = 12) {
    // In the function body, if no arguments are passed to the function
    // call, the value of parameterWithDefault is 12.
}
someFunction(parameterWithDefault: 6) // parameterWithDefault is 6
someFunction() // parameterWithDefault is 12

// 可变参数
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers

// *输入输出形式参数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// prints "someInt is now 107, and anotherInt is now 3"

// *函数类型
// *函数类型作为形式参数类型 =? block
// *内嵌函数

// ----------------------- *闭包 ------------------------------
// *闭包表达式
//{ (parameters) -> (return type) in
//    statements
//}

// 行内闭包
let namesArray = ["Chris","Alex","Ewa","Barry","Daniella"]
let sortedArray = namesArray.sorted(by: { (aString: String, bString: String) -> Bool in
    return aString < bString
})
print(sortedArray)




