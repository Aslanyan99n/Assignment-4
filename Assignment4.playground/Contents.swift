import UIKit

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

var davit: Person? = Person(name: "Davit")
var mercedes: Car? = Car(model: "C63 AMG")

davit?.car = mercedes
mercedes?.driver = davit
