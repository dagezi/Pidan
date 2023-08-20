import Cocoa
import InputMethodKit

@objc(IMKitSampleInputController)
class IMKitSampleInputController: IMKInputController {
    var context: PidanContext = PidanContext()
    var commandMap: CommandMap = CommandMap()

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

    override func inputText(_ string: String!, key keyCode: Int, modifiers: Int, client sender: Any!) -> Bool {
        NSLog("mode: \(context.mode) %02x %d %x",
              string.first?.asciiValue ?? 0, keyCode, modifiers)
        // get client to insert
        guard let client = sender as? IMKTextInput else {
            return false
        }

        context.inputClient = client
        context.inputString = string
        context.inputKeyCode = keyCode
        context.inputModifier = modifiers

        var result: PidanCommandResult = .reexecute
        while (result == .reexecute) {
            result = .notHandled
            for entry in commandMap.map[context.mode]! {
                if keyCode == entry.keyCode, (modifiers & entry.mask) == entry.modifier {
                    NSLog("\(modifiers) \(entry.mask) \(entry.modifier) command: \(entry.command.name)")
                    result = entry.command.execute(context)
                    context.prevCommand = entry.command
                    break
                }
            }
        }
        if result == .notHandled {
            let mayFallback: PidanCommand? = commandMap.fallbackCommands[context.mode]
            if let fallback = mayFallback {
                result = fallback.execute(context)
                context.prevCommand = fallback
            }
        }
        context.inputClient = nil

        switch (context.mode) {
        case .none:
            client.setMarkedText(
                "",
                selectionRange: NSRange(location: 0, length: 0),
                replacementRange: NSRange(location: NSNotFound, length: NSNotFound))

        case .raw:
            client.setMarkedText(
                context.rawString,
                selectionRange: NSRange(location: context.rawString.count, length: 0),
                replacementRange: NSRange(location: NSNotFound, length: NSNotFound))

        case .conv:
            let attr = NSMutableAttributedString(string: context.convedString)
            attr.addAttribute(NSAttributedString.Key.underlineStyle,
                              value: NSUnderlineStyle.thick.rawValue,
                              range: NSMakeRange(0, attr.length))
            client.setMarkedText(
                attr,
                selectionRange: NSRange(location: attr.length, length: 0),
                replacementRange: NSRange(location: NSNotFound, length: NSNotFound))
        }
        return result == .handled
    }
}
