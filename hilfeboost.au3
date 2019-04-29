Local $origin = MouseGetPos()
Local $pcount = InputBox("Anzahl Hilfe", "Wie oft willst Du Hilfe erfragen?", "120")
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

Func mouseclickat($arr)
	Local $xr = $xcoord + (($arr[0]/$xclicks)*$ws[0])
	Local $yr = $ycoord + (($arr[1]/$yclicks)*$ws[1])
	MouseClick("left", Int($xr), Int($yr), 1)
EndFunc
Local $verbess = [38,25]
Local $hilfe = [16,8]
Local $stop = [32,25]
Local $yes = [29,16]

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
WEnd
; Move back to the icon
MouseClick("left",$origin[0],$origin[1],1)

