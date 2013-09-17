#include <ImageSearch.au3>
#include <GDIPlus.au3>
#include <log.au3>
$fileWP = @ScriptDir & "\miniWP.png"
_GDIPlus_Startup()	
$x = 0
$y = 0
 
$fileStash1 = @ScriptDir & "\manaTown.png"


   $hImageStash1 =_GDIPlus_ImageLoadFromFile($fileStash1) ;this is the WP on the minimap
   $hBitmapStash1 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageStash1)

   $x = 0
   $y = 0
   $result1 = _ImageSearch($hBitmapStash1,  1, $x, $y, 20, 0) ;
   sleep(100)
   
   If $result1 > 0 Then
	  MouseClick("primary", 650, 200)
   EndIf
   ;check Stash Here