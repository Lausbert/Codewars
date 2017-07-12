import Foundation

class kata_dartboard {
    
    static let bullsEyeRadius = 6.35
    static let bullRadius = 15.9
    static let tripleRingInnerCircleRadius = 99.0
    static let tripleRingOuterCircleRadius = 107.0
    static let doubleRingInnerCircleRadius = 162.0
    static let doubleRingOuterCircleRadius = 170.0
    
    class func Throw(dart: (x: Double, y: Double)) -> String {
        
        var score: String
        let x = dart.x, y = dart.y
        let radius = sqrt(x*x+y*y)
        let angle = (atan2(x,y)/Double.pi)*180.0
        
        print(radius)
        print(angle)
        
        switch radius {
        case 0...bullsEyeRadius:
            return "DB"
        case bullsEyeRadius...bullRadius:
            return "SB"
        case bullRadius...tripleRingInnerCircleRadius:
            score = ""
        case tripleRingInnerCircleRadius...tripleRingOuterCircleRadius:
            score = "T"
        case tripleRingOuterCircleRadius...doubleRingInnerCircleRadius:
            score = ""
        case doubleRingInnerCircleRadius...doubleRingOuterCircleRadius:
            score = "D"
        case doubleRingOuterCircleRadius...Double.infinity:
            return "X"
        default:
            return "error in radius calculation"
        }
        
        switch angle {
        case -180.0 ... -171.0:
            score += "3"
        case -171.0 ... -153.0:
            score += "19"
        case -153.0 ... -135.0:
            score += "7"
        case -135.0 ... -117.0:
            score += "16"
        case -117.0 ... -99.0:
            score += "8"
        case -99.0 ... -81.0:
            score += "11"
        case -81.0 ... -63.0:
            score += "14"
        case -63.0 ... -45.0:
            score += "9"
        case -45.0 ... -27.0:
            score += "12"
        case -27.0 ... -9.0:
            score += "5"
        case -9.0 ... 9.0:
            score += "20"
        case 9.0 ... 27.0:
            score += "1"
        case 27.0 ... 45.0:
            score += "18"
        case 45.0 ... 63.0:
            score += "4"
        case 63.0 ... 81.0:
            score += "13"
        case 81.0 ... 99.0:
            score += "6"
        case 99.0 ... 117.0:
            score += "10"
        case 117.0 ... 135.0:
            score += "15"
        case 135.0 ... 153.0:
            score += "2"
        case 153.0 ... 171.0:
            score += "17"
        case 171.0 ... 180.0:
            score += "3"
        default:
            return "error in angle calculation"
        }
        
        return score
    }
}

kata_dartboard.Throw(dart: (x: 15.0, y: -120.0))
