import QtQuick

Text {
    function hasNerdIconGlyph(value) {
        var s = String(value === undefined || value === null ? "" : value);

        for (var i = 0; i < s.length; i++) {
            var code = s.charCodeAt(i);

            if (code >= 0xe000 && code <= 0xf8ff)
                return true;

            if (code >= 0xdb80 && code <= 0xdbff)
                return true;
        }

        return false;
    }

    font.family: hasNerdIconGlyph(text) ? "Iosevka Nerd Font" : "Iosevka Nerd Font Mono"
    font.styleName: "Bold"
    font.weight: Font.Bold
    font.hintingPreference: Font.PreferVerticalHinting
    renderType: Text.QtRendering
}
