import Foundation

class Bunsetu {
    let src: Substring
    // Should it have candidate?
    var candidates: [Candidate] = []
    var selected: Int = 0

    init(_ src: Substring, _ candidates: [Candidate]) {
        self.src = src
        self.candidates = candidates
    }

    func getDest() -> String {
        return candidates[selected].getDest()
    }

    // Can we modify src of bunsetu?
    // Do we have special Kata-suffixed-Hira Bunsetu?
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

    // Convert into one Hiragana (or raw) bunsetu
    func convertHira(_ start: String.Index? = nil) {
        let i = start ?? source.startIndex

        let dynamicEntry = DictionaryEntry("", "")
        let candidates = [Candidate(dynamicEntry, source)]
        bunsetu = Bunsetu(source[i...], candidates)
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

    // Extend the current bunsetu lengnth one character
    func extendOne() {
    }

    // Shrink the current bunsetu lengnth one character
    func shrinkOne() {
    }
}
