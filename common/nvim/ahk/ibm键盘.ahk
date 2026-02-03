#NoEnv
#SingleInstance force
#HotkeyInterval 150
#MaxHotkeysPerInterval 200
#Persistent
#UseHook  ; 使用键盘钩子，确保按键映射能够正确处理

;------------------------通用配置 开始-------------------------------------------

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

; 1. 将 NumpadPgUp 映射为 LAlt
NumpadPgUp::
SendInput, {LAlt down}  ; 使用 SendInput 确保按键按下
KeyWait, NumpadPgUp  ; 等待按键释放
SendInput, {LAlt up}  ; 确保释放按键
return

; 2. 将 LAlt 映射为 LCtrl
LAlt::
SendInput, {LCtrl down}
KeyWait, LAlt  ; 等待按键释放
SendInput, {LCtrl up}
return

; 3. 将 LCtrl 映射为 LWin
LCtrl::
SendInput, {LWin down}
KeyWait, LCtrl  ; 等待按键释放
SendInput, {LWin up}
return



; 4. CapsLock 单击Esc 组合使用为Ctrl
CapsLock::
SendInput, {LCtrl down}
KeyWait, CapsLock  ; 等待按键释放
SendInput, {LCtrl up}
return


; 5. 按下 Space 键后再按下 h、j、k、l 中的任意一个键时，会分别映射为左、下、上、右方向键。如果您按下分号键，就会映射为 Esc 键。
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

;------------------------通用配置 结束-------------------------------------------

;------------------------本IBM键盘专用 开始-------------------------------------------
; 将 NumpadEnd 键映射为静音（音量静音/取消静音）
NumpadEnd::Volume_Mute
; 将 NumpadLeft 键映射为降低音量
NumpadLeft::Volume_Down
; 将 NumpadHome 键映射为提高音量
NumpadHome::Volume_Up
; 将 NumpadPgDn 键映射为显示应用程序菜单（相当于右键菜单键/应用键）
NumpadPgDn::Appskey
; 将浏览器前进按钮映射为页面下翻 (Page Down)，用于导航页面时替代 PgDn 键
Browser_Forward::pgdn
; 将浏览器后退按钮映射为页面上翻 (Page Up)，用于导航页面时替代 PgUp 键
Browser_Back::pgup

; 数字键盘：使用shift+NumLock键开启/关闭数字键盘,开启后键盘上方黄色的房子图标亮起黄灯
; 确保 NumLock 开启时，乘号正常工作 ()
NumpadMult::
IF GetKeyState("NumLock", "T")
    SendInput, *
else
    SendInput, {pgup}
return

; 确保 NumLock 开启时，减号正常工作
NumpadSub::
IF GetKeyState("NumLock", "T")
    SendInput, -
else
    SendInput, {pgdn}
return

;------------------------本IBM键盘专用 结束-------------------------------------------

;------------------------鼠标中键配合鼠标移动，上下左右滚动滚动条 开始-------------------------------------------
; 该脚本以 ScrollLock 键作为强制脚本暂停与开启
ScrollLock::
Suspend
SetScrollLockState % !GetKeyState("ScrollLock", "T")
return

; Midbutton down for scrolling {{{
; Feature: with acceleration as intended.
; Source: http://forum.notebookreview.com/threads/ultranav-middle-click-button-scroll.423415/
; Linking source: https://superuser.com/questions/91074/thinkpad-trackpoint-scrolling-and-middle-click-possible
; Working version {{{
$*MButton::
Hotkey, $*MButton Up, MButtonup, off
KeyWait, MButton, T0.2
If ErrorLevel = 1
{
	Hotkey, $*MButton Up, MButtonup, on
	MouseGetPos, ox, oy
 	SetTimer, WatchTheMouse, 5
	SystemCursor("Toggle")
}
Else
	Send {MButton}
return
MButtonup:
Hotkey, $*MButton Up, MButtonup, off
SetTimer, WatchTheMouse, off
SystemCursor("Toggle")
return
WatchTheMouse:
MouseGetPos, nx, ny
dy := ny-oy
dx := nx-ox
If (dx**2 > 0 and dx**2>dy**2) ;edit 4 for sensitivity (changes sensitivity to movement)
{
	times := Abs(dy)/1 ;edit 1 for sensitivity (changes frequency of scroll signal)
	Loop, %times%
	{
		If (dx > 0)
			Click WheelRight
		Else
			Click WheelLeft
   	}
}
If (dy**2 > 0 and dy**2>dx**2) ;edit 0 for sensitivity (changes sensitivity to movement)
{
	times := Abs(dy)/1 ;edit 1 for sensitivity (changes frequency of scroll signal)
	Loop, %times%
	{
		If (dy > 0)
			Click WheelDown
		Else
			Click WheelUp
	}
}
MouseMove ox, oy
return
SystemCursor(OnOff=1)   ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
    static AndMask, XorMask, $, h_cursor
        ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
        , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; blank cursors
        , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; handles of default cursors
    if (OnOff = "Init" or OnOff = "I" or $ = "")       ; init when requested or at first call
    {
        $ = h                                          ; active default cursors
        VarSetCapacity( h_cursor,4444, 1 )
        VarSetCapacity( AndMask, 32*4, 0xFF )
        VarSetCapacity( XorMask, 32*4, 0 )
        system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
        StringSplit c, system_cursors, `,
        Loop %c0%
        {
            h_cursor   := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% )
            h%A_Index% := DllCall( "CopyImage",  "uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 )
            b%A_Index% := DllCall("CreateCursor","uint",0, "int",0, "int",0
                , "int",32, "int",32, "uint",&AndMask, "uint",&XorMask )
        }
    }
    if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
        $ = b  ; use blank cursors
    else
        $ = h  ; use the saved cursors
    Loop %c0%
    {
        h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 )
        DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% )
    }
}
; }}}
; }}}

;------------------------鼠标中键配合鼠标移动，上下左右滚动滚动条 开始-------------------------------------------
