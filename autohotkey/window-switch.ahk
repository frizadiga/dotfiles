#Requires AutoHotkey v2.0

!+Tab::
{
    KeyWait "Alt"    ; wait until Alt and Shift are released
    KeyWait "Shift"
    Send "!{Space}"  ; PowerToys Run activation hotkey
    Sleep 200
    Send "<"         ; Window Walker keyword
}
