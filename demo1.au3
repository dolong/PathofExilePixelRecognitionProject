;$date = "Log_" & @MON & "_" & @MDAY & "_" & @HOUR & "_" & @MIN
;MsgBox(64, "", $date)
#include <GDIPlus.au3>
#include <imagesearch.au3>
_GDIPlus_Startup()	

$x=0
$y=0
;$fileTown1 = @ScriptDir & "\manaTown.png"
$fileTown1 = @ScriptDir & "\w1.png"
   
   $hImageTown1 =_GDIPlus_ImageLoadFromFile($fileTown1) ;this is a Town
   $hBitmapTown1 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageTown1)
   
	  $checkTown1  = _ImageSearch($hBitmapTown1, 1, $x, $y, 20, 0) 
	  if $checkTown1 > 0 Then
		 MsgBox(0, "In Town", "Yes")
	  Else
		 MsgBox(0, "In Town", "No")
	  EndIf	
	  
_GDIPlus_ImageDispose($hImageTown1)

 $hImageTown1 =_GDIPlus_ImageLoadFromFile($fileTown1) ;this is a Town
   $hBitmapTown1 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageTown1)
   
	  $checkTown1  = _ImageSearch($hBitmapTown1, 1, $x, $y, 20, 0) 
	  if $checkTown1 > 0 Then
		 ;MsgBox(0, "In Town", "Yes")
_GDIPlus_ImageDispose($hImageTown1)
		 return True
	  Else
		 ;MsgBox(0, "In Town", "No")
_GDIPlus_ImageDispose($hImageTown1)
		 return False
	  EndIf	