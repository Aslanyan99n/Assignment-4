# Person and Car

This project demonstrates the implementation of a simple Swift class system involving Person and Car classes. The Car class has a lazy closure that prints the car's model 3 seconds after initialization, showcasing the use of async tasks and safe memory management with weak references.

## Overview

- This code simulates the relationship between a Person and their Car. A Person can have a Car, and a Car can have a Person as its driver. The Car class includes a lazy closure to print the car's model 3 seconds after the car is initialized.

## Key Features

- Person Class: Represents a person with a name and an optional car property.
- Car Class: Represents a car with a model and an optional driver (weak reference to avoid memory retain cycles). Lazy closure printCarsModelAction that asynchronously prints the car's model 3 seconds after the car is initialized.

## Key Features

- Weak References: The Car class holds a weak reference to its driver (Person) to prevent strong reference cycles, ensuring that both objects can be deallocated properly when no longer in use.
- Lazy Closure: The Car class defines a lazy closure (printCarsModelAction) that prints the car's model asynchronously, 3 seconds after initialization.

## Memory Management

- Avoiding Retain Cycles: Since the Car class keeps a weak reference to its driver (a Person), the retain cycle between Person and Car is avoided, allowing them to be deallocated properly.

## Usage

```swift
// MARK: - PERSON

class Person {
    let name: String
    var car: Car?

    init(name: String, car: Car? = nil) {
        self.name = name
        self.car = car
    }
}

// MARK: - CAR

class Car {
    let model: String
    weak var driver: Person?

    lazy var printCarsModelAction: @Sendable () -> Void = { [model] in
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("The car's model is: \(model)")
        }
    }

    init(model: String, driver: Person? = nil) {
        self.model = model
        self.driver = driver
        printCarsModelAction()
    }
}

// Example usage

// Create a Person instance
var davit: Person? = Person(name: "Davit")

// Create a Car instance
var mercedes: Car? = Car(model: "C63 AMG")

// Assign car to person and driver to car
davit?.car = mercedes
mercedes?.driver = davit
