import Foundation
import InputMethodKit

enum PidanInputMode: String {
    case none   // User never input anything
    case raw    // User has input some characters, but not translateed
    case conv   // User started translation, choosing cnaididate
}

class PidanContext {
    let romanConverter = RomanConverter(defaultRomanTable)

    var mode: PidanInputMode = PidanInputMode.none
    var rawString: String = ""
    var convedString: String = "" // Temporary

    var prevCommand: PidanCommand? = nil

    var inputString: String = ""
    var inputKeyCode: Int = -1
    var inputModifier: Int = -1
    var inputClient: IMKTextInput?

    func insertToClient(_ s: String) {
        if (inputClient == nil) {
            NSLog("insertToClient: client is nil")
        } else {
            inputClient!.insertText(
                s, replacementRange: NSRange(location: NSNotFound, length: NSNotFound))
        }
    }

    // HiraKata commands
    var hiraKataChars: Int = 0
}


enum PidanCommandResult {
    case handled      // Handled
    case notHandled   // Not handled
    case reexecute    // Handled, but re execute with new state
}

protocol PidanCommand {
    static var inst: PidanCommand { get }
    var name: String { get }
    func execute(_ : PidanContext) -> PidanCommandResult
}

