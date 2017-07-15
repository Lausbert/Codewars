func interpreter(_ code: String, _ tape: String) -> String {
    let codeArr = code.characters.filter {[">","<","*","[","]"].contains($0)}.flatMap {String($0)}
    var pointer = 0, comm = 0, tapeArr:[Int] = tape.characters.flatMap {Int(String($0))}
    while (pointer >= 0 && pointer < tapeArr.count) && comm != codeArr.count {
        switch codeArr[comm] {
        case ">":
            pointer += 1
            comm += 1
        case "<":
            pointer -= 1
            comm += 1
        case "*":
            tapeArr[pointer] = 1 - tapeArr[pointer]
            comm += 1
        case "[":
            if tapeArr[pointer] == 0 {
                var count = 1
                while count != 0 {
                    comm += 1
                    if codeArr[comm] == "]" {count -= 1}
                    if codeArr[comm] == "[" {count += 1}
                }
            }
            comm += 1
        case "]":
            if tapeArr[pointer] != 0 {
                var count = 1
                while count != 0 {
                    comm -= 1
                    if codeArr[comm] == "]" {count += 1}
                    if codeArr[comm] == "[" {count -= 1}
                }
            } else {
                comm += 1
            }
        default:
            break
        }
    }
    return tapeArr.flatMap {String($0)}.reduce("", +)
}

interpreter("*", "00101100") //"10101100"
interpreter(">*>*", "00101100") //"01001100"
interpreter("*>*>*>*>*>*>*>*", "00101100") //"11010011"
interpreter("*>*>>*>>>*>*", "00101100") //"11111111"
interpreter(">>>>>*<*<<*", "00101100") //"00000000"
interpreter("[[]*>*>*>]", "000") //"000"
interpreter("*>[[]*>]<*", "100") //"100"
interpreter("[*>[>*>]>]", "11001") //"01100"
interpreter("[>[*>*>*>]>]", "10110") //"10101"

