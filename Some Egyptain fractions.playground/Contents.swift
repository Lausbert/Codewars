func decompose(_ nrStr: String, _ drStr: String) -> String {
    
    guard nrStr != "0", drStr != "0" else {return ""}
    
    guard var nr = Int(nrStr), var dr = Int(drStr) else {return "input error"}
    let nrDrGcd = gcd(nr, dr)
    nr = nr/nrDrGcd; dr = dr/nrDrGcd
    
    if nr == 1 {return dr > nr ? String(nr) + "/" + String(dr) : String(nr)}
    if dr == 1 {return String(nr)}
    
    let subtractNr = nr/dr == 0 ? 1 : nr/dr
    let subtractDr = dr/nr + 1
    let subtractStr = nr > dr ? String(subtractNr) : "\(subtractNr)/\(subtractDr)"
    let (newNr, newDr) = subtract(nr, dr, subtractNr, subtractDr)
    
    return subtractStr + "," + decompose(String(newNr), String(newDr))
}

func subtract(_ nr: Int, _ dr: Int, _ subtractNr: Int, _ subtractDr: Int) -> (Int, Int) {
    let drLcm = lcm(dr, subtractDr)
    let factorOne = drLcm/dr, factorTwo = drLcm/subtractDr
    return (factorOne*nr-factorTwo*subtractNr, drLcm)
}

func gcd(_ a : Int, _ b : Int) -> Int {
    var b = b, a = a
    while b != 0 {
        (a, b) = (b, a % b)
    }
    return abs(a)
}

func lcm( _ a : Int, _ b : Int) -> Int {
    return (a / gcd(a, b)) * b
}

decompose("3", "4")
decompose("12", "4")
decompose("4", "5")
decompose("66", "100")
decompose("22", "23")
decompose("155", "6")
