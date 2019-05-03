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

$xcoord = $wp[0]
$ycoord = $wp[1]

; Compute the button offsets
$xoffset = $xcoord + (0.746 * $ws[0])

Local $yvars = [(587 / 667) * $ws[1],(502 / 667) * $ws[1],(414 / 667) * $ws[1],(324 / 667) * $ws[1],(245 / 667) * $ws[1],(159 / 667) * $ws[1]]
Local $run = 0
While $run < $runs
	MouseClick("left",$xoffset,    $ycoord + $yvars[0],1) ; 587
	MouseClick("left",$xoffset - 3,$ycoord + $yvars[1],1,2) ; 502
	MouseClick("left",$xoffset + 7,$ycoord + $yvars[2],1,2) ; 414
	MouseClick("left",$xoffset - 3,$ycoord + $yvars[3],1,2) ; 324
	MouseClick("left",$xoffset + 2,$ycoord + $yvars[4],1,2) ; 245
	MouseClick("left",$xoffset - 6,$ycoord + $yvars[5],1,2) ; 159
    $run = $run + 1
WEnd

; Move back to the icon
MouseClick("left",$origin[0],$origin[1],1)

