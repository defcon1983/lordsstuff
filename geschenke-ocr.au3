#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIFiles.au3>

Local $origin = MouseGetPos()

; Determine the window position coordinates
Local $wp = WinGetPos("BlueStacks","")
Local $xcoord = $wp[0]
Local $yover = 47 ; Static y overhead because the BlueStacks window frame does not scale on resize
Local $ycoord = $wp[1] + $yover

Local $origin = MouseGetPos()

; Compute the presents count location
Local $ws = WinGetClientSize("BlueStacks", "")
Local $ytotal = $ws[1] - ($yover * 2)
Local $xoffset = $xcoord + (0.46 * $ws[0])
Local $yoffset = $ycoord + (0.235 * $ytotal)
Local $xend = $xcoord + (0.7 * $ws[0])
Local $yend = $ycoord + (0.278 * $ytotal)

Local $ocr_filename = @DesktopDir & "\lordsmobile_presents_ocr"
Local $ocr_filename_and_ext = $ocr_filename & ".txt"
Local $ocr_image = $ocr_filename & "_bw.bmp"

Local $hScreenshot = _ScreenCapture_Capture ("",$xoffset, $yoffset, $xend, $yend)

_GDIPlus_Startup()
Local $hIA = _GDIPlus_ImageAttributesCreate()
Local $tColorMatrix = _GDIPlus_ColorMatrixCreateNegative()
_GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $tColorMatrix)
Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hScreenshot)
Local $iW = _GDIPlus_ImageGetWidth($hBitmap)
Local $iH = _GDIPlus_ImageGetHeight($hBitmap)
Local $hBMP_2bpp = _GDIPlus_BitmapCloneArea($hBitmap, 0 ,0 , $iW, $iH, $GDIP_PXF01INDEXED)
Local $hGraphics = _GDIPlus_ImageGetGraphicsContext($hBMP_2bpp)
_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hBitmap, 0, 0, $iW, $iH, 0, 0, $iW, $iH, $hIA)
_GDIPlus_ImageSaveToFile($hBMP_2bpp, $ocr_image)
_GDIPlus_BitmapDispose($hBitmap)
_GDIPlus_BitmapDispose($hBMP_2bpp)
_GDIPlus_ShutDown()

Local $iPID = Run(@ComSpec & " /C " & "tesseract.exe """ & $ocr_image & """ """ & $ocr_filename & """", @ProgramFilesDir & "\Tesseract-OCR", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($iPID)

FileDelete($ocr_image)
Local $string= FileReadLine($ocr_filename_and_ext,1)
Local $runs = StringSplit($string, " /")[2] / 5
FileDelete($ocr_filename_and_ext)

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

Local $g5 = [0.7849,0.9588]
Local $g4 = [0.7849,0.8028]
Local $g3 = [0.7849,0.6461]
Local $g2 = [0.7849,0.5035]
Local $g1 = [0.7849,0.3468]
Local $gd = [0.7701,0.1989]

; Clicks at a specified relative BlueStacks coordinate
Func mouseclickat($arr, $speed)
	Local $p = GetPlayArea()
	MouseClick("left", $p[0] + Int($arr[0] * $p[4]), $p[1] + Int($arr[1] * $p[5]), 1, $speed)
EndFunc

Local $run = 0
While $run < $runs
	mouseclickat($g5, 10)
	mouseclickat($g4, 2)
	mouseclickat($g3, 2)
	mouseclickat($g2, 2)
	mouseclickat($g1, 2)
	mouseclickat($gd, 2)
    $run = $run + 1
WEnd

; Move back to the icon
MouseClick("left",$origin[0],$origin[1],1)

