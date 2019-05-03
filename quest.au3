; Determine the window position coordinates
Local $wp = WinGetPos("BlueStacks","")
Local $xcoord = $wp[0]
Local $ycoord = $wp[1]

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
Local $m5 = [0.78,0.393]
; Clicks at a specified relative BlueStacks coordinate
Func mouseclickat($arr)
	Local $p = GetPlayArea()
	MouseClick("left", $p[0] + Int($arr[0] * $p[4]), $p[1] + Int($arr[1] * $p[5]), 1, 2)
EndFunc

Local $origin = MouseGetPos()

Local $wt = 1000
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
Sleep($wt)
mouseclickat($m5)
; Move back to the icon
MouseClick("left",$origin[0],$origin[1],1)

;1032 667
