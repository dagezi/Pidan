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

let aGodanType = DictionarySuffixType([
    "わ", "い", "う", "えば", "え", "お", "っ"
])

let kGodanType = DictionarySuffixType([
    "か", "き", "く", "けば", "け", "こ", "い"
])

let sGodanType = DictionarySuffixType([
    "さ", "し", "す", "せば", "せ", "そ"
])

let tGodanType = DictionarySuffixType([
    "た", "ち", "つ", "てば", "て", "と", "っ"
])
let nGodanType = DictionarySuffixType([
    "な", "に", "ぬ", "ねば", "ね", "の", "ん"
])
let bGodanType = DictionarySuffixType([
    "ば", "び", "ぶ", "べば", "べ", "ぼ", "ん"
])
let mGodanType = DictionarySuffixType([
    "ま", "み", "む", "めば", "め", "も", "ん"
])
let rGodanType = DictionarySuffixType([
    "ら", "り", "る", "れば", "れ", "ろ", "っ"
])
let itidanType = DictionarySuffixType([
   "", "る", "れば", "ろ", "よ"
])
let sahenType = DictionarySuffixType([
    "さ", "し", "する", "すれ", "しろ", "せよ"
])
let keiyouType = DictionarySuffixType([
    "い", "く", "けれ", "かろ", "かっ"
])
let keiyoudouType = DictionarySuffixType([
    "だろ", "だっ", "で", "に", "だ", "な", "なら"
])


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
