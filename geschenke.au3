Local $pcount = InputBox("Geschenke", "Wieviele Geschenke?")
; Determine the window position coordinates
Local $wp = WinGetPos("BlueStacks","")
Local $xcoord = $wp[0]
Local $ycoord = $wp[1]

Local $origin = MouseGetPos()

; Compute the button offsets
Local $ws = WinGetClientSize("BlueStacks", "")
Local $xoffset = $xcoord + (0.746 * $ws[0])

Local $yvars = [(587 / 667) * $ws[1],(502 / 667) * $ws[1],(414 / 667) * $ws[1],(324 / 667) * $ws[1],(245 / 667) * $ws[1],(159 / 667) * $ws[1]]

Local $runs = ($pcount / 5)
Local $run = 0
While $run < $runs
	MouseClick("left",$xoffset,    $ycoord + $yvars[0],1) ; 587
	MouseClick("left",$xoffset - 3,$ycoord + $yvars[1],1) ; 502
	MouseClick("left",$xoffset + 7,$ycoord + $yvars[2],1) ; 414
	MouseClick("left",$xoffset - 3,$ycoord + $yvars[3],1) ; 324
	MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
	MouseClick("left",$xoffset - 6,$ycoord + $yvars[5],1) ; 159
    $run = $run + 1
WEnd
; Move back to the icon
MouseClick("left",$origin[0],$origin[1],1)

