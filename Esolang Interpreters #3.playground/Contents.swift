func interpreter(code: String, iterations: Int, width: Int, height: Int) -> String {
    let codeArr = code.characters.filter {["n","e","s","w","*","[","]"].contains($0)}.flatMap {String($0)}
    var row = 0, col = 0, comm = 0, iter = 0, dataGrid = Array(repeating: Array(repeating: 0, count: width), count: height)
    while iter < iterations && comm >= 0 && comm < codeArr.count {
        iter += 1
        switch codeArr[comm] {
        case "n":
            row = row == 0 ? height - 1 : row - 1
        case "e":
            col = col == width - 1 ? 0 : col + 1
        case "s":
            row = row == height - 1 ? 0 : row + 1
        case "w":
            col = col == 0 ? width - 1 : col - 1
        case "*":
            dataGrid[row][col] = 1 - dataGrid[row][col]
        case "[":
            if dataGrid[row][col] == 0 {
                var count = 1
                while count != 0 {
                    comm += 1
                    if codeArr[comm] == "]" {count -= 1}
                    if codeArr[comm] == "[" {count += 1}
                }
            }
        case "]":
            if dataGrid[row][col] != 0 {
                var count = 1
                while count != 0 {
                    comm -= 1
                    if codeArr[comm] == "]" {count += 1}
                    if codeArr[comm] == "[" {count -= 1}
                }
            }
        default:
            break
        }
        comm += 1
    }
    return dataGrid.map {$0.map {String($0)}.reduce("", +)}.joined(separator: "\r\n")
}

var (code, iterations, width, height) = ("*e*e*e*es*es*ws*ws*w*w*w*n*n*n*ssss*s*s*s*", 0, 6, 9)
interpreter(code: code, iterations: iterations, width: width, height: height) == "000000\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000"
iterations = 7
interpreter(code: code, iterations: iterations, width: width, height: height) == "111100\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000\r\n000000"
iterations = 19
interpreter(code: code, iterations: iterations, width: width, height: height) == "111100\r\n000010\r\n000001\r\n000010\r\n000100\r\n000000\r\n000000\r\n000000\r\n000000"
iterations = 42
interpreter(code: code, iterations: iterations, width: width, height: height) == "111100\r\n100010\r\n100001\r\n100010\r\n111100\r\n100000\r\n100000\r\n100000\r\n100000"
iterations = 100
interpreter(code: code, iterations: iterations, width: width, height: height) == "111100\r\n100010\r\n100001\r\n100010\r\n111100\r\n100000\r\n100000\r\n100000\r\n100000"
