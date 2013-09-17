#include <ImageSearch.au3>
#include <GDIPlus.au3>

$fileRare = @ScriptDir & "\rare.png"
$fileMagic = @ScriptDir & "\magic.png"
$fileWhite = @ScriptDir & "\white.png"
$fileClarissa = @ScriptDir & "\clarissa.png"
$fileCancel = @ScriptDir & "\cancel.png"
$fileWP = @ScriptDir & "\wp.png"
$fileNew = @ScriptDir & "\new.png"


 
Func moveToVender()   
	MouseClick("primary", 22, 363, 3, 0)	
	Sleep(4000)
	MouseClick("primary", 22, 363, 3, 0)	
	Sleep(4000)
 EndFunc
 
Func talkToClarissa()
while 1

$hImageClarissa =_GDIPlus_ImageLoadFromFile($fileClarissa) ;this is clarissa
$hBitmapClarissa = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageClarissa)

$result4 = _ImageSearch($hBitmapClarissa, 1, $x, $y, 40, 0) 
If $result4 > 0 Then
	MouseClick("primary", $x, $y, 3, 0)	
	sleep(4000)
	ExitLoop
 EndIf

WEnd
	MouseClick("primary", 689, 179, 3, 0) ;click sell items
	sleep(2000)
EndFunc

 Func moveToWP()   
   Sleep(1000)
	MouseClick("primary", 1322, 414, 3, 0)	
	Sleep(4000)
	MouseClick("primary", 1322, 414, 3, 0)		
	Sleep(4000)	
	MouseClick("primary", 1322, 414, 3, 0)
   Sleep(1000)
	
   $hImageWP =_GDIPlus_ImageLoadFromFile($fileWP) ;this is WP
   $hBitmapWP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWP)

   $result6 = _ImageSearch($hBitmapWP, 1, $x, $y, 40, 0) 
   If $result6 > 0 Then
	   MouseClick("primary", $x, $y, 3, 0)	
	   sleep(4000)
	EndIf
	MouseClick("primary", 329, 119, 3, 0)		
	   sleep(1000)
  
   Send("{CTRLDOWN}")
	MouseClick("primary", 153, 400, 3, 0)	
	  Send("{CTRLUP}")
	   sleep(1000)
  
   $hImageNew =_GDIPlus_ImageLoadFromFile($fileNew) ;this is New
   $hBitmapNew = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageNew)
   

   $result7 = _ImageSearch($hBitmapNew, 1, $x, $y, 40, 0) 
	  Send("{TAB}")
	   MouseClick("primary", $x, $y, 3, 0)	
	   sleep(8000)   
EndFunc
 
 
moveToVender()
talkToClarissa()
sellLoop()
moveToWP()

func sellLoop()
;set up start selling spot
$posX = 0
$posY = 0
While 1
   $hImageRare =_GDIPlus_ImageLoadFromFile($fileRare) ;this is a Rare
   $hBitmapRare = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageRare)

   $hImageMagic =_GDIPlus_ImageLoadFromFile($fileMagic) ;this is a Magic
   $hBitmapMagic = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageMagic)

   $hImageWhite =_GDIPlus_ImageLoadFromFile($fileWhite) ;this is a White
   $hBitmapWhite = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWhite)

   $result = _ImageSearch($hBitmapRare, 1, $x, $y, 70, 0) 
   $result2 = _ImageSearch($hBitmapMagic, 1, $x, $y, 20, 0) 
   $result3 = _ImageSearch($hBitmapWhite, 1, $x, $y, 40, 0) 
   If $result > 0 or $result2 > 0 or $result3 > 0 Then
	  ;sell
	  Send("{CTRLDOWN}")
	  MouseClick ( "primary" )
	  Send("{CTRLUP}") ;Releases the CTRL key   
   EndIf

   if $posY > 4*40 Then
	  ExitLoop
   Else
	  if $posX > 11*40 Then
		 $posX = 0 
		 $posY = $posY + 40
	  EndIf
   EndIf

   MouseMove(928 + $posX, 480 + $posY,1)
   $posX = $posX + 40

WEnd


$hImageCancel =_GDIPlus_ImageLoadFromFile($fileCancel)
$hBitmapCancel = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageCancel)
$result = _ImageSearch($hBitmapCancel, 1, $x, $y, 50, 0) 
MouseClick("primary", $x, $y, 1, 0)	
EndFunc
