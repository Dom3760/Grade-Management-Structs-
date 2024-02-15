//
//  main.swift
//  Grade Management
//
//  Created by StudentAM on 1/29/24.
//

//import Foundation, and CSV to be able to read file
import Foundation
import CSV

//makes struct to be able to store student name, student grades, and final grades
struct person
{
    var StudentName: String
    var studentGrades: [Int]
    var studentFinalGrade: Int
}
//makes an array to store all names of students and structs.
var students: [person] = []

//start screen reads the CSV file, stores needed variables, and ask what the user wants to do
func startScreen()
{
    do {
        //finds the file at listed directory
        let stream = InputStream(fileAtPath: "/Users/studentam/desktop/Grade-Managemen-With-Structs/Grades.csv")
        
        guard let csvStream = stream else {
            print("Failed to open CSV file.")
            return
        }
        
        let csv = try CSVReader(stream: csvStream)
        
        //assigns the student names , and grades to the variables in the struct.
        while let row = csv.next() {
            let studentNames = (row[0])
            var studentGrades: [Int] = []
            for i in 1..<row.count {
                if let grade1 = Int(row[i]) {
                    studentGrades.append(grade1)
                }
                else {
                    print("Error converting grade to integer for \(studentNames), Grade \(i)")
                }
            }
            let finalGrade = calcGrade(studentGrades: studentGrades)
            let student = person(StudentName: studentNames, studentGrades: studentGrades, studentFinalGrade: Int(finalGrade))
            students.append(student)
        }
    } catch {
        print("Error reading CSV file: \(error)")
    }
    //ask the user what they want to do and then calls requsted function.
    print ("Welcome, what would you like to do")
    print ("1. Display grade of a single student")
    print ("2. Display all grades for a student")
    print ("3. Display all grades of ALL students")
    print ("4. Find the average grade of the class")
    print ("5. Find the average grade of an assignment")
    print ("6. Find the lowest grade in the class")
    print ("7. Find the highest grade of the class")
    print ("8. Filter students by grade range")
    print ("9. Quit")
    
    if let input1 = readLine()
    {
        if input1 == "1"
        {
            singleStudentsGrade()
        }
        if input1 == "2"
        {
            singleStudentsGrades()
        }
        if input1 == "3"
        {
            allStudentsGrades()
        }
        if input1 == "4"
        {
            averageOfClass()
        }
        if input1 == "5"
        {
            averageOnAssignment()
        }
        if input1 == "6"
        {
            lowestGrade()
        }
        if input1 == "7"
        {
            highestGrade()
        }
        if input1 == "8"
        {
            filter()
        }
        if input1 == "9"
        {
            print("have a good day!")
            exit(0)
        }
        else
        {
            print("Error")
            startScreen()
        }
    }
}

//function will take all students grades entered into the parameter then it will add them and divide by the number of grades to get average.
func calcGrade(studentGrades: [Int]) -> Double
{
    var current2: Int = 0
    
    for j in studentGrades
    {
        current2 += j
    }
    let average = Double(current2) / Double(studentGrades.count)
    return (average)
}
// after entering students name if it is found then it will print thier grade
func singleStudentsGrade() {
    print("Enter the name of the student:")
    if let inputName = readLine() {
        for i in students.indices
        {
            if inputName.lowercased() == students[i].StudentName.lowercased()
            {
                print("\(inputName) found")
                print("\(inputName)'s grade is: \(students[i].studentFinalGrade)")
            }
        }
        sleep(2)
        startScreen()
    }
}

// if students name is entered and it exist then it will display the grades
func singleStudentsGrades()
{
    
    print("Enter the name of the student:")
    if let inputName = readLine() {
        for i in students.indices
        {
            if inputName.lowercased() == students[i].StudentName.lowercased()
            {
                print("\(inputName) found")
                print("name:\(inputName) Grades:\(students[i].studentGrades)")
                sleep(2)
                startScreen()
            }
        }
        print("that name is not available or does not exist.")
        startScreen()
        
    }
}

// this uses a for in loop to display all of the names of the students and the grades
func allStudentsGrades()
{
    print("here are all the grades:")
    sleep(1)
    for i in students.indices
    {
        print("Name:\(students[i].StudentName) Grades: \(students[i].studentGrades)")
    }
    sleep(2)
    startScreen()
}

// this will take all of the final grades and then get the average of all of them
func averageOfClass()
{
    var num = 0
    for i in students.indices
    {
        num += Int(calcGrade(studentGrades: students[i].studentGrades))
    }
    num /= students.count
    print("The average of the class is \(num)")
    sleep(1)
    num = 0
    startScreen()
}

// the average on one assignment takes the index of the selected assignment and then adds all of them together and divides by the ammount on that assignment.
func averageOnAssignment()
{
    var current2 = 0
    print("what assignment would you like to see the average of (1-10)?")
    if let input1 = Int(readLine()!)
    {
        if input1 > 10 || input1 < 1
        {
            print("please enter a valid number")
            averageOnAssignment()
        }
        for i in students.indices
        {
            current2 += students[i].studentGrades[input1-1]
        }
        current2 /= students.count
        print("the average of that assignement is: \(current2)")
        current2 = 0
        sleep(2)
        startScreen()
    }
}
// lowest grade will make the first student have the current lowest and then it will compare all of the students after that and see if it is lower.
func lowestGrade()
{
    
    //assume the final grade of the first studend is the lowest
    var lowest = students[0].studentFinalGrade
    var name: String = ""
    
    for student in students{
        if student.studentFinalGrade < lowest
        {
            lowest = student.studentFinalGrade
            name = student.StudentName
        }
    }
    
    print("The lowest grade is by: \(name) with a grade of: \(lowest)")
    sleep(1)
    startScreen()
}

// Highest grade will make the first student have the current highest and then it will compare all of the students after that and see if it is higher.
func highestGrade()
{
    //assume the final grade of the first studend is the lowest
    var highest = students[0].studentFinalGrade
    var name: String = ""
    
    for student in students{
        if student.studentFinalGrade > highest
        {
            highest = student.studentFinalGrade
            name = student.StudentName
        }
    }
    
    print("The lowest grade is by: \(name) with a grade of: \(highest)")
    sleep(1)
    startScreen()}

//when filtering out the grades it takes the input for the low end and high end then it will print all of the grades between the wanted range.
func filter() {
    print("Enter the low range you would like to use?")
    var lowRange = 0
    while true 
    {
        if let input = readLine(), let range = Int(input)
        {
            if range >= 0
            {
                lowRange = range
                break
            } else 
            {
                print("That is not a valid number.")
                sleep(1)
            }
        } else 
        {
            print("Invalid input.")
            sleep(1)
        }
    }
    
    print("Enter the high range you would like to use?")
    var highRange = 0
    while true 
    {
        if let input = readLine(), let range = Int(input) 
        {
            if range >= 0
            {
                highRange = range
                break
            } 
            else
            {
                print("That is not a valid number.")
                sleep(1)
            }
        } 
        else
        {
            print("Invalid input.")
            sleep(1)
        }
    }

    if lowRange >= highRange 
    {
        print("Low range cannot be greater than or equal to high range.")
        sleep(1)
        filter()
    }

    for i in students.indices
    {
        let averageGrade = calcGrade(studentGrades: students[i].studentGrades);
        if Int(averageGrade) > lowRange && Int(averageGrade) < highRange
        {
            print("\(students[i].StudentName): \(averageGrade)")
        }
    }
    sleep(2)
    startScreen()
}

// put function call at the end then so it can delcare all variables then launch.
startScreen()
