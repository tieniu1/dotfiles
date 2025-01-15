#NoEnv
#SingleInstance force
#HotkeyInterval 250
#MaxHotkeysPerInterval 250
#Persistent
;#NoTrayIcon
#UseHook

; 使用 #If 指令来处理修饰键状态

; 物理 Ctrl 键被按住时,触发Win键映射
#If GetKeyState("LCtrl", "P")

l::
DllCall("LockWorkStation")
SendInput {LCtrl up}
return

*::
key := SubStr(A_ThisHotkey, 0)
SendInput {LWin down}%key%{LWin up}
SendInput {LCtrl up}  ; 确保Ctrl键被释放
return
#If

; 物理 Win 键被按住时,触发Alt键映射
#If GetKeyState("LWin", "P")  ; 物理 Win 键被按住时
*::  ; * 表示匹配任意按键
key := SubStr(A_ThisHotkey, 0)  ; 获取实际按下的键
SendInput {LAlt down}%key%{LAlt up}
SendInput {LWin up}
return
#If

; 物理 Alt 键被按住时,触发Ctrl键映射
#If GetKeyState("LAlt", "P")
l::
SendInput {LCtrl down}l{LCtrl up}
SendInput {LAlt up}  ; 确保Alt键被释放
return
#If

; 添加默认的 L 键映射（当没有修饰键按下时）
#If  ; 清除所有条件
l::SendInput {Blind}l
#If

; 1. Win 键映射
LWin::
SendInput {LAlt down}
KeyWait, LWin
SendInput {LAlt up}
return

; 2. Alt 键映射
LAlt::
SendInput {LCtrl down}
KeyWait, LAlt
SendInput {LCtrl up}
return

; 3. Ctrl 键映射
LCtrl::
SendInput {LWin down}
KeyWait, LCtrl
SendInput {LWin up}
return

; 4. CapsLock 映射
CapsLock::
SendInput {LCtrl down}
KeyWait, CapsLock
SendInput {LCtrl up}
return


; 6. SpaceFn 键后再按下 h、j、k、l 中的任意一个键时，会分别映射为左、下、上、右方向键。如果您按下分号键，就会映射为 Esc 键。

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


