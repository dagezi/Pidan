import Foundation

class RawInsertSelfCommand : PidanCommand {
    static var inst: PidanCommand = RawInsertSelfCommand()
    var name = "InsertSelfCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        context.rawString += context.inputString
        context.mode = .raw
        return .handled
    }
}

// for conv mode
// TODO: migrate to converter
class KataHiraCommand : PidanCommand {
    static var inst: PidanCommand = KataHiraCommand()
    var name = "KataHiraCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        let hira = context.romanConverter.convert(source: context.rawString)

        if !(context.prevCommand is KataHiraCommand) || context.hiraKataChars == 0 {
            context.hiraKataChars = hira.count
        }
        let kataStart = hira.startIndex
        let kataEnd = hira.index(kataStart, offsetBy: context.hiraKataChars)

        context.hiraKataChars -= 1
        context.convedString = hiraToKata(hira, range: kataStart ..< kataEnd)
        context.mode = .conv
        return .handled
    }
}

class RawBackSpaceCommand : PidanCommand {
    static var inst: PidanCommand = RawBackSpaceCommand()

    var name: String = "RawBackSpaceCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        if !context.rawString.isEmpty {
            context.rawString.removeLast()
        }
        if (context.rawString.isEmpty) {
            context.mode = .none
        }
        return .handled
    }
}

class NopCommand : PidanCommand {
    static var inst: PidanCommand = NopCommand()
    var name = "NopCommand"

    func execute(_: PidanContext) -> PidanCommandResult {
        // Nothing to do
        return .handled
    }
}

// Works in .raw and .conv
class FixCommand : PidanCommand {
    static var inst: PidanCommand = FixCommand()
    var name: String = "FixCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        var conved = context.rawString
        if let converter = context.kanziConverter {
            conved = converter.getConvedString()
        }
        context.insertToClient(conved)
        context.kanziConverter = nil
        context.convedString = ""
        context.rawString = ""
        context.mode = .none
        return .handled
    }
}

// Works in .raw and .conv
class FixAndExecuteCommand : PidanCommand {
    static var inst: PidanCommand = FixAndExecuteCommand()
    var name: String = "FixAndExecuteCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        _ = FixCommand.inst.execute(context)
        return .reexecute
    }
}

// Note: It doesn't work for Ctrl+M. Why?
class FixAndPassThruCommand : PidanCommand {
    static var inst: PidanCommand = FixAndPassThruCommand()
    var name: String = "FixAndPassThruCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        _ = FixCommand.inst.execute(context)
        return .through
    }
}
