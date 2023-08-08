import Foundation

class FixCommand : PidanCommand {
    static var inst: PidanCommand = FixCommand()
    var name: String = "FixCommand"

    func execute(_ context: PidanContext) {
        context.insertToClient(context.convedString)
        context.convedString = ""
        context.mode = .none
    }
}
