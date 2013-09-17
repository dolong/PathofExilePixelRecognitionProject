#include <ImageSearch.au3>
#include <GDIPlus.au3>
#include <log.au3>

$fileA = @ScriptDir & "\chest2.png"
$fileB = @ScriptDir & "\chest.png"
$fileC = @ScriptDir & "\door.png"
$file1 = @ScriptDir & "\orb.png"
$file2 = @ScriptDir & "\gem.png"
$fileScrollInv = @ScriptDir & "\ScrollInv.png"
$fileTransOrb = @ScriptDir & "\trans.png"
$fileChisel = @ScriptDir & "\chisel.png"
$filePortal = @ScriptDir & "\portal.png"
$fileWorldMap = @ScriptDir & "\world.png"

local $portalTowns = 0   
;town

$fileRare = @ScriptDir & "\rare.png"
$fileMagic = @ScriptDir & "\magic.png"
$fileMagic2 = @ScriptDir & "\magic2.png"
$fileWhite = @ScriptDir & "\white.png"
$fileWhite2 = @ScriptDir & "\white2.png"
$fileWhite3 = @ScriptDir & "\white3.png"
$fileClarissa = @ScriptDir & "\clarissa.png"
$fileAccept = @ScriptDir & "\accept.png"
$fileWP = @ScriptDir & "\wp.png"
$fileNew = @ScriptDir & "\new.png"
$fileTown = @ScriptDir & "\manaTown.png"
$fileTown1 = @ScriptDir & "\w1.png"
   
$fileStash1 = @ScriptDir & "\stash1.png"
$fileStash2 = @ScriptDir & "\stash2.png"
$fileStash3 = @ScriptDir & "\stash3.png"
;minimap
$fileWPmini = @ScriptDir & "\miniWP.png"

_GDIPlus_Startup()    


$itemFinding = 0
$opened = 0 ;opened chest
$x = 0
$y = 0
$xS = 0
$yS = 0
$timed = 0
   ;item iteration
Local $skip = 0

   
;for run count
Local $run = 0
Local $completedRuns = 0
local $chest1  = 0
local $chest2 = 0
local $doorNearby = 0
local $x = 0
local $y = 0
local $townRuns = 1
local $i = 5
Global $speedPot = 0


Global $Paused
HotKeySet("{HOME}", "TogglePause")
HotKeySet("{F7}", "ToggleExit")

Func moveToVender()
   writeLog("Moving to Vender")
	MouseClick("primary", 22, 433, 3, 0)	
	Sleep(4000)
	MouseClick("primary", 22, 433, 3, 0)	
	Sleep(4000)
 EndFunc
 
Func talkToClarissa()
   writeLog("Talking to Clarissa")
while 1


$hImageClarissa =_GDIPlus_ImageLoadFromFile($fileClarissa) ;this is clarissa
$hBitmapClarissa = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageClarissa)
$clarissaNearby = _ImageSearch($hBitmapClarissa, 1, $x, $y, 40, 0) 
If $clarissaNearby > 0 Then
	MouseClick("primary", $x, $y, 3, 0)	
	sleep(4000)
	ExitLoop
 else 
	writeLog("Can't find Clarissa")
	correctWPMove()
	sleep(2000)
	correctWPMove()
	sleep(2000)
	correctWPMove()
	sleep(2000)
	correctWPMove()
	sleep(2000)
   if checkIsInTown() Then ;case of stepping on portal
	  moveToVender()
   Else
	  Send("{SPACE}")
	  moveToVender()
   EndIf
   sleep(1000)
 endif
WEnd
	;MouseClick("primary", 689, 179, 1, 0) ;click sell items
	;sleep(2000)
   ;MouseMove(698, 423,1)
   _GDIPlus_ImageDispose($hImageClarissa)
   
EndFunc   

 Func moveToWP()   
   writeLog("Moving to Waypoint")
   Sleep(500)
	MouseClick("primary", 1322, 414, 3, 0)	
	Sleep(4000)
	MouseClick("primary", 1322, 414, 3, 0)		
	Sleep(4000)	
	MouseClick("primary", 1322, 414, 3, 0)
   Sleep(5000)
 EndFunc
 
 func correctWPMove()
   if checkLocation() = False Then
	  portalTown()
   EndIf   
   Send("{TAB}")
   ;correcting WP path
   sleep(500)
   $x = 0
   $y = 0
   $hImageWPmini =_GDIPlus_ImageLoadFromFile($fileWPmini) ;this is the WP on the minimap
   $hBitmapWPmini = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWPmini)


   $result = _ImageSearchArea($hBitmapWPmini, 1,  0, 0, 1400, 800, $x, $y, 40, 0) ;Zero will search against your active screen
   If $x = 801 Then
	  MouseClick("primary", 650, 200)
	  $result = _ImageSearchArea($hBitmapWPmini, 1,  0, 0, 1400, 800, $x, $y, 40, 0) ;Zero will search against your active screen
   EndIf
   sleep(100)
   If $result > 0 Then
	  ;writeLog("found moving")
	  MouseMove($x, $y)
	  MouseDown ("left")
	  sleep(1500)
	  MouseUp("left")
   ElseIf $result = 0 Then
	 ; writeLog("not found moving")
	  MouseClick("primary", 648, 383, 3, 0)
   EndIf
   sleep(500)
   Send("{SPACE}")
   
_GDIPlus_ImageDispose($hImageWPmini)

EndFunc	
func WPtoBattle()   
	  $hImageNew =_GDIPlus_ImageLoadFromFile($fileNew) ;this is New Instance button
	  $hBitmapNew = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageNew)
	  
	writeLog("Warping to Map")
	;In case of stepping on portal
	If checkLocation() = False Then
		 Send("{SPACE}")
		 sleep(400)
		 Send("{TAB}")
    Else   
	  ;Town images
	  $hImageWP =_GDIPlus_ImageLoadFromFile($fileWP) ;this is WP
	  $hBitmapWP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWP) 
	  $waypointImage = _ImageSearch($hBitmapWP, 1, $x, $y, 40, 0) 
		  ;MouseMove($x, $y)
		  sleep(200)
		  
		 
		 
	  If $waypointImage > 0 Then
		  MouseClick("primary", $x, $y, 3, 0)
		  MouseClick("primary", $x, $y, 3, 0)		
		  sleep(4000)
	  Else
		 If $waypointImage = 0 Then
			   sleep(3000)
			   if checkLocation() = True Then
				   MouseClick("primary", 1322, 414, 3, 0)	
				   sleep(1000)
				   correctWPMove()
				   
				  MouseClick("primary", 1322, 414, 3, 0)	
				   ;moveToWP()   
				   ;MouseClick("primary",648, 473,3, 0) 
				   ;sleep(300)
				   ;MouseClick("primary",648, 473,3, 0) 
				   sleep(300)
				   ;MouseClick("primary",648, 473,3, 0) 
			   else
				   Send("{SPACE}")
				  sleep(400)
				  Send("{TAB}")
				   portalTown()
				   moveToVender()
				   talkToClarissa()
				   moveToWP()   	
				   Send("{TAB}")
			   endif
   EndIf
	  sleep(1000)			    
	  WPtoBattle()
	  Sleep(500)
   EndIf
   
   
   $hImageWorldMap =_GDIPlus_ImageLoadFromFile($fileWorldMap) ;this is WP
   $hBitmapWorldMap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWorldMap) 
   $WorldMapImage = _ImageSearch($hBitmapWorldMap, 1, $x, $y, 40, 0) 
   If $WorldMapImage > 0 Then		  
	  ;Click Merciles
	   MouseClick("primary", 329, 119, 3, 0)		
		  sleep(1000)
	  ;click act 1
	   MouseClick("primary", 190, 143, 3, 0)		
		  sleep(1000)
		  
	  Send("{CTRLDOWN}")
	   MouseClick("primary", 153, 400, 3, 0)	
		 Send("{CTRLUP}")
		  sleep(1000)
	 
	  



		 $newButton = _ImageSearch($hBitmapNew, 1, $x, $y, 40, 0) 
		  MouseClick("primary", $x, $y, 3, 0)	
		  sleep(6000)   
		 Send("{TAB}")
		 writeLog("Warped to Map")
		 $run = $run + 1  
		 If $run = 26 Then
			writeLog("Restarting Program")
			_SelfRestart()
		 EndIf
		 $TIMER = TimerInit()
		 writeLog("Starting Run: " & $run & " timer cleared: " & TimerDiff($TIMER))
		 if checkLocation() = True Then
			writeLog("Error: Didn't Warp to Map")
			Send("{TAB}")		 
			talkToClarissa()
			moveToWP()   
			;MouseClick("primary", 1322, 514, 3, 0)	
			Sleep(4000)
			WPtoBattle()
		 EndIf
	  Else
		 WPtoBattle()
	  EndIf
   _GDIPlus_ImageDispose($hImageNew)
   _GDIPlus_ImageDispose($hImageWP)
   _GDIPlus_ImageDispose($hImageWorldMap)
   EndIf
EndFunc	
 
func checkRarity()

$x = 0
$y = 0
$xS = 0
$yS = 0
  
;Store Images
$hImageRare =_GDIPlus_ImageLoadFromFile($fileRare) ;this is a Rare
$hBitmapRare = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageRare)

$hImageMagic =_GDIPlus_ImageLoadFromFile($fileMagic) ;this is a Magic
$hBitmapMagic = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageMagic)

$hImageMagic2 =_GDIPlus_ImageLoadFromFile($fileMagic2) ;this is a Magic
$hBitmapMagic2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageMagic2)
   
$hImageWhite =_GDIPlus_ImageLoadFromFile($fileWhite) ;this is a White
$hBitmapWhite = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWhite)

$hImageWhite2 =_GDIPlus_ImageLoadFromFile($fileWhite2) ;this is a White
$hBitmapWhite2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWhite2)

$hImageWhite3 =_GDIPlus_ImageLoadFromFile($fileWhite3) ;this is a White
$hBitmapWhite3 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageWhite3)

$hImageTransOrb =_GDIPlus_ImageLoadFromFile($fileTransOrb) ;this is a transOrb
$hBitmapTransOrb = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageTransOrb)

$hImageScrollInv =_GDIPlus_ImageLoadFromFile($fileScrollInv) ;this is the firefox icon use something else if you don't have it.
$hBitmapScrollInv = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageScrollInv)


; If $scroll > 0 Then
; MouseMove($xS, $yS)
; EndIf
 
;MsgBox(0, "Mouse x,y:", $pos[0] & "," & $pos[1])

	  $rare  = _ImageSearch($hBitmapRare, 1, $xS, $yS, 20, 0) 
	  If $rare  > 0 Then
		 $scroll = _ImageSearchArea($hBitmapScrollInv, 1,800, 400, 1300, 800, $xS, $yS, 20, 0) ;Zero will search against your active screen
		 ;$scroll = _ImageSearch($hBitmapScrollInv, 1, $xS, $yS, 20, 0) ;
		 ;sell
		 if $scroll > 0 Then	
			   Local $pos = MouseGetPos()
				  ;MouseMove($xS, $yS)
				  MouseMove($xS-2,$yS)
				  sleep(700)
				  MouseClick("secondary", $xS-2, $yS, 3, 0)
				  sleep(700)
				  MouseClick( "primary",$pos[0],$pos[1],3,0 )
			   sleep(1000)
		 else			   	
			   ;$xS = 918
			   ;$yS = 483
			   Local $pos = MouseGetPos()
			   MouseMove(500,500)
			   $xS = 0
			   $yS = 0
			   
			   sleep(500)
			   $hImageScrollInv =_GDIPlus_ImageLoadFromFile($fileScrollInv) ;this is the firefox icon use something else if you don't have it.
			   $hBitmapScrollInv = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageScrollInv)

			   $scroll = _ImageSearchArea($hBitmapScrollInv, 1, 800, 400, 1300, 800, $xS, $yS, 20, 0) ;Zero will search against your active screen
			   If $scroll >0 Then
				  sleep(500)
				  MouseMove($xS,$yS)
				  sleep(1000)
				  MouseClick("secondary", $xS-2, $yS, 3, 0)	
				  sleep(700)		 				  
				  MouseClick( "primary",$pos[0],$pos[1],3,0 )
				  sleep(1000)
			   EndIf
		 endif 
		 Send("{CTRLDOWN}")
		 MouseClick ( "primary" )
		 Send("{CTRLUP}") 
	  EndIf
	  
	  $magic1 = _ImageSearch($hBitmapMagic, 1, $x, $y, 20, 0) 
	  if $magic1 > 0 Then
		 ;sell
		 Send("{CTRLDOWN}")
		 MouseClick ( "primary" )
		 Send("{CTRLUP}") 
	  EndIf  
	  
	 $magic2 = _ImageSearch($hBitmapMagic2, 1, $x, $y, 20, 0) 	
	  if $magic2 > 0 Then
		;sell
		 Send("{CTRLDOWN}")
		 MouseClick ( "primary" )
		 Send("{CTRLUP}") 
	  EndIf 
	  
	  $white = _ImageSearch($hBitmapWhite, 1, $x, $y, 20, 0) 
	  if $white > 0 Then
		 ;sell
		 Send("{CTRLDOWN}")
		 MouseClick ( "primary" )
		 Send("{CTRLUP}") 
	  EndIf
  
	  $white2 = _ImageSearch($hBitmapWhite2, 1, $x, $y, 20, 0) 
	  if $white2 > 0 Then
		 ;sell
		 Send("{CTRLDOWN}")
		 MouseClick ( "primary" )
		 Send("{CTRLUP}") 
	  EndIf
	  
	  $white3 = _ImageSearch($hBitmapWhite3, 1, $x, $y, 20, 0) 
	  if $white3 > 0 Then
		 ;sell
		 Send("{CTRLDOWN}")
		 MouseClick ( "primary" )
		 Send("{CTRLUP}") 
	  EndIf
	  ;Sells TransOrbs. Delete this if you don't want to sell trans orbs
	  $transOrb = _ImageSearch($hBitmapTransOrb, 1, $x, $y, 20, 0) 
	  if $transOrb > 0 Then
		 ;sell
		 Send("{CTRLDOWN}")
		 MouseClick ( "primary" )
		 Send("{CTRLUP}") 
	  EndIf
  
_GDIPlus_ImageDispose($hImageScrollInv)
_GDIPlus_ImageDispose($hImageRare)
_GDIPlus_ImageDispose($hImageMagic)
_GDIPlus_ImageDispose($hImageMagic2)
_GDIPlus_ImageDispose($hImageWhite)
_GDIPlus_ImageDispose($hImageWhite2)
_GDIPlus_ImageDispose($hImageTransOrb)
	  EndFunc
	  
func sellLoop()   
;Skip odd rows
if $skip = 2 Then
	  $skip = 0
EndIf
   MouseClick("primary", 689, 179, 1, 0) ;click sell items
   MouseMove(698, 423,1)
   writeLog("Selling Items")
;set up start selling spot
$posX = 0
$posY = 0 + $skip * 40
While 1
   checkRarity()
   if $posY > 4*40 Then
	  ExitLoop
   Else
	  if $posX > 11*40 Then
		 $posX = 0 
		 $posY = $posY + (40 * 2)
	  EndIf
   EndIf

   MouseMove(928 + $posX, 480 + $posY,3)
   $posX = $posX + 40
WEnd
$skip = $skip + 1

$hImageAccept =_GDIPlus_ImageLoadFromFile($fileAccept)
$hBitmapAccept = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageAccept)
$Accept  = _ImageSearch($hBitmapAccept, 1, $x, $y, 50, 0) 
MouseClick("primary", $x, $y)	
_GDIPlus_ImageDispose($hImageAccept)
EndFunc

   ;Getting Gem
func GemSearch()
   writeLog("Picking up Gem")
	MouseClick("primary", $x, $y, 3, 0)	
	Sleep(1000)
	itemSearch()
 EndFunc
 
Func OrbSearch()   
   writeLog("Picking up Orb")
	MouseClick("primary", $x, $y, 3, 0)	
	Sleep(3000)
	itemSearch()
 EndFunc
 
 Func chiselSearch()   
   writeLog("Picking up Chisel")
	MouseClick("primary", $x, $y, 3, 0)	
	Sleep(3000)
	itemSearch()
 EndFunc
 
 Func doorSearch()	
   writeLog("Found End of Map")
   $searchTime = -10
   $timed = -20
   $x = 0
   $y = 0
   ;MouseClick("primary", 300, 639, 3, 0)	
   itemSearchLong()
   sleep(300)
   ;Summon a zombie hillock at end of map - So that zombie count stays high
   Send("{SHIFTDOWN}")
   Send("w")
   Send("{SHIFTUP}")
EndFunc

 func portalTown()	
   writeLog("Portalling to town")
   Sleep(1000)
   Send("{q}")
   Sleep(4000)
   MouseClick("primary", 700, 339, 3, 0)	
   Sleep(6000)
	   
   $completedRuns = $completedRuns + 1	 	
   writeLog("Completed Run" & $completedRuns & " in " & (TimerDiff($TIMER)/1000))
	  
   $TIMER = TimerInit()
   local $portalTowns = 0
   checkIfPortaledTown()
   ;On error
EndFunc
   
   ;checks if portal brought to town, else portal sto town
func checkIfPortaledTown()	  
if	$portalTowns < 6 then
   If Not checkIsInTown()  Then	  
	  writeLog("Portal Error, Resetting Portal." & checkIsInTown() & $portalTowns)
	  MouseClick("primary",648, 473,3, 0) 
	  Sleep(1000)
	  Send("{q}")  
	  Sleep(5500)
	  MouseClick("primary", 700, 339, 3, 0)	
	  Sleep(5500)	  
	  $portalTowns = $portalTowns + 1
	  checkIfPortaledTown()
   EndIf
Else
   WPtoBattle()
_SelfRestart()   
  endif	
EndFunc
 
Func _SelfRestart() ; restart the app
    ;Local $iMsgBoxAnswer = MsgBox(308, "Restarting...", "Are you sure you want to restart?")
    ;If $iMsgBoxAnswer <> 6 Then Return ; Not Yes so return
    If @Compiled Then
        Run(FileGetShortName(@ScriptFullPath))
    Else
        Run(FileGetShortName(@AutoItExe) & " " & FileGetShortName(@ScriptFullPath))
    EndIf
    Exit
 EndFunc 
 
func checkIsInTown()
   
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
	  

endfunc	

func checkIsInMap()
if checkLocation() = False then
   return True
else 
   return False
EndIf
endfunc	

func inTown()
   ;relocate the MouseClick
   writeLog("Relocated to town")  
   if checkLocation() = False Then
	  writeLog("Error didn't relocate to town")    	
	  Send("{TAB}") ;restarts end of map scenario
	  Exit ;restarts end of map scenario
   EndIf	  
   
   MouseMove(50, 50)	   
 
   Send("{SPACE}")	    ;Turns off map when in town
   
   MouseMove(0,0)
   moveToVender()
		
   if checkLocation() = False Then ;in case of stepping on portal while moving to vender			
	  Send("{TAB}") ;restarts end of map scenario
	  Exit ;restarts end of map scenario as a fix
   EndIf
		 
   talkToClarissa() 
   sellLoop()
   
   if Mod($townRuns, 15) = 0 then
   talkToClarissa() 
	  stash()
   EndIf
   moveToWP()		
   if checkLocation() = False Then ;stepping on portal bug while moving to portal	
	  portalTown() ;goes back to town
   EndIf
   WPtoBattle()	  
   $townRuns = $townRuns + 1
   
EndFunc
   
func goBackToMap()	
   MouseMove(1322, 414)	 
   MouseClick("primary", 1322, 414, 3, 0)	
   sleep(2000)
   WPtoBattle()
EndFunc
func stash()	
	
   MouseMove(1200, 300, 3)
   MouseDown ("left")
   sleep(400)
   MouseUp("left")
   sleep(2000)
   $hImageStash1 =_GDIPlus_ImageLoadFromFile($fileStash1) ;this is the WP on the minimap
   $hBitmapStash1 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageStash1)

   $hImageStash2 =_GDIPlus_ImageLoadFromFile($fileStash2) ;this is the WP on the minimap
   $hBitmapStash2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageStash2)

   $hImageStash3 =_GDIPlus_ImageLoadFromFile($fileStash3) ;this is the WP on the minimap
   $hBitmapStash3 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageStash3)

   $x = 0
   $y = 0

   $result1 = _ImageSearchArea($hBitmapStash1, 1,  0, 0, 1400, 800, $x, $y, 40, 0) ;Zero will search against your active screen
   $result2 = _ImageSearchArea($hBitmapStash2, 1,  0, 0, 1400, 800, $x, $y, 40, 0)
   $result3 = _ImageSearchArea($hBitmapStash3, 1,  0, 0, 1400, 800, $x, $y, 40, 0)
   sleep(1000)
   
   If $result1 > 0 Then
	MouseClick("primary", $x, $y, 3, 0)	
   Else	
	  If $result2 > 0 Then
		 MouseClick("primary", $x, $y, 3, 0)	
	  Else	  
		 If $result3> 0 Then
		 MouseClick("primary", $x, $y, 3, 0)	
		 EndIf
	  EndIf
   EndIf
   ;check Stash Here
   
   
   sleep(3000)
   MouseClick("primary",220,140,3,0)
   sleep(1000)
   MouseMove(928 + 40, 480)
   writeLog("Stashing Items")
   ;set up start selling spot
   $posX = 40
   $posY = 0 
   Send("{CTRLDOWN}")
   While 1
	  if $posY > 4*40 Then
		 ExitLoop
	  Else
		 MouseClick("primary")
		 if $posX > 11*40 Then
			$posX = 0 
			$posY = $posY + (40)
		 EndIf
	  EndIf
	  MouseMove(928 + $posX, 480 + $posY,3)
	  $posX = $posX + 40
   WEnd
   Send("{CTRLUP}")
   sleep(500)
   Send("{ESC}")
   
   mousemove(780,640)   
   MouseClick("primary",780,640,3,0)
   _GDIPlus_ImageDispose($hImageStash1)
   _GDIPlus_ImageDispose($hImageStash2)
   _GDIPlus_ImageDispose($hImageStash3)
EndFunc
	  	  
 func chestSearch()	
   writeLog("Found Chest")
	MouseClick("primary", $x, $y, 3, 0)	
	Sleep(2000)	
   $hImageChest1 =_GDIPlus_ImageLoadFromFile($fileA) ;this is a chest
   $hBitmapChest1 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageChest1)

	$chest1  = _ImageSearch($hBitmapChest1, 1, $x, $y, 20, 0)
	if $chest1  > 0 then 
	  MouseClick("primary", $x, $y, 3, 0)	
	  sleep(1000)
   EndIf
   
   sleep(600)
   $hImageChest2 =_GDIPlus_ImageLoadFromFile($fileB) ;this is a chest2
   $hBitmapChest2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageChest2)
	$chest1  = _ImageSearch($hBitmapChest2, 1, $x, $y, 20, 0)
	if $chest1  > 0 then 
	  
	  MouseClick("primary", $x, $y, 3, 0)	
	  sleep(1000)
   EndIf
	itemSearch()
	Sleep(1000)
	
	
_GDIPlus_ImageDispose($hImageChest1)
_GDIPlus_ImageDispose($hImageChest2)
 EndFunc
 


Local $STIMER = TimerInit()
Local $STIMEOUT = 2500; 2.5 seconds	  

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
	  $PixelLoc = PixelSearch(0, 0, @DesktopWidth, @DesktopHeight, 0xe1e26a, 100) ;rares
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

func itemSearchLong()  
   
$STIMER = TimerInit()
$STIMEOUT = 5000

while 1
   if TimerDiff($STIMER) >=($STIMEOUT) Then
	  ExitLoop
   EndIf
   
   ;dbdb67 8b826b
$PixelLoc = PixelSearch(0, 150, @DesktopWidth, @DesktopHeight, 0x9b5521) ;unique
If IsArray($PixelLoc) = True Then
MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
   Else
   $PixelLoc = PixelSearch(0, 150, @DesktopWidth, @DesktopHeight, 0x965220) ; unique #2
   If IsArray($PixelLoc) = True Then
   MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
	  Else
	  $PixelLoc = PixelSearch(0, 150, @DesktopWidth, @DesktopHeight, 0xe7e169) ; e7e169 unique #2
	  If IsArray($PixelLoc) = True Then
	  MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)   
		 Else
		 $PixelLoc = PixelSearch(0, 150, @DesktopWidth, @DesktopHeight, 0x988d74) ;orbs
		 If IsArray($PixelLoc) = True Then
		   MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
		 Else
		 $PixelLoc = PixelSearch(0, 150, @DesktopWidth, @DesktopHeight, 0xe1e26a) ;rares
		   If IsArray($PixelLoc) = True Then
			 MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
		  Else
			 $PixelLoc = PixelSearch(0, 150, @DesktopWidth, @DesktopHeight-200, 0x18948e) ;gem
			If IsArray($PixelLoc) = True Then			   
			MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
			Else			
			 $PixelLoc = PixelSearch(0, 150, @DesktopWidth, @DesktopHeight-200, 0x87979e3) ;magic
			   If IsArray($PixelLoc) = True Then			   
			   MouseClick("primary", $PixelLoc[0], $PixelLoc[1], 3, 0)
			   EndIf
			EndIf
		 EndIf
	  EndIf
   EndIf
EndIf
EndIf
WEnd
EndFunc


func nearWater()
   
Local $water = PixelSearch(740, 450, 745, 460, 0x486468, 7)

If ( @error ) Then   
   ;MsgBox(0,"Your mouse pointer coordinate is:", $water)
   ;Local $deepinwater = PixelSearch(665, 400, 675, 415, 0x486468, 7)   
  ; If Not( @error ) Then
	 MouseClick("primary",700+150, 350+150,3, 0)   
   ;Else
	;  return True
   ;EndIf
Else
   Return True
EndIf
   

EndFunc

func deepWater()

Local $deepinwater = PixelSearch(665, 400, 675, 415, 0x486468, 7)  

If Not ( @error ) Then   
	 MouseClick("primary",700-150, 350-150,3, 0)   
Else
   Return True
EndIf

EndFunc

func closetoledge()

Local $ledge = PixelSearch(665, 400, 675, 415, 0x3f2d23, 4)  

If Not ( @error ) Then   
	 MouseClick("primary",700+150, 350+150,3, 0)   
Else
   Return True
EndIf

EndFunc

func move()
   
If closetoledge() Then
   If deepWater() Then
	  If nearWater() Then   
		 MouseClick("primary",820+150, 350-150,3, 0)
	  EndIf
   EndIf
EndIf
EndFunc

;Checks to see if in waypoint
func checkLocation()
   $hImageTown =_GDIPlus_ImageLoadFromFile($fileTown) ;this is a Town
   $hBitmapTown = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageTown)
   
	  $checkTown  = _ImageSearch($hBitmapTown, 1, $x, $y, 20, 0) 
	  if $checkTown > 0 Then
		 ;MsgBox(0, "In Town", "Yes")
		 return True
	  Else
		 ;MsgBox(0, "In Town", "No")
		 return False
	  EndIf	
	  
_GDIPlus_ImageDispose($hImageTown)
   EndFunc

func timeOut($timeDiff)   
   
   If (($timeDiff/1000) >= 110) Then	  
	 writeLog("TimedOut Run")
	   return True
   else 
	 return False
   EndIf
EndFunc
   
   
WinActivate('Path of Exile')
GUISetState(@SW_SHOW)
local $TIMER = TimerInit()
local Const $TIMEOUT = 150000; 150 seconds	  
Local $timeDiff = 0
While 1
   if timeOut(TimerDiff($TIMER)) = True Then   
	  portalTown()  
	  inTown()
   EndIf
   

$itemFinding = 0
$opened = 0 ;opened chest
$x = 0
$y = 0
$timed = 0


$hImageChest1 =_GDIPlus_ImageLoadFromFile($fileA) ;this is a chest
$hBitmapChest1 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageChest1)

$hImageChest2 =_GDIPlus_ImageLoadFromFile($fileB) ;this is a chest2
$hBitmapChest2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageChest2)

$hImageC =_GDIPlus_ImageLoadFromFile($fileC) ;this is the door
$hBitmapC = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageC)

$hImageOrb =_GDIPlus_ImageLoadFromFile($file1) ;this is a orb	
$hBitmapOrb = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageOrb)

$hImageChisel =_GDIPlus_ImageLoadFromFile($fileChisel) ;this is a chisel
$hBitmapChisel = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageChisel)

$hImageGem =_GDIPlus_ImageLoadFromFile($file2) ;this is a gem
$hBitmapGem = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageGem)

;$chest1  = _ImageSearch($hBitmapChest1, 1, $x, $y, 20, 0) ;Zero will search against your active screen
;$chest2 = _ImageSearch($hBitmapChest2, 1, $x, $y, 20, 0) 
$doorNearby = _ImageSearch($hBitmapC, 1, $x, $y, 20, 0) ;door nearby

$chest2 = 0
$chest1  = 0

$orbNearby = _ImageSearch($hBitmapOrb, 1, $x, $y, 20, 0)
$gemNearby = _ImageSearch($hBitmapGem, 1, $x, $y, 20, 0)
$chiselNearby = _ImageSearch($hBitmapChisel, 1, $x, $y, 20, 0)
 
  Local $searchTime = 5
If $gemNearby > 0 Then
   ;Getting Gem
   GemSearch()
ElseIf $orbNearby > 0 Then
	;Getting Orb
	OrbSearch()
ElseIf $chiselNearby > 0 Then
	;Getting Orb
	chiselSearch()
ElseIf $doorNearby > 0 Then
	;Found Door	
	 MouseClick("primary",488, 553,3, 0)   
	 sleep(5000)
	doorSearch()	
	portalTown()	
	  inTown()
ElseIf $chest1  > 0 Then	
	chestSearch()	
ElseIf $chest2 > 0 Then	
	sleep(1000)   
	chestSearch()	
Else
	;Nothing Found
	if $searchTime > 4 Then	   
	   
	  move()
	  
	  if Mod($speedPot, 8) = 0 then
		 send("3")
	  ElseIf Mod($speedPot,30) = 0 Then
		 send("4")
	  endif 
	  
	  $speedPot = $speedPot +1
	EndIf
 EndIf
 
 
_GDIPlus_ImageDispose($hImageChest1)
_GDIPlus_ImageDispose($hImageChest2)
_GDIPlus_ImageDispose($hImageOrb)
_GDIPlus_ImageDispose($hImageGem)
_GDIPlus_ImageDispose($hImageChisel)
_GDIPlus_ImageDispose($hImageC)
WEnd

Func TogglePause()
    $Paused = Not $Paused
    While $Paused
        Sleep(10)
        ToolTip('Script is "Paused"', 0, 0)
    WEnd
    ToolTip("")
 EndFunc
 Func ToggleExit()
	
    Exit
 EndFunc
_GDIPlus_Shutdown()