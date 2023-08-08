import Foundation

class RawInsertSelfCommand : PidanCommand {
    static var inst: PidanCommand = RawInsertSelfCommand()
    var name = "InsertSelfCommand"

    func execute(_ context: PidanContext) {
        context.rawString += context.inputString
        context.mode = .raw
    }
}

class RawToHiraCommand : PidanCommand {
    static var inst: PidanCommand = RawToHiraCommand()
    var name = "RawToHiraCommand"
    let romanConverter = RomanConverter(defaultRomanTable)

    func execute(_ context: PidanContext) {
        context.convedString =
            romanConverter.convert(source: context.rawString)
        context.rawString = ""
        context.mode = .conv
    }
}
