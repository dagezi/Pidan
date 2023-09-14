import Foundation

class DictionarySuffixType {
    let suffixes: [String]

    init(_ suffixes: [String]) {
        self.suffixes = suffixes
    }
}

let nullType = DictionarySuffixType([""])

let nounType = DictionarySuffixType([
    "は", "が", "に", "へ", "で", "から", "より", "でも", "も", "では", "の", "と",
    "って", "を", "か", "だ", "です", ""])

// let aGodanType
// let kGodanType
// let sGodanType
// let tGodanType
// let nGodanType
// let aGodanType
// let ichidanType
// let sahenType
// let keiyouType
// let keiyoudouType
// let sahenNounType

class DictionaryEntry {
    let srcRoot: String
    let srcSuffix: DictionarySuffixType
    let dest: String
    // TODO: some data for learning?

    init(_ srcRoot: String, _ dest: String, suffix: DictionarySuffixType = nounType) {
        self.srcRoot = srcRoot
        self.srcSuffix = suffix
        self.dest = dest
    }
}
