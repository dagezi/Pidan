//
//  IMKitSampleInputController.swift
//  IMKitSampleInputController
//
//  Created by ensan on 2021/09/07.
//

import Cocoa
import InputMethodKit

@objc(IMKitSampleInputController)
class IMKitSampleInputController: IMKInputController {
    let romanConverter = RomanConverter()
    var markedText = "";
    
    override func updateComposition() {
        NSLog("updateComposision")
        super.updateComposition()
    }
    
    override func cancelComposition() {
        NSLog("cancelComposition")
        super.cancelComposition()
    }

    override func selectionRange() -> NSRange {
        NSLog("SelectRange")
        return super.selectionRange()
    }

    override func replacementRange() -> NSRange {
        NSLog("replacementRange")
        return super.replacementRange()
    }
    
    override func inputText(_ string: String!, key keyCode: Int, modifiers flags: Int, client sender: Any!) -> Bool {
        NSLog("\(string ?? "-")/\(keyCode)/\(flags)")
        // get client to insert
        guard let client = sender as? IMKTextInput else {
            return false
        }
        if string[string.startIndex] < " " {
            // TODO: more generic
            client.insertText(
                romanConverter.convert(source: markedText),
                replacementRange: NSRange(location: NSNotFound, length: NSNotFound))
            markedText = ""
        } else {
            markedText += string
            client.setMarkedText(
                markedText,
                selectionRange: NSRange(location: 0, length: markedText.count),
                replacementRange: NSRange(location: NSNotFound, length: NSNotFound))
        }
        return true
    }
}
