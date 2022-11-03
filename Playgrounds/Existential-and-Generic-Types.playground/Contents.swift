import Foundation

protocol Pollinator {
    func pollinate(_ plant: String)
}

struct Hummingbird: Pollinator {
    func pollinate(_ plant: String) {
        print("\(plant) pollinated by a hummingbird's bill.")
    }
}

struct Insect: Pollinator {
    func pollinate(_ plant: String) {
        print("\(plant) pollinated by an insect's legs.")
    }
}

let speedy = Hummingbird()
let busyBee = Insect()
speedy.pollinate("Daisy")
busyBee.pollinate("Marigold")
// Daisy pollinated by a hummingbird's bill.
// Marigold pollinated by an insect's legs.

// generic function
// a generic function with a generic type (this type has to be conform to the Pollinator protocol) which accepts as a first parameter an array of strings (representing plants) and a generic type that have to be confrom to the Pollinator protocol.
func pollinate<T: Pollinator>(_ plants: [String], with pollinator: T) {
    for plant in plants {
        pollinator.pollinate(plant)
    }
}

pollinate(["Rose", "Thistle"], with: speedy)
pollinate(["Prickly Peer"], with: busyBee)

// the keywork "any" denotes that any Pollinator is an existential type.
var anotherPollinator: any Pollinator = Hummingbird()
anotherPollinator.pollinate("Dandelion")
anotherPollinator = Insect()
anotherPollinator.pollinate("Dandelion")

func pollinate2(_ plants: [String], with pollinator: any Pollinator) {
    for plant in plants {
        pollinator.pollinate(plant)
    }
}
pollinate(["first plant", "second plant"], with: anotherPollinator)

// ME
protocol Saludador {
    func saludoPersonalizado(name: String)
}

struct Luciano: Saludador {
    func saludoPersonalizado(name: String) {
        print("Hola, mi nombre es Luciano y te saludo a tí \(name) ")
    }
}

struct Cecilia: Saludador {
    func saludoPersonalizado(name: String) {
        print("Hola, mi nombre es Cecilia y te saludo a tí \(name) ")
    }
}

let lucianoInstance = Luciano()
let ceciliaInstance = Cecilia()
lucianoInstance.saludoPersonalizado(name: "Nino")
ceciliaInstance.saludoPersonalizado(name: "Juana")
