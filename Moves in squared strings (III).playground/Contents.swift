func diag1Sym(_ s: String) -> String {
    
    let sArr = s.split(separator: "\n").map {Array($0.characters)}
    let n = sArr.count-1
    var newSArr = sArr
    
    for row in 0...n {
        for col in 0...n {
            newSArr[row][col] = sArr[col][row]
        }
    }
    
    let range = stride(from: n, through: 1, by: -1)
    for row in range {
        newSArr.insert(Array("\n".characters), at: row)
    }
    
    return newSArr.flatMap{String($0)}.reduce("", +)
}

func rot90Clock(s: String) -> String {
    
    let sArr = s.split(separator: "\n").map {Array($0.characters)}
    let n = sArr.count-1
    var newSArr = sArr
    
    for row in 0...n {
        for col in 0...n {
            newSArr[row][col] = sArr[n-col][row]
        }
    }
    
    let range = stride(from: n, through: 1, by: -1)
    for row in range {
        newSArr.insert(Array("\n".characters), at: row)
    }
    
    return newSArr.flatMap{String($0)}.reduce("", +)
}

func selfieAndDiag1(_ s: String) -> String {
    let s2 = diag1Sym(s)
    let s1Arr = s.split(separator: "\n")
    let s2Arr = s2.split(separator: "\n")
    return zip(s1Arr, s2Arr).map{$0.0 + "|" + $0.1}.joined(separator: "\n")
}

func oper(_ op: (String) -> String, _ s: String) -> String {
    return op(s)
}

let s = "abcd\nefgh\nijkl\nmnop"
oper(diag1Sym, s) //"aeim\nbfjn\ncgko\ndhlp"
oper(rot90Clock, s) //"miea\nnjfb\nokgc\nplhd"
oper(selfieAndDiag1, s) //"abcd|aeim\nefgh|bfjn\nijkl|cgko\nmnop|dhlp"
