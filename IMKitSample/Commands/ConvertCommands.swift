import Foundation

class StartConvertCommand : PidanCommand {
    static var inst: PidanCommand = StartConvertCommand()
    var name = "StartConvertCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        guard context.mode == .raw else {
            return .handled
        }
        let hira = context.romanConverter.convert(source: context.rawString)
        let converter = Converter(context.dictionary, hira)
        converter.convertOne()
        context.mode = .conv
        context.kanziConverter = converter

        return .handled
    }
}

class RawToHiraCommand : PidanCommand {
    static var inst: PidanCommand = RawToHiraCommand()
    var name = "RawToHiraCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        let hira =
            context.romanConverter.convert(source: context.rawString)
        let converter = Converter(context.dictionary, hira)
        converter.convertHira()
        context.mode = .conv
        context.kanziConverter = converter

        return .handled
    }
}

class KataHiraCommand : PidanCommand {
    static var inst: PidanCommand = KataHiraCommand()
    var name = "KataHiraCommand"

    func execute(_ context: PidanContext) -> PidanCommandResult {
        guard context.mode == .conv else {
            return .handled
        }

        if let converter = context.kanziConverter {
            converter.modifyHiraKata()
        }
        return .handled
    }
}

