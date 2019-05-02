#include <GUIConstants.au3>

Dim $dbg
GuiCreate ("",500,75,0,0,$WS_POPUP+$WS_EX_TOPMOST)
GuiSetState (@SW_SHOW)
Local $dbgLabel = GuiCtrlCreateLabel ("Hilfe-Boost -- ESC: Exit",10,10, 500, 200)
Func Debug($dbg)
     GuiCtrlSetData($dbgLabel, $dbg)
EndFunc

HotKeySet("{Esc}", "Bye")

Func Bye()
	Exit
EndFunc

Local $origin = MouseGetPos()
Local $pcount = InputBox("Anzahl Hilfe", "Wie oft willst Du Hilfe erfragen?", "120")
Debug("Hilfe-Boost: " & $pcount & " Runden")
MsgBox(0, "Hilfe-Boost", "Bewege die Maus über das Gebäude, dann drück Enter")
Local $building = MouseGetPos()

; Determine the window position coordinates
Local $wp = WinGetPos("BlueStacks","")
Local $xcoord = $wp[0]
Local $ycoord = $wp[1]


; Setup for grid match
Local $ws = WinGetClientSize("BlueStacks", "")

Local $xclicks = 50
Local $yclicks = 30

; Returns absolute coordinates of the BlueStacks play area as an array
; Values: [x-start y-start x-end y-end width height]
Func GetPlayArea()
	Local $play_area = ControlGetPos(WinGetHandle("BlueStacks"), "", "_ctl.Window")
	Local $window_position = WinGetPos("BlueStacks","")
	Local $width = $play_area[2]
	Local $height = $play_area[3]
	; Compute absolute coordinates
	Local $xs = $window_position[0] + $play_area[0]
	Local $xe = $xs + $width
	Local $ys = $window_position[1] + $play_area[1]
	Local $ye = $ys + $height
	Local $result = [$xs, $ys, $xe, $ye, $width, $height]
	Return $result
EndFunc

Local $verbess = [0.757,0.901]
Local $hilfe = [0.306,0.253]
Local $stop = [0.653,0.886]
Local $yes = [0.575,0.532]

; Clicks at a specified relative BlueStacks coordinate
Func mouseclickat($arr)
	Local $p = GetPlayArea()
	Debug("Click " & Int($arr[0] * $p[4]) & " " & Int($arr[1] * $p[5]))
	MouseClick("left", $p[0] + Int($arr[0] * $p[4]), $p[1] + Int($arr[1] * $p[5]), 1)
EndFunc

Local $run = 0
While $run < $pcount
	MouseClick("left",$building[0],$building[1],1)
	Sleep(200)
	mouseclickat($verbess)
	Sleep(200)
	mouseclickat($verbess)
	Sleep(200)
	mouseclickat($hilfe)
	Sleep(3000)
	MouseClick("left",$building[0],$building[1],1)
	Sleep(300)
	mouseclickat($stop)
	Sleep(300)
	mouseclickat($yes)
	Sleep(900)
	$run = $run + 1
	Local $suff = ""
	If ($pcount - $run) <> 1 Then
		$suff = "n"
	EndIf
	Debug("Noch " & ($pcount - $run) & " Runde" & $suff & "...")
WEnd
Debug("Fertig!")
; Move back to the icon
MouseClick("left",$origin[0],$origin[1],1)

