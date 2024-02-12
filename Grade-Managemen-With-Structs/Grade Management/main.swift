//
//  main.swift
//  Grade Management
//
//  Created by StudentAM on 1/29/24.
//

import Foundation
import CSV

struct person 
{
    var StudentName: String
    var studentGrades: [Int]
    var studentFinalGrade: Int
}
var students: [person] = []
//var student: person = person(StudentName: <#T##String#>, studentGrades: [1,2,3,4,5,6], studentFinalGrade: <#T##Int#>)

func startScreen()
{
    do {
        
        let stream = InputStream(fileAtPath: "/Users/studentam/desktop/Grade-Management/Grades.csv")
        
        guard let csvStream = stream else {
            print("Failed to open CSV file.")
            return
        }
        
        let csv = try CSVReader(stream: csvStream)
        
        while let row = csv.next() {
            var studentNames = (row[0])
            var studentGrades: [Int] = []
            for i in 1..<row.count {
                if let grade1 = Int(row[i]) {
                    studentGrades.append(grade1)
                }
                else {
                    print("Error converting grade to integer for \(studentNames), Grade \(i)")
                }
            }
            let finalGrade = calcGrade(studentGrades: student.grades)
            let student = person(StudentName: studentNames, studentGrades: studentGrades, studentFinalGrade: finalGrade)
            students.append(student)
        }
    } catch {
        print("Error reading CSV file: \(error)")
    }
    
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

func calcGrade(studentGrades: [Int]) -> [Int]
{
    var grades2: [Int] = []
    var current2 = 0
    
    for i in grade.indices
    {
        for j in grade[i].indices
        {
            current2 += grade[i][j]
        }
        current2 /= grade[i].count
        grades2.append(current2)
        current2 = 0
    }
    return (grades2)
}

func singleStudentsGrade() {
    print("Enter the name of the student:")
    if let inputName = readLine() {
        for i in studentNames.indices
        {
            if inputName.lowercased() == studentNames[i].lowercased()
            {
                print("\(inputName) found")
                print("\(inputName)'s grade is: \(calcGrade()[i])")
            }
        }
        sleep(2)
        startScreen()
    }
}


func singleStudentsGrades()
{
    
    print("Enter the name of the student:")
    if let inputName = readLine() {
        for i in studentNames.indices
        {
            if inputName == studentNames[i]
            {
                print("\(inputName) found")
                print("name:\(studentNames[i]) Grades:\(grade[i])")
                sleep(2)
                startScreen()
            }
        }
        print("that name is not available or does not exist.")
        startScreen()
        
    }
}

func allStudentsGrades()
{
    print("here are all the grades:")
    sleep(1)
    for i in studentNames.indices
    {
        print("Name:\(studentNames[i]) Grades: \(grade[i])")
    }
    sleep(2)
    startScreen()
}

func averageOfClass()
{
    var num = 0
    for i in grade.indices
    {
        num += calcGrade()[i]
    }
    num /= grade.count
    print("The average of the class is \(num)")
    sleep(1)
    num = 0
    startScreen()
}

func averageOnAssignment()
{
    var current2 = 0
    print("what assignment would you like to see the average of (1-10)?")
    if let input1 = Int(readLine()!)
    {
        for i in grade.indices
        {
            current2 += grade[i][input1-1]
        }
        current2 /= studentNames.count
        print("the average of that assignement is: \(current2)")
        current2 = 0
        sleep(2)
        startScreen()
    }
}

func lowestGrade()
{
    if let lowest = calcGrade().min(), let index = calcGrade().firstIndex(of: lowest)
    {
        print ("the lowest grade is by: \(studentNames[index]) with a grade of: \(lowest)")
    }
    sleep(1)
    startScreen()
    //    if let minNumber = numbers.min(), let index = numbers.firstIndex(of: minNumber) {
}

func highestGrade()
{
    if let highest = calcGrade().max(), let index = calcGrade().firstIndex(of: highest)
    {
        print ("the lowest grade is by: \(studentNames[index]) with a grade of: \(highest)")
    }
    sleep(1)
    startScreen()
}

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

    for i in studentNames.indices 
    {
        let averageGrade = calcGrade()[i]
        if averageGrade > lowRange && averageGrade < highRange 
        {
            print("\(studentNames[i]): \(averageGrade)")
        }
    }
    sleep(2)
    startScreen()
}


startScreen()
