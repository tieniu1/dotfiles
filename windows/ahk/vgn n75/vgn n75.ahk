#NoEnv
#SingleInstance force
#HotkeyInterval 250
#MaxHotkeysPerInterval 250
#Persistent
;#NoTrayIcon
#UseHook

; win键定义
; 当单独按下 Pause 键时，模拟 Win 键的按下
Pause::SendInput {Blind}{Lwin}

; 当同时按下 Pause 和 L 键时，模拟 Win + L（锁屏）
Pause & l::DllCall("LockWorkStation")

; 当同时按下 Pause 和 R 键时，模拟 Win + R（运行）
Pause & r::SendInput {Blind}{Lwin down}r{Lwin up}

; 当同时按下 Pause 和 E 键时，模拟 Win + E（打开资源管理器）
Pause & e::SendInput {Blind}{Lwin down}e{Lwin up}

; 当同时按下 Pause 和 D 键时，模拟 Win + D（显示桌面）
Pause & d::SendInput {Blind}{Lwin down}d{Lwin up}

; 当同时按下 Pause 和 Space 键时，模拟 Win + Space（切换输入法）
Pause & Space::SendInput {Blind}{Lwin down}{Space}{Lwin up}



; 当按下 SpaceFn 键后再按下 h、j、k、l 中的任意一个键时，会分别映射为左、下、上、右方向键。如果您按下分号键，就会映射为 Esc 键。

;SpaceFn
#inputlevel,2
$Space::
    SetMouseDelay -1
    Send {Blind}{F24 DownR}
    KeyWait, Space
    Send {Blind}{F24 up}
    ; MsgBox, %A_ThisHotkey%-%A_TimeSinceThisHotkey%
    if(A_ThisHotkey="$Space" and A_TimeSinceThisHotkey<300)
        Send {Blind}{Space DownR}
    return

#inputlevel,1
F24 & k::Up
F24 & j::Down
F24 & h::Left
F24 & l::Right
F24 & `;:: Esc

