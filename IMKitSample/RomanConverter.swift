import Foundation

// Class to convert ASCII character stream into Japanese Hiragana/Katakana

class RomanConverter {
    var romanTable: [RomanTuple]
    
    init(_ romanTable: [RomanTuple]) {
        self.romanTable = romanTable
    }
    
    func convert(source: String) -> String {
        return source
    }
}

class RomanTuple {
    let from: String
    let to: String
    let rest: String
    
    init(_ from: String, _ to: String, _ rest: String) {
        self.from = from
        self.to = to
        self.rest = rest
    }
}

