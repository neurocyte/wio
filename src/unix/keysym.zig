const std = @import("std");

pub fn toChar(sym: u32, utf32: u32) u21 {
    const char: u21 = switch (sym) {
        0xfe50 => '`', // dead_grave
        0xfe51 => 0xb4, // dead_acute
        0xfe52 => '^', // dead_circumflex
        0xfe53 => '~', // dead_tilde
        0xfe57 => 0xa8, // dead_diaeresis
        else => std.math.cast(u21, utf32) orelse 0,
    };
    return if (char < ' ' or char == 0x7f) 0 else char;
}

pub fn toUtf32(sym: u32) u32 {
    return switch (sym) {
        0x20...0x7e, 0xa0...0xff => sym,
        0x20ac => 0x20ac, // EuroSign
        0x1000100...0x110ffff => sym - 0x1000000,
        else => 0,
    };
}
