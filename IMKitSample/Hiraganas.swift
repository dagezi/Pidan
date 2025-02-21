import Foundation

func hiraToKata(_ src: String, range: Range<String.Index>? = nil) -> String {
    var conv = ""
    let sIndex: String.Index = range?.lowerBound ?? src.startIndex
    let eIndex: String.Index = range?.upperBound ?? src.endIndex

    var i = sIndex
    var replaced = false
    while i < eIndex {
        let mayKata = hiraKataMap[src[i]]
        replaced = replaced || (mayKata != nil)
        conv.append(mayKata ?? src[i])
        i = src.index(after: i)
    }

    if replaced {
        return "" + src[..<sIndex] + conv + src[eIndex...]
    }
    return src
}


func kataTohira(_ src: String, range: Range<String.Index>? = nil) -> String {
    if (kataHiraMap.isEmpty) {
        initKataHiraMap()
    }
    var conv = ""
    let sIndex: String.Index = range?.lowerBound ?? src.startIndex
    let eIndex: String.Index = range?.upperBound ?? src.endIndex

    var i = sIndex
    var replaced = false
    while i < eIndex {
        let mayHira = kataHiraMap[src[i]]
        replaced = replaced || (mayHira != nil)
        conv.append(mayHira ?? src[i])
        i = src.index(after: i)
    }
    if replaced {
        return "" + src[..<sIndex] + conv + src[eIndex...]
    }
    return src
}

private func initKataHiraMap() {
    for (hira, kata) in hiraKataMap {
        kataHiraMap[kata] = hira
    }
}

let hiraKataMap: Dictionary<Character, Character> = [
    "ぁ" : "ァ" ,
    "あ" : "ア",
    "ぃ" : "ィ",
    "い" : "イ",
    "ぅ" : "ゥ",
    "う" : "ウ",
    "ぇ" : "ェ",
    "え" : "エ",
    "ぉ" : "ォ",
    "お" : "オ",
    "か" : "カ",
    "が" : "ガ",
    "き" : "キ",
    "ぎ" : "ギ",
    "く" : "ク",
    "ぐ" : "グ",
    "け" : "ケ",
    "げ" : "ゲ",
    "こ" : "コ",
    "ご" : "ゴ",
    "さ" : "サ",
    "ざ" : "ザ",
    "し" : "シ",
    "じ" : "ジ",
    "す" : "ス",
    "ず" : "ズ",
    "せ" : "セ",
    "ぜ" : "ゼ",
    "そ" : "ソ",
    "ぞ" : "ゾ",
    "た" : "タ",
    "だ" : "ダ",
    "ち" : "チ",
    "ぢ" : "ヂ",
    "っ" : "ッ",
    "つ" : "ツ",
    "づ" : "ヅ",
    "て" : "テ",
    "で" : "デ",
    "と" : "ト",
    "ど" : "ド",
    "な" : "ナ",
    "に" : "ニ",
    "ぬ" : "ヌ",
    "ね" : "ネ",
    "の" : "ノ",
    "は" : "ハ",
    "ば" : "バ",
    "ぱ" : "パ",
    "ひ" : "ヒ",
    "び" : "ビ",
    "ぴ" : "ピ",
    "ふ" : "フ",
    "ぶ" : "ブ",
    "ぷ" : "プ",
    "へ" : "ヘ",
    "べ" : "ベ",
    "ぺ" : "ペ",
    "ほ" : "ホ",
    "ぼ" : "ボ",
    "ぽ" : "ポ",
    "ま" : "マ",
    "み" : "ミ",
    "む" : "ム",
    "め" : "メ",
    "も" : "モ",
    "ゃ" : "ャ",
    "や" : "ヤ",
    "ゅ" : "ュ",
    "ゆ" : "ユ",
    "ょ" : "ョ",
    "よ" : "ヨ",
    "ら" : "ラ",
    "り" : "リ",
    "る" : "ル",
    "れ" : "レ",
    "ろ" : "ロ",
    "ゎ" : "ヮ",
    "わ" : "ワ",
    "ゐ" : "ヰ",
    "ゑ" : "ヱ",
    "を" : "ヲ",
    "ん" : "ン",
    "ゔ" : "ヴ",
]

var kataHiraMap: [Character : Character] = [:]

