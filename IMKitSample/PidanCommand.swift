import Foundation
import InputMethodKit

enum PidanInputMode: String {
    case none   // User never input anything
    case raw    // User has input some characters, but not converted
    case conv   // User started conversion, choosing cnaididate
}

class PidanContext {
    let romanConverter = RomanConverter(defaultRomanTable)
    let dictionary = defaultDictionary
    var kanziConverter: Converter? = nil

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
}


enum PidanCommandResult {
    case handled      // Handled
    case notHandled   // Not handled
    case reexecute    // Handled, but re execute with new state
    case through      // Handled, but through event to client
}

protocol PidanCommand {
    static var inst: PidanCommand { get }
    var name: String { get }
    func execute(_ : PidanContext) -> PidanCommandResult
}

