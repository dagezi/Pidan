import Foundation

class Bunsetu {
    let src: Substring
    var candidates: [Candidate] = []
    var selected: Int = 0

    // We have special Bunsetu for Kata-and-hira, which has one dynamic candidate.
    var hiraKataChars: Int? = nil

    init(_ src: Substring, _ candidates: [Candidate]) {
        self.src = src
        self.candidates = candidates
    }

    init(_ src: Substring, kataChars: Int) {
        self.src = src
        setKataChars(kataChars)
    }

    func setKataChars(_ chars: Int) {
        let hiraSrc = String(src)
        let conved = hiraToKata(hiraSrc, range: hiraSrc.startIndex ..< hiraSrc.index(hiraSrc.startIndex, offsetBy: chars))
        let dynamicEntry = DictionaryEntry(hiraSrc, conved)
        hiraKataChars = chars
        candidates = [Candidate(dynamicEntry, "")]
        selected = 0
    }

    func getDest() -> String {
        return candidates[selected].getDest()
    }
}

class Candidate {
    let entry: DictionaryEntry
    let suffix: String

    init(_ entry: DictionaryEntry, _ suffix: String) {
        self.entry = entry
        self.suffix = suffix
    }

    func consumingLength() -> Int {
        return entry.srcRoot.count + suffix.count
    }

    func getDest() -> String {
        return entry.dest + suffix
    }
}

class Converter {
    var source: String = ""
    var bunsetu: Bunsetu?
    var rest: Substring?
    let dictionary: [DictionaryEntry]

    init(_ dictionary: [DictionaryEntry], _ src: String) {
        self.dictionary = dictionary
        self.source = src
    }

    func getConvedString() -> String {
        return (bunsetu?.getDest() ?? "") + (rest ?? "")
    }

    // Convert whole into one Hiragana (or raw) bunsetu
    func convertHira() {
        bunsetu = Bunsetu(source.dropFirst(0), kataChars: 0)
        rest = ""
    }

    func convertToKana() {
        bunsetu = Bunsetu(source.dropFirst(0), kataChars: source.count)
        rest = ""
    }

    // Look for just longest bunsetu
    func convertOne(_ start: String.Index? = nil) {
        let i = start ?? source.startIndex

        var candidates: [Candidate] = []
        for entry in dictionary {
            if source[i...].starts(with: entry.srcRoot) {
                let suffixIndex = source.index(i, offsetBy: entry.srcRoot.count)
                for suffix in entry.srcSuffix.suffixes {
                    if source[suffixIndex...].starts(with: suffix) {
                        candidates.append(Candidate(entry, suffix))
                    }
                }
            }
        }
        var consumedIndex = source.endIndex
        if candidates.isEmpty {
            let dynamicEntry = DictionaryEntry("", "")
            candidates.append(Candidate(dynamicEntry, source))
        } else {
            let consumedLen = candidates.map {$0.consumingLength()}.max()!
            candidates = candidates.filter {$0.consumingLength() == consumedLen}
            consumedIndex = source.index(i, offsetBy: consumedLen)
        }
        bunsetu = Bunsetu(source[i..<consumedIndex], candidates)
        rest = source[consumedIndex...]
    }

    // Current bunsetu into Kana, then turn to Hira from end one by one
    func modifyHiraKata() {
        guard let bun = bunsetu else {
            return
        }

        if let chars = bun.hiraKataChars {
            if chars > 0 {
                bun.setKataChars(chars - 1)
            } else {
                bun.setKataChars(bun.src.count)
            }
        } else {
            bunsetu = Bunsetu(bun.src, kataChars: 0)
        }
    }

    // Extend the current bunsetu lengnth one character
    func extendOne() {
    }

    // Shrink the current bunsetu lengnth one character
    func shrinkOne() {
    }
}
