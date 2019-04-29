; Determine the window position coordinates
Local $wp = WinGetPos("BlueStacks","")
Local $xcoord = $wp[0]
Local $ycoord = $wp[1]

Local $origin = MouseGetPos()

; Compute the button offsets
Local $ws = WinGetClientSize("BlueStacks", "")
Local $xoffset = $xcoord + (0.746 * $ws[0])

Local $yvars = [(587 / 667) * $ws[1],(502 / 667) * $ws[1],(414 / 667) * $ws[1],(324 / 667) * $ws[1],(270 / 667) * $ws[1]]
Local $wt = 1200
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
Sleep($wt)
MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1) ; 245
; Move back to the icon
MouseClick("left",$origin[0],$origin[1],1)

;1032 667