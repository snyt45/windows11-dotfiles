; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; IMEのON/OFFの制御を行う関数
; IME_SET(0): IME OFF、IME_SET(1): IME ON
; ref: https://namayakegadget.com/765/
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
IME_SET(SetSts, WinTitle="A")    {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 無変換キーをベースとしたショートカットキー割当
; ref: https://snowsystem.net/other/win
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

; 無変換の単発押しはIME OFF
vk1D::IME_SET(0)

; ----------------------------------
; vimのcursolkey
; ----------------------------------
vk1D & h::Left
vk1D & j::Down
vk1D & k::Up
vk1D & l::Right

; ----------------------------------
; word jump
; ----------------------------------
vk1D & u::
  if GetKeyState("Shift") {
    Send ^+{Left}
    return
  }
  Send ^{Left}
  return

vk1D & i::
  if GetKeyState("Shift") {
    Send ^+{Right}
    return
  }
  Send ^{Right}
  return

; ----------------------------------
; コロン(vkBA)とセミコロン(vkBB)をEnter
; ----------------------------------
vk1D & vkBA::Enter
vk1D & vkBB::Enter

; ----------------------------------
; Home/End/BS/Del
; ----------------------------------
vk1D & a::Home
vk1D & e::End
vk1D & n::BS
vk1D & m::Del

; ----------------------------------
; カーソル位置から行末まで削除
; ----------------------------------
vk1D & o::
  send {ShiftDown}{End}{ShiftUp}
  send ^c
  send {Del}
  return


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 変換キーをベースとしたショートカットキー割当
; ref: https://snowsystem.net/other/win
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

; 変換の単発押しはIME ON
vk1C::IME_SET(1)


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; かなキーをベースとしたショートカットキー割当
; ref: https://snowsystem.net/other/win
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

; かなキーの単発押しはIME ON
vkF2::IME_SET(1)


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ESCキーをベースとしたショートカットキー割当
; ref: https://snowsystem.net/other/win
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

; ESCの単発押しはIME OFF
~Esc::IME_SET(0)