import Foundation
import AppKit
import Carbon.HIToolbox

let shiftBit = Int(NSEvent.ModifierFlags.shift.rawValue)
let commandBit = Int(NSEvent.ModifierFlags.command.rawValue)
let controlBit = Int(NSEvent.ModifierFlags.control.rawValue)
let optionBit = Int(NSEvent.ModifierFlags.option.rawValue)

let defaultMask = commandBit | controlBit | optionBit

struct CommandEntry {
    var keyCode: Int;
    var modifier: Int;
    var mask: Int;
    var command: PidanCommand;


    init(
        _ keyCode: Int,
        _ modifier: Int,
        _ command: PidanCommand,
        mask: Int = defaultMask
    ) {
        self.keyCode = keyCode
        self.modifier = modifier
        self.mask = mask
        self.command = command
    }
}

struct CommandMap {
    var selfInsertKeys: [Int] = [
        kVK_ANSI_A, kVK_ANSI_B, kVK_ANSI_C, kVK_ANSI_D,
        kVK_ANSI_E, kVK_ANSI_F, kVK_ANSI_G, kVK_ANSI_H,
        kVK_ANSI_I, kVK_ANSI_J, kVK_ANSI_K, kVK_ANSI_L,
        kVK_ANSI_M, kVK_ANSI_N, kVK_ANSI_O, kVK_ANSI_P,
        kVK_ANSI_Q, kVK_ANSI_R, kVK_ANSI_S, kVK_ANSI_T,
        kVK_ANSI_U, kVK_ANSI_V, kVK_ANSI_W, kVK_ANSI_X,
        kVK_ANSI_Y, kVK_ANSI_Z, kVK_ANSI_0, kVK_ANSI_1,
        kVK_ANSI_2, kVK_ANSI_3, kVK_ANSI_4, kVK_ANSI_5,
        kVK_ANSI_6, kVK_ANSI_7, kVK_ANSI_8, kVK_ANSI_9,
        kVK_ANSI_Minus, kVK_ANSI_Equal, kVK_ANSI_LeftBracket, kVK_ANSI_RightBracket,
        kVK_ANSI_Semicolon, kVK_ANSI_Quote, kVK_ANSI_Backslash, kVK_ANSI_Grave,
        kVK_ANSI_Comma, kVK_ANSI_Period, kVK_ANSI_Slash,
    ]

    var map: [PidanInputMode : [CommandEntry]] = [
        .none : [
        ],
        .raw: [
            CommandEntry(kVK_ANSI_H, controlBit, RawBackSpaceCommand.inst),
            CommandEntry(kVK_ANSI_J, controlBit, RawToHiraCommand.inst),
            CommandEntry(kVK_ANSI_K, controlBit, RawToHiraCommand.inst),
            CommandEntry(kVK_ANSI_L, controlBit, FixCommand.inst),
            CommandEntry(kVK_ANSI_M, controlBit, FixAndPassThruCommand.inst),
            CommandEntry(kVK_Tab, 0, FixAndPassThruCommand.inst),
            CommandEntry(kVK_Return, 0, FixAndPassThruCommand.inst),
            CommandEntry(kVK_Space, 0, FixAndPassThruCommand.inst),
        ],
        .conv: [
            CommandEntry(kVK_ANSI_K, controlBit, KataHiraCommand.inst),
            CommandEntry(kVK_ANSI_L, controlBit, FixCommand.inst),
            CommandEntry(kVK_ANSI_M, controlBit, FixAndPassThruCommand.inst),
            CommandEntry(kVK_Tab, 0, FixAndPassThruCommand.inst),
            CommandEntry(kVK_Return, 0, FixAndPassThruCommand.inst),
            CommandEntry(kVK_Space, 0, FixAndPassThruCommand.inst),
        ]
    ]

    var fallbackCommands: [PidanInputMode : PidanCommand] = [
        .raw : NopCommand.inst,
        .conv : NopCommand.inst,
    ]

    init() {
        for keyCode in selfInsertKeys {
            map[.none]?.append(
                CommandEntry(keyCode, 0, RawInsertSelfCommand.inst))
            map[.raw]?.append(
                CommandEntry(keyCode, 0, RawInsertSelfCommand.inst))
            map[.conv]?.append(
                CommandEntry(keyCode, 0, FixAndExecuteCommand.inst))
        }
    }
}
