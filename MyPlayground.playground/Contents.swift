// an example struct
struct Player {
    var name: String
    var rank: String
}

// another example struct, this time with a method
struct Cavaliers {
    var name: String
    var maxPoint: Double
    var captain: Player
    
    func goTomaxPoint() {
        print("\(name) is now travelling at warp \(maxPoint)")
    }
}

// create instances of those two structs
var james = Player(name: "Lebron", rank: "Captain")
var irving = Cavaliers(name: "Kyrie", maxPoint: 9.975, captain: james)

// grab a reference to the `goTomaxPoint()` method
var score = irving.goTomaxPoint

// call that reference
score()

let captainNameKeyPath = \Cavaliers.captain.name

var captainName = irving[keyPath: captainNameKeyPath]
irving[keyPath: captainNameKeyPath] = "Peter"
print(captainName)
captainName = irving[keyPath: captainNameKeyPath]
