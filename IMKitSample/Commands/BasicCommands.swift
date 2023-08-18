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

class RawToHiraCommand : PidanCommand {
    static var inst: PidanCommand = RawToHiraCommand()
    var name = "RawToHiraCommand"
    let romanConverter = RomanConverter(defaultRomanTable)

    func execute(_ context: PidanContext) -> PidanCommandResult {
        context.convedString =
            romanConverter.convert(source: context.rawString)
        context.rawString = ""
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
        context.insertToClient(
            context.mode == .raw ? context.rawString :context.convedString)
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
        FixCommand.inst.execute(context)
        return .reexecute
    }
}
