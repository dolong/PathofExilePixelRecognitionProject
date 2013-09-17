#include <ImageSearch.au3>
#include <GDIPlus.au3>
#include <log.au3>

itemSearch()

func itemSearch()  
   
$STIMER = TimerInit()
$STIMEOUT = 3000

while 1
   if TimerDiff($STIMER) >=($STIMEOUT) Then
	  ExitLoop
   EndIf
   
   ;dbdb67 8b826b
$PixelLoc = PixelSearch(0, 0, @DesktopWidth, @DesktopHeight, 0x9b5521) ;unique
If IsArray($PixelLoc) = True Then
MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
   Else
   $PixelLoc = PixelSearch(0, 0, @DesktopWidth, @DesktopHeight, 0x965220) ; unique #2
   If IsArray($PixelLoc) = True Then
   MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
   Else
	  $PixelLoc = PixelSearch(0, 0, @DesktopWidth, @DesktopHeight, 0x988d74) ;orbs
	  If IsArray($PixelLoc) = True Then
		MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
	  Else
	  $PixelLoc = PixelSearch(0, 0, @DesktopWidth, @DesktopHeight, 0xe1e26a) ;rares
		If IsArray($PixelLoc) = True Then
		  MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
		Else
		  $PixelLoc = PixelSearch(0, 0, @DesktopWidth, @DesktopHeight, 0x87979e3) ;magic
			If IsArray($PixelLoc) = True Then			   
			MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
			EndIf
		 EndIf
	  EndIf
   EndIf
EndIf
WEnd
EndFunc